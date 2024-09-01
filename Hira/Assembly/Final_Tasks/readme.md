# RISC-V Toolchain Setup and Assembly Code Generation

## Overview

This README provides instructions for configuring the RISC-V toolchain, installing Spike, and generating assembly code from a C program.

## Configure the RISC-V Toolchain

To install the RISC-V toolchain, run the following command:


`udo apt-get install gcc-riscv64-unknown-elf`
`Install Spike`


Spike is the RISC-V ISA simulator. Use the following bash script to download and install Spike:


```bash
git clone https://github.com/riscv/riscv-isa-sim.git`
cd riscv-isa-sim
mkdir build
cd build
../configure --prefix=/opt/riscv
make
sudo make install
```

####Add Spike to the Environment Path

To make Spike accessible from any terminal, add it to your environment path. Update the path according to your machine:

```bash
export PATH=$PATH:/opt/riscv/bin
```

You can add the above line to your .bashrc or .zshrc file to make this change permanent.

## Generate Assembly Code from a C Program
To generate assembly code from a C program, use the following command:

```bash
riscv64-unknown-elf-gcc -S filename.c -o filename.S
```

Replace filename.c with the name of your C source file, and filename.S with the desired name of the output assembly file.
if found any error try commenting the header files


## Debugging with Spike
You can use Spike to debug your assembly code. Make sure Spike is installed and added to your path as described above.