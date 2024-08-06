# Compiler and emulator
TARGET=executeable
march  ?= rv64ima_zicsr
mabi ?= lp64
elf ?= elf64lriscv
OFLAG=O
isa=RV64IMAFDC_zicntr_zihpm
AS = /home/masooma/riscv/bin/riscv64-unknown-elf-as
LD = /home/masooma/riscv/bin/riscv64-unknown-elf-ld
CC = /home/masooma/riscv/bin/riscv64-unknown-elf-gcc
SPIKE = spike
PROG ?= main.S
CFILE ?= main.c
.PHONY: $(PROG:.S=.o) $(TARGET) run all debug assembly
all: $(TARGET)
	@echo "Done Compiling!!"
$(PROG:.S=.o): $(PROG)
	$(AS) -o $@ $< -march=$(march) -mabi=$(mabi)
$(TARGET): $(PROG:.S=.o)
	$(LD) -T ../linker.ld -o $@ $^ -m $(elf)
run: $(TARGET)
	$(SPIKE) -l --log-commits --isa=$(isa)  $(TARGET) 2> spike.log
debug: $(TARGET) $1
	$(SPIKE) -d --log-commits $(TARGET)
assembly: $(CFILE)
	$(CC) -S $(CFILE) -o ass.S
ass_optimize:
	$(CC) -S -$(OFLAG) $(CFILE) -o ass.S
clean:
	rm -f *.o $(TARGET)