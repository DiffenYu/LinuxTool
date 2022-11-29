#!/bin/bash

post_install_zsh()
{
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/rupa/z.git $HOME/z
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    mv ~/.zshrc ~/.zshrc_bak
    sed "5 iexport ZSH="$HOME/.oh-my-zsh"" -i zshrc
    cp ./zshrc ~/.zshrc
}


post_install_zsh

