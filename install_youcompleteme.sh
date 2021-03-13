#!/bin/bash -ex
#vim -c "PluginInstall" -c "q" -c "q"
cd ~/.vim/bundle/YouCompleteMe
python3 install.py --clangd-completer

