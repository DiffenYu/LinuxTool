#!/bin/bash -ex
echo "install common tool for development"

install_prequisite()
{
    OS=`uname -s`
    if [ ${OS} == "Darwin" ]; then 
        brew install tmux
    elif [ ${OS} == "Linux" ]; then
        source /etc/os-release
        case $ID in
            debian|ubuntu|devuan)
                sudo apt-get install tmux tig silversearcher-ag global exuberant-ctags
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

patch_vim()
{
    cp ./0001-Add-custom-sh-snippets.patch ~/.vim/bundle/vim-snippets/
    pushd ~/.vim/bundle/vim-snippets/
    git am -s < ./0001-Add-custom-sh-snippets.patch
    popd
}

install_vim_via_git()
{
    if [ -s ~/.vim/bundle/Vundle.vim ]; then
        echo " vundle existed"
    else
        echo "Clone vundle"
        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    fi
    cp vimrc ~/.vimrc
    vim -c "PluginInstall" -c "q" -c "q"
    patch_vim
}

install_vim_via_tar()
{
    tar -xvzf vim.tar.gz
    cp vim ~/.vim -r
    cp vimrc ~/.vimrc
    rm vim -rf
    patch_vim
}

copy_configure()
{
    mkdir -p ~/.ssh
    cp -rf ./media_key ~/.ssh/
    cp -rf ./media_key.pub ~/.ssh/
    cp -rf ./authorized_keys ~/.ssh/
    cp -rf ./gitconfig ~/.gitconfig
    cp -rf ./tmux.conf ~/.tmux.conf
    cp -rf ./sshconfig ~/.ssh/config
    cp -rf ./wgetrc ~/.wgetrc
    cp -rf ./tigrc.vim ~/.tigrc.vim
    cp -rf ./tigrc ~/.tigrc

    sudo chmod 0400 ~/.ssh/media_key
    sudo chmod 600 ~/.ssh/authorized_keys
    sudo chmod 600 ~/.ssh/config
    sudo chmod 700 ~/.ssh
    mkdir -p ~/.pip
    cp -rf ./pip.conf ~/.pip/
    sudo mkdir /root/.pip -p
    sudo cp -rf ./pip.conf ~/.pip/
    cat ./bashrc >> ~/.bashrc
    source ~/.bashrc
}


install_prequisite
#install_vim_via_tar
install_vim_via_git
copy_configure
