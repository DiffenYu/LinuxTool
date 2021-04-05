#!/usr/bin/env bash

function err() {
    echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%z')]\033[31m ERROR\033[0m: $@" >&2
}

function msg() {
    echo -e "[$(date +'%Y-%m-%dT%H:%M:%S%z')]\033[37m INFO\033[0m: $@"
}

function check_install() {
    if [[ -x $(command -v tmux) ]]; then
        local tmux_ver=$(tmux -V | cut -d ' ' -f 2)
        if [[ $(echo "${tmux_ver} > 2" | bc) -eq 1 ]]; then
            msg "tmux ${tmux_ver}(>2) already installed"
            exit 1
        fi
    fi
}

function install_prerequisite() {
    sudo yum install centos-release-scl
    sudo yum install devtoolset-8 -y
    sudo yum install libevent-devel -y
    local cur_shell=$(echo $0)
    scl enable devtoolset-8 ${cur_shell}
}

function install_tmux() {
    [[ -d "./tmux_src" ]] && mkdir tmux_src
    pushd tmux_src
    wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
    tar -xvzf tmux-2.6.tar.gz
    cd tmux-2.6
    ./configure --prefix=/usr/local
    make -j$(nproc)
    sudo make install
    popd
}

function usage() {
    local self=$(basename $0)
    cat <<EOF
    Usage: $self [-a <aoption>] [-v <ver>] [-r] [-n] [-h]

    -a <aopt>: detail
    -n:        dry run, print out information only
    -h:        print the usage message
EOF
}

while getopts ":a:m:v:hnr" opt
do
    case $opt in
      a ) ADDRESS=$OPTARG;;
      r ) RESET=y;;
      n ) DRY_RUN=y;;
      h ) usage && exit;;
      * ) usage && exit 1;;
    esac
done
shift $((OPTIND-1))

function main() {
    check_install
    install_prerequisite
    install_tmux
}

main "$@"

