#!/bin/bash -ex

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#make sure to install the ripgrep/bat/fd tool
#for ubuntu we can install via 1)download the deb package; 2)dpkg -i xxx.deb
#
#https://github.com/BurntSushi/ripgrep
#https://github.com/sharkdp/fd
#https://github.com/sharkdp/bat
