#!/bin/bash
# refer to https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source
#git clone https://github.com/vim/vim.git
wget ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2
tar -xjf vim-8.0.tar.bz2
yum groupinstall 'Development tools' -y
yum install ncurses ncurses-devel wget git -y
yum install perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed -y
sudo ln -s /usr/bin/xsubpp /usr/share/perl5/ExtUtils/xsubpp
cd vim80
./configure --with-features=huge \
    --enable-multibyte \
    --enable-rubyinterp=yes \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib64/python2.7/config \
    --enable-perlinterp=yes \
    --enable-luainterp=yes \
    --enable-gui=gtk2 \
    --enable-cscope \
    --prefix=/usr/local
make -j8 && sudo make install

sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
sudo update-alternatives --set editor /usr/local/bin/vim
sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
sudo update-alternatives --set vi /usr/local/bin/vim
