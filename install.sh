# Clone Vundle
if [ -s ~/.vim/bundle/Vundle.vim ]; then
    echo "existed"
else
    echo "Clone"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# Copy file
echo "Copy vimrc to ~/.vimrc"
cp vimrc ~/.vimrc
echo "Copy tmux.conf to ~/.tmux.conf"
cp tmux.conf ~/.tmux.conf
echo "Copy gitconfig to ~/.gitconfig"
cp gitconfig ~/.gitconfig
