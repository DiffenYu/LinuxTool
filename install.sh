#!/bin/bash

usage() {
    echo "Usage:"
    echo "> install separate component, use below install command"
    echo "  ./install.sh pre|vim|cpconfig|zsh"
}

this=$(pwd)

CONF_DIR="$this/configs"

install_prequisite() {
    OS=`uname -s`
    if [ ${OS} == "Darwin" ]; then 
        brew install cmake tmux tig wget autojump universal-ctags
    elif [ ${OS} == "Linux" ]; then
        source /etc/os-release
        case $ID in
            debian|ubuntu|devuan)
                apt-get install tmux tig silversearcher-ag global exuberant-ctags
                ;;
            centos|fedora|rhel)
                yumdnf="yum"
                if test "$(echo "$VERSION_ID >= 22" | bc)" -ne 0;
                then
                    yumdnf="dnf"
                fi
                sudo $yumdnf install -y tmux tig cmake global
                ;;
            *)
                exit 1
                ;;
        esac
    else
        echo "Other OS: ${OS}"
    fi
}

install_vim() {
    cp ${CONF_DIR}/vimrc ~/.vimrc
    vim -c "PluginInstall" -c "q" -c "q"
}

copy_configure() {
    echo "copy configure"
    cp -rf ${CONF_DIR}/gitconfig ~/.gitconfig
    cp -rf ${CONF_DIR}/tmux.conf ~/.tmux.conf
    cp -rf ${CONF_DIR}/tigrc.vim ~/.tigrc.vim
    cp -rf ${CONF_DIR}/tigrc ~/.tigrc
}

install_zsh_for_ubuntu() {
    sudo apt-get install zsh wget -y
    sudo apt-get install autojump -y
    sudo usermod -s /usr/bin/zsh $(whoami)
}

install_zsh_for_centos() {
    sudo yum install zsh autojump autojump-zsh wget -y
    sudo usermod -s /usr/bin/zsh $(whoami)
}

install_zsh_for_macos() {
    brew install autojump wget
}

post_install_zsh()
{
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/rupa/z.git $HOME/z
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    mv ~/.zshrc ~/.zshrc_bak
    cp ${CONF_DIR}/zshrc ~/.zshrc
    sed "5 iexport ZSH="$HOME/.oh-my-zsh"" -i ~/.zshrc
}

install_zsh() {
    OS=`uname -s`
    if [ ${OS} == "Darwin" ]; then
        install_zsh_for_macos
    elif [ ${OS} == "Linux" ]; then
        source /etc/os-release
        case $ID in
            debian|ubuntu|devuan)
                install_zsh_for_ubuntu
                ;;
            centos|fedora|rhel)
                install_zsh_for_centos
                ;;
            *)
                exit 1
                ;;
        esac
    else
        echo "Other OS: ${OS}"
    fi
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    post_install_zsh
    
    # TODO
    # install fd refer to https://github.com/sharkdp/fd
}

shopt -s extglob
if [[ $# -gt 0 ]]; then
    case $1 in
        usage )
            exit 0
            ;;
        pre )
            shift
            install_prequisite $@
            exit 0
            ;;
        vim )
            shift
            install_vim $@
            exit 0
            ;;
        cpconfig )
            shift
            copy_configure $@
            exit 0
            ;;
        zsh )
            shift
            install_zsh $@
            exit 0
            ;;
        * )
            echo 'error: wrong input parameter!'
            usage
            exit 1
            ;;
    esac
else
    usage
fi

