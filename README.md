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
```    

Compile the ycm_core
```bash
    cd ~
    mkdir ycm_build
    cd ycm_build
    cmake -G ""
```


# How to build LLVM 5.0 on CentOS 
1. Download source file to specific folders refer to the section Git Mirror on the link http://llvm.org/docs/GettingStarted.html
   If you want to add clang-tool(e.g. clang-tidy), you need download the repo refer to http://clang.llvm.org/docs/ClangTools.html
2. Configure and build the LLVM refer to http://llvm.org/docs/GettingStartted.html

# How to use clang-rename
Use OpenCV for example.
Download OpenCV source file 
```bash
git clone https://github.com/opencv/opencv.git
cd opencv
mkdir build
cd build
cmake -D CMAKE_EXPORT_COMPILE_COMMANDS=ON -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D BUILD_DOCS=ON -D BUILD_EXAMPLES=ON -D ENABLE_PRECOMPILED_HEADERS=OFF ..
cp compile_commands.json ..
```

clang-rename.py: https://reviews.llvm.org/diffusion/L/browse/clang-tools-extra/trunk/clang-rename/tool/clang-rename.py;282388?

# How to install vim8.0 On CentOS
sudo yum groupinstall 'Development tools' -y
sudo yum install ncurses ncurses-devel wget git -y

cd ~/Downloads
wget ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2
tar -xjf vim-8.0.tar.bz2
cd vim80
sudo make -j8 && sudo make install

# How to use bear to generate database


