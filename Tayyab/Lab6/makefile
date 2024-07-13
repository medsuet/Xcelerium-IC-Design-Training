# Makefile for RISC-V Assembly Exercises
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
CC = riscv64-unknown-elf-gcc
OD = riscv64-unknown-elf-objdump
LINKERSCRIPT = link.ld

FILE = ""

# Default target
build_as: assemble link

build_c: compile assemble link

# Rule to assemble and link
assemble:
	@$(AS) -o $(basename $(FILE)).o $(basename $(FILE)).s

link:
	@$(LD) -T $(LINKERSCRIPT) $(basename $(FILE)).o -o $(basename $(FILE)).elf

dump:
	@$(OD) -D $(FILE) > $(FILE).s

compile:
	@$(CC) -S $(basename $(FILE)).c -o $(basename $(FILE)).s -T $(LINKERSCRIPT)

spike: assemble link
	@spike -d $(basename $(FILE)).elf

spikelog: assemble link
	@spike -d --log-commits $(basename $(FILE)).elf


clean:
	@rm -f *.o *.elf *.o.s *.elf.s