# RISC-V Assembly Exercises

This repository contains various RISC-V assembly programs, along with a Makefile to simplify the process of assembling, linking, running, and debugging these programs using the Spike RISC-V simulator.

## Directory Structure

Assembly_Task/
├── src/
│ ├── linker.ld
│ ├── p_1.s
│ ├── p_2.s
│ ├── p_3.s
│ ├── p_4.s
│ ├── p_5.s
│ ├── Task_1.c
│ ├── Task_1.s
│ ├── Task_1_toolchain.s
│ ├── Task_2.c
│ ├── Task_2.s
│ ├── Task_2_toolchain.s
│ ├── Task_3.s
├── Makefile
└── README.md

## Files

- **src/linker.ld**: Linker script for the RISC-V assembly programs.
- **src/p_1.s**, **src/p_2.s**, **src/p_3.s**, **src/p_4.s**, **src/p_5.s**: Assembly programs for various tasks.
- **src/Task_1.c**, **src/Task_2.c**: C source files for tasks.
- **src/Task_1.s**, **src/Task_2.s**, **src/Task_3.s**: Assembly source files for tasks.
- **src/Task_1_toolchain.s**, **src/Task_2_toolchain.s**: Toolchain-related assembly files.
- **Makefile**: Makefile to manage the assembly, linking, running, and debugging of the RISC-V assembly programs.
- **README.md**: This README file.

## Prerequisites

To assemble, link, and run the RISC-V assembly programs, you need to have the following tools installed:

- **RISC-V Toolchain**: Includes `riscv64-unknown-elf-as` (assembler) and `riscv64-unknown-elf-ld` (linker).
- **Spike**: The RISC-V simulator.

## Usage

### Assemble and Link

To assemble and link a specific RISC-V assembly program, use the `make all` command with the `PROG` variable set to the name of the program (without the `.s` extension). For example, to assemble and link `p_1.s`, use:

```
make all PROG=p_1
```
### Run
```
make run PROG=p_1
```
### Debug
```
make debug PROG=p_1
```
### clean
```
make clean
```

