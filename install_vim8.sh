#!/bin/bash -ex
echo "install vim8 for development"
# refer to https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source

build_vim8_ubuntu()
{
    [ -d ~/Downloads ] || mkdir -p ~/Downloads
    pushd ~/Downloads
    [ -d "vim" ] || git clone https://github.com/vim/vim.git
    pushd vim
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-python3interp=yes \
        --with-python3-config-dir=$(python3-config --configdir) \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr/local
    make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
    sudo make install
    sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
    sudo update-alternatives --set editor /usr/local/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
    sudo update-alternatives --set vi /usr/local/bin/vim
    popd
    popd
}

build_vim8_centos()
{
    [ -d ~/Downloads ] || mkdir -p ~/Downloads
    pushd ~/Downloads
    [ -d "vim" ] || git clone https://github.com/vim/vim.git
    #sudo yum remove vim vim-runtime gvim #this command will remove the sudo
    pushd vim
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-python3interp=yes \
        --with-python3-config-dir=$(python3-config --configdir) \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr/local
    make VIMRUNTIMEDIR=/usr/local/share/vim/vim82
    sudo make install
    sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
    sudo update-alternatives --set editor /usr/local/bin/vim
    sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
    sudo update-alternatives --set vi /usr/local/bin/vim
    popd
    popd
        #--enable-pythoninterp=yes \
        #--with-python-config-dir=/usr/lib64/python2.7/config \ #cannot compatiable with python2 and python3 together
}

install_vim8()
{
    OS=`uname -s`
    if [ ${OS} == "Darwin" ]; then 
        brew install tmux
    elif [ ${OS} == "Linux" ]; then
        source /etc/os-release
        case $ID in
            debian|ubuntu|devuan)
                sudo apt install libncurses5-dev libgnome2-dev libgnomeui-dev \
                    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
                    libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
                    python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git
                build_vim8_ubuntu
                ;;
            centos|fedora|rhel)
                yumdnf="yum"
                if test "$(echo "$VERSION_ID >= 22" | bc)" -ne 0;
                then
                    yumdnf="dnf"
                fi
                sudo $yumdnf install -y ncurses-devel.x86_64 \
                    ruby ruby-devel lua lua-devel luajit \
                    luajit-devel ctags git python python-devel \
                    python3 python3-devel tcl-devel \
                    perl perl-devel perl-ExtUtils-ParseXS \
                    perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
                    perl-ExtUtils-Embed
                build_vim8_centos
                ;;
            *)
                exit 1
                ;;
        esac
    else
        echo "Other OS: ${OS}"
    fi
}

install_vim8
# with youcompleteme support with c/c++
# https://github.com/ycm-core/YouCompleteMe
# cd ~/.vim/bundle/YouCompleteMe
# python3 install.py --clangd-completer

