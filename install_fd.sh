#!/bin/bash -ex


install_fd()
{
    OS=`uname -s`
    if [ ${OS} == "Darwin" ]; then
        brew install fd
    elif [ ${OS} == "Linux" ]; then
        source /etc/os-release
        case $ID in
            debian|ubuntu|devuan)
                #sudo apt-get install -y fd-find #19.04 or above
                #sudo ln -s $(which fdfind) /usr/local/bin/fd
                wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-musl_8.2.1_amd64.deb
                sudo dpkg -i ./fd-musl_8.2.1_amd64.deb
                ;;
            centos)
                wget https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-v8.2.1-i686-unknown-linux-musl.tar.gz
                tar -xvzf ./fd-v8.2.1-i686-unknown-linux-musl.tar.gz
                sudo cp ./fd-v8.2.1-i686-unknown-linux-musl/fd /usr/local/bin
                sudo cp ./fd-v8.2.1-i686-unknown-linux-musl/fd.1 /usr/local/share/man/man1
                sudo mandb
                ;;
            *)
                exit 1
                ;;
        esac
    else
        echo "Other OS: ${OS}"
    fi
}

install_fd
