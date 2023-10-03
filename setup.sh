#! /bin/bash

# Install LLVM
git clone https://github.com/llvm/llvm-project.git
cd llvm-project
git checkout llvmorg-10.0.0
mkdir build
cd build
cmake -DLLVM_ENABLE_PROJECTS='polly;clang' -G "Unix Makefiles" ../llvm
make -j `nproc`
sudo make install

# Set up Morpher
cd Morpher
git submodule update --init --recursive
pip3 install -r python_requirements.txt
sudo apt-get install gcc-multilib g++-multilib
./build_all.sh

# Set up Versat
cd ../Versat
git submodule update --init --recursive

