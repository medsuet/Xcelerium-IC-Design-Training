# 1. Configure the riscv toolchain
sudo apt-get install gcc-riscv64-unknown-elf
# 2. Run the following bash script to download and install spike
git clone https://github.com/riscv/riscv-isa-sim.git
cd riscv-isa-sim
mkdir build
cd build
../configure --prefix=/opt/riscv
make
sudo make install

# 3. Add spike to the environment path by writing the following script (update path 
# according to your machine)

# " export PATH=$PATH:/opt/riscv/bin" add this in bashrc.sh


