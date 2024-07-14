
## About


## Build
General form of make commands:

`make <action> FILE="filename"`

For example: `make assemble FILE="example.s"` assembles example.s and outputs example.o

### Actions:
`assemble`: Assemble an assembly file.\
`link`: Link object file using $(LINKERSCRIPT). The default is link.ld. Generates execuatble with .elf extention.\
`dump`: Disassembles a binary file and outputs assembly in a .s text file with same filename.\
`compile`: Compiles a c program and generates assembly. Modifes toolchain output to enable running on spike.\
`build_as`: Assemble and link an assembly file.\
`build_c`: Compile, assemble and link a c file.\
`spike`: Assembles, links and runs the specified file on Spike simulator in debug mode.\
`spikelog`: Runs the specified file on Spike simulator in debug mode with --log-commits flag.\
`clean`: Removes all .o , .elf , .o.s , .elf.s files (the last two extentions are for disassembled files).

### Requirements:
1. RISCV GNU Toolchain. Can be installed using `sudo apt-get install gcc-riscv64-unknown-elf`\
2. Spike (for `spike` and `spikelog` targets).
