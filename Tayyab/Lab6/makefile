# Makefile for RISC-V Assembly Exercises
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
CC = riscv64-unknown-elf-gcc
OD = riscv64-unknown-elf-objdump
LINKERSCRIPT = link.ld

FILE = ""

# Default target
help:
	cat readme.md

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
# compile
	@$(CC) -S $(basename $(FILE)).c -o $(basename $(FILE)).s -T $(LINKERSCRIPT)

# replace main with _start
	@sed -i 's/main/_start/g' $(basename $(FILE)).s
# remove last three lines to prevent return from main
	@head -n -3 $(basename $(FILE)).s > temp.tmp ; mv temp.tmp $(basename $(FILE)).s
# add signal test pass for Spike and ".global _start"
	@echo "end:\n    # Signal test pass to Spike\n    li t0, 1\n    la t1, tohost\n    sd t0, (t1)\n\n.section .tohost\n.align 3\ntohost: .dword 0\nfromhost: .dword 0\n.global _start\n" >> $(basename $(FILE)).s

spike: assemble link
	@spike -d $(basename $(FILE)).elf

spikelog: assemble link
	@spike -d --log-commits $(basename $(FILE)).elf


clean:
	@rm -f *.o *.elf *.o.s *.elf.s