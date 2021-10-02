#!/bin/bash

post_install_zsh()
{
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    mv ~/.zshrc ~/.zshrc_bak
    sed "5 iexport ZSH="$HOME/.oh-my-zsh"" -i zshrc
    cp ./zshrc ~/.zshrc
}

post_install_zsh
