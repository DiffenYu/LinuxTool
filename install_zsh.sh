#!/bin/bash

install_zsh_for_ubuntu_1804()
{
    #Refer to https://linuxhint.com/install_zsh_shell_ubuntu_1804/
    sudo apt-get install zsh -y
    sudo apt-get install autojump -y
    sudo usermod -s /usr/bin/zsh $(whoami)

    #Install ohmyzsh
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_zsh_for_centos_76()
{
    #Refer to https://linuxhint.com/install_zsh_shell_ubuntu_1804/
    sudo yum install zsh autojump autojump-zsh -y
    sudo usermod -s /usr/bin/zsh $(whoami)

    #Install ohmyzsh
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_zsh_for_macos()
{
    brew install autojump
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_powerlevel_10k()
{
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}


main()
{
    OS=`uname -s`
    if [ ${OS} == "Darwin" ]; then
        install_zsh_for_macos
    elif [ ${OS} == "Linux" ]; then
        source /etc/os-release
        case $ID in
            debian|ubuntu|devuan)
                install_zsh_for_ubuntu_1804
                ;;
            centos|fedora|rhel)
                install_zsh_for_centos_76
                ;;
            *)
                exit 1
                ;;
        esac
    else
        echo "Other OS: ${OS}"
    fi
}

main
