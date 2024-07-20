
## RISC-V Toolchain and Spike Installation

Install the RISC-V toolchain
```bash
sudo apt-get install gcc-riscv64-unknown-elf
```
Clone the Spike repository from GitHub
```bash
git clone https://github.com/riscv/riscv-isa-sim.git
```
Navigate to the cloned repository 
```bash
cd riscv-isa-sim
```
Create a "build" directory
```bash
mkdir build
```
Move to "build" directory
```bash
cd build
```
Configure the build environment
```bash
../configure --prefix=/opt/riscv
```
Compile Spike
```bash
make
```
Install Spike
```bash
sudo make install
```

Open .zshrc or .bashrc file and write at the end and save file 
```bash
export PATH=$PATH:/opt/riscv/bin

```

## Installation

Install gcc compiler 
```bash
  sudo apt install gcc
```
Install python 
```bash
  sudo apt install python3
```

Install tcl 
```bash
  sudo apt-get install tcl
```
 
Install make
```bash
  sudo apt install make
```

Building Essential
```bash
  sudo apt install build-essential
```

## Run assembly files
Running assembly files using makefile
```bash
make PROG=(filename)   #filename_without_extension
```
For debugging
```bash
make PROG=(filename) debug   #filename_without_extension
```
Clean
```bash
make Clean
```

 



## Run C files
To compile a C file, you can use the `gcc` compiler.

Making object file
```bash
  gcc -c (filename).o (filename).c
```
Making Executable
```bash
  gcc -o (filename) (filename).o
```
Running the Executable

```bash
  ./filename
```

## Run python files
Running python files

```bash
  python3 (filename).py
```

## Run Bash scripts
Make script executable (changing permission)

```bash
 chmod +x (filename).sh
```
Run

```bash
 ./(filename).sh
```

## Run TCL scripts
Running TCL scripts

```bash
  tclsh (filename).tcl
```

 