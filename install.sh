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

echo "Copy bashrc to ~/.bashrc"
cp -i bashrc ~/.bashrc
source ~/.bashrc

OS=`uname -s`
if [ ${OS} == "Darwin" ]; then 
    brew install tmux
elif [ ${OS} == "Linux" ]; then
    source /etc/os-release
    case $ID in
        debian|ubuntu|devuan)
            sudo get install tmux
            ;;
        centos|fedora|rhel)
            yumdnf="yum"
            if test "$(echo "$VERSION_ID >= 22" | bc)" -ne 0;
            then
                yumdnf="dnf"
            fi
            sudo $yumdnf install -y ctags automake gcc gcc-c++ kernel-devel python-devel python3-devel git tmux
            ;;
        *)
            exit 1
            ;;
    esac
else
    echo "Other OS: ${OS}"
fi

vim -c "PluginInstall" -c "q" -c "q"
