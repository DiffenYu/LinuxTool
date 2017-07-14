# LinuxTool
vimrc
Replace the local ~/.vimrc with vimrc

tmux.conf
Replace the local ~/.vimrc with tmux.conf

install.sh
Use to install tmux and vim

Usage
    source install.sh

# How to compile ycm_core on CentOS
Install cmake
```bash
    sudo yum remove cmake -y 
    wget https://cmake.org/files/v3.8/cmake-3.8.0.tar.gz
    tar xf cmake-3.8.0.tar.gz
    cd cmake-3.8.0
    ./configure
    make -j8
    sudo make install
```

Download source code from http://releases.llvm.org/download.html
```bash
    cd ~/Downloads
    mkdir sourceINstallations
    cd sourceINstallations
    wget http://releases.llvm.org/4.0.0/llvm-4.0.0.src.tar.xz
    wget http://releases.llvm.org/4.0.0/cfe-4.0.0.src.tar.xz
    wget http://releases.llvm.org/4.0.0/compiler-rt-4.0.0.src.tar.xz
    wget http://releases.llvm.org/4.0.0/libcxx-4.0.0.src.tar.xz
    wget http://releases.llvm.org/4.0.0/libcxxabi-4.0.0.src.tar.xz
    tar xvJf cfe-4.0.0.src.tar.xz
    tar xvJf compiler-rt-4.0.0.src.tar.xz
    tar xvJf libcxx-4.0.0.src.tar.xz
    tar xvJf libcxxabi-4.0.0.src.tar.xz
    tar xvJf llvm-4.0.0.src.tar.xz
    mv llvm-4.0.0.src llvm-400
    mv cfe-4.0.0.src llvm-400/tools/clang
    mv compiler-rt-4.0.0.src llvm-400/projects/compiler-rt
    mv libcxx-4.0.0.src llvm-400/projects/libcxx
    mv libcxxabi-4.0.0.src llvm-400/projects/libcxxabi
    • build clang
    sudo yum-builddep -y llvm clang

    mkdir llvm_RELEASE_400_build
    cd llvm_RELEASE_400_build
    cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release DCMAKE_INSTALL_PREFIX=/usr/local ../llvm-400
    make -j8
    sudo make install

Compile the ycm_core
```bash
    cd ~
    mkdir ycm_build
    cd ycm_build
    cmake -G ""
```
