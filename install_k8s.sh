#!/usr/bin/env bash

set -e

# IP of the primary interface on the host
HOST_IP=$(ip route get 1 | head -1 | awk '{print $7}')

DOCKER="sudo docker"
if [[ "$(id -u)" == "0" ]] || id -nG | grep -qw docker; then
  DOCKER="docker"
fi

ADDRESS=$HOST_IP      # API server address
VERSION=              # k8s stable version
OPTIONS="yes no auto" # valid options
MIRROR=auto           # mirror option
RESET=n               # reset cluster first
DRY_RUN=n             # dry run or not
OS=                   # operating system
MASTER=n              # setup as master node

function msg() {
  echo "> $@"
}

function err() {
  echo "> $@" >&2
}

function usage() {
  local self=`basename $0`
  cat <<EOF
Usage: $self [-a <addr>] [-m <opt>] [-v <ver>] [-r] [-n] [-h]
  Deploy k8s and setup master/worker node for local developent purpose

  -a <addr>: API server address, default: $ADDRESS
  -m <opt>:  mirror option [$OPTIONS], default: $MIRROR
  -v <ver>:  k8s version, default: using kubeadm stable version
  -r:        reset k8s cluster first, default: $RESET
  -n:        dry run, print out information only, default: $DRY_RUN
  -c:        install control panel (master node), default: $MASTER
  -h:        print the usage message
EOF

}

while getopts ":a:m:v:hcnr" opt
do
  case $opt in
    a ) ADDRESS=$OPTARG;;
    m ) MIRROR=$OPTARG
        if echo $OPTIONS | grep -v -w $MIRROR >/dev/null 2>&1; then
          echo "invalid mirror option $MIRROR"
          usage && exit 1
        fi
        ;;
    v ) VERSION=$OPTARG;;
    r ) RESET=y;;
    n ) DRY_RUN=y;;
    c ) MASTER=y;;
    h ) usage && exit;;
    * ) usage && exit 1;;
  esac
done
shift $((OPTIND-1))

for v in DOCKER HOST_IP ADDRESS VERSION MIRROR RESET DRY_RUN MASTER
do
  eval echo "$v: \${$v}"
done

[[ $DRY_RUN == "y" ]] && exit

function main() {
  ensure_nonroot
  get_os
  check_prerequisites
  ensure_swapoff
  [[ $OS == "centos" ]] && ensure_selinuxoff
  ensure_iptables
  need_mirror
  ensure_installed
  [[ $RESET == "y" ]] && reset_k8s
  [[ $MASTER == "y" ]] && init_k8s && install_helm

  msg "done"
  [[ $MASTER == "y" ]] && cat <<EOF
here are some useful commands:
- check status: kubectl get pods -A
- enable bash completion: source <(kubectl completion bash)
EOF
}

function get_os() {
  if [[ $(cat /etc/os-release | grep ubuntu | wc -l) != "0" ]]; then
    OS="ubuntu"
  else
    if [[ $(cat /etc/os-release | grep centos | wc -l) != "0" ]]; then
      OS="centos"
    else
      OS="unknown"
      err "Only Ubuntu/CentOS supported"
      exit 0
    fi
  fi
  msg "OS is $OS"
}

function check_prerequisites() {
  msg "check prerequisites"
  if [[ -z $(which curl) ]]; then
    err "curl is not available"
    exit 1
  fi
  if [[ -z $(which docker) ]]; then
    err "docker is not available"
    exit 1
  fi
  msg "check network"
  if ! curl -s -m 2 ifconfig.co >/dev/null; then
    err "can't access external network, continue for internal network scenario"
  fi
  msg "check docker pull"
  if ! $DOCKER pull hello-world >/dev/null 2>&1; then
    err "docker pull can't work, check docker configuration first"
    exit 1
  fi
}

NEED_MIRROR=n
function need_mirror() {
  msg "is mirror needed"
  if [[ $MIRROR == "auto" ]]; then
    msg "check whether we can access google cloud"
    if $DOCKER pull k8s.gcr.io/pause >/dev/null 2>&1; then
      MIRROR=no
    else
      MIRROR=yes
    fi
  fi
  if [[ $MIRROR == "yes" ]]; then
    NEED_MIRROR=y
  fi
  msg "need mirror: $NEED_MIRROR"
}

function ensure_installed() {
  msg "ensure k8s installed"
  if [[ -n $(which kubeadm) ]]; then
    msg "already installed"
  else
    local pkgs="kubelet-1.18.5 kubeadm-1.18.5 kubectl-1.18.5"
    case $OS in
      "centos")
        msg "install k8s on centos..."
        cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
        msg "yum update and install: $pkgs"
        sudo yum update -y && sudo yum install -y $pkgs
        sudo systemctl enable kubelet
        sudo systemctl start kubelet
        ;;
      "ubuntu")
        msg "install k8s on ubuntu..."
        local codename="xenial"  # the official doc use xenial for all
        local key="https://packages.cloud.google.com/apt/doc/apt-key.gpg"
        local src="https://apt.kubernetes.io/"
        local list="/etc/apt/sources.list.d/kubernetes.list"
        
        if [[ $NEED_MIRROR == "y" ]]; then
          key="https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg"
          src="https://mirrors.aliyun.com/kubernetes/apt/"
        fi

        msg "add $src to $list for $codename"
        curl -s $key | sudo apt-key add -
        cat <<EOF | sudo tee -a $list
deb $src kubernetes-$codename main
EOF

        msg "apt update and install: $pkgs"
        sudo apt update && sudo apt install -y $pkgs
        msg "no auto update for $pkgs"
        sudo apt-mark hold $pkgs
        ;;
      *)
        msg "unknown os, exit"
        exit 0
        ;;
    esac
  fi
}

function ensure_swapoff() {
  # k8s requires swapoff
  msg "ensure swap is off"
  local n=`cat /proc/swaps | wc -l`
  if (( n > 1 )); then
    local swap=$(systemctl list-units | perl -ne 'print $1 if /^\s+(dev-\w+\.swap)\s+/')
    if [[ -n $swap ]]
    then
      msg "disable swap device $swap"
      sudo systemctl mask $swap
    fi
    msg "disable any swap device in fstab"
    sudo perl -pi -e 's/^(.+none\s+swap.+)/#$1/ unless /^#/' /etc/fstab
    msg "swapoff -a"
    sudo swapoff -a
  else
    msg "no swap device"
  fi
}

function ensure_selinuxoff() {
  # k8s requires selinux off
  msg "ensure selinux is off"
  if [[ "$(getenforce)" != "Disabled" ]]; then
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    sudo setenforce 0
  else
    msg "selinux already disabled"
  fi
}

function ensure_iptables() {
  msg "ensure iptables see bridged traffic"
  local prefix="/proc/sys/net/bridge/bridge-nf-call-ip"
  if [[ "$(cat ${prefix}tables)" != "1" || "$(cat ${prefix}6tables)" != "1" ]]; then
    msg "bridge-nf-call-iptables is disabled, enable it"
    cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
    sudo sysctl --system
  fi
}

function ensure_nonroot() {
  if [[ $(id -u) == "0" ]]; then
    msg "should not run as root user to avoid confusion later!"
    exit 1
  fi
}

function reset_k8s() {
  msg "reset k8s"
  sudo kubeadm reset
  msg "release cni0 if any"
  if ip link show cni0 >/dev/null 2>&1; then
    sudo ip link set cni0 down
    sudo ip link delete cni0
  fi
}

function install_helm() {
  msg "install helm"
  if [[ -n $(which helm) ]]; then
    msg "already installed"
  else
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    if [[ -n $(which helm) ]]; then
      msg "helm installed"
    else
      err "failed to install helm, please install manually"
    fi
  fi
}

function init_k8s() {
  msg "initialize k8s"

  if kubectl cluster-info >/dev/null 2>&1; then
    msg "already initialized"
    return
  fi

  # different CNI addon requires different pod-network-cider, here is for flannel
  local cidr="10.244.0.0/16"
  local extra=
  msg "init k8s control-plane node, api:$ADDRESS, cidr:$cidr"
  if [[ $NEED_MIRROR  = "y" ]]; then
    local repo="registry.aliyuncs.com/google_containers"
    extra="--image-repository $repo"
    msg "mirror is required, use image repository: $repo"
  fi
  if [[ -z $VERSION ]]; then
    sudo kubeadm init --apiserver-advertise-address=$ADDRESS --pod-network-cidr=$cidr $extra
  else
    sudo kubeadm init --kubernetes-version=$VERSION --apiserver-advertise-address=$ADDRESS --pod-network-cidr=$cidr $extra
  fi

  # config
  msg "setup config to access cluster"
  mkdir -p $HOME/.kube
  sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

  # untaint master
  msg "allow to schedule pods on the master"
  kubectl taint nodes --all node-role.kubernetes.io/master-

  # install flannel to manage the network
  msg "install flannel"
  if [[ ! -e kube-flannel.yml ]]; then
    curl -O https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  fi
  # fix flannel oom kill
  sed -i "s/50Mi/100Mi/g" kube-flannel.yml
  kubectl apply -f kube-flannel.yml
}

main "$@"

