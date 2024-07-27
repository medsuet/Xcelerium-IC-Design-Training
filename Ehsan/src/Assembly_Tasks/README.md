
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

 





