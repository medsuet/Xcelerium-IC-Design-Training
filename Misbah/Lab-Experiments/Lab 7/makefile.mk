# Makefile for RISC-V Assembly Exercises

# Compiler and emulator
AS = /usr/bin/riscv64-unknown-elf-as
LD = /usr/bin/riscv64-unknown-elf-ld
SPIKE = spike
PROG = # file name without extension

# Default target
all: $(PROG)

# Rule to assemble and link
$(PROG): $(PROG).s
	$(AS) -o $(PROG).o $(PROG).s
	$(LD) -o $(PROG) $(PROG).o

# Rule to run with Spike
run: $(PROG)
	$(SPIKE) $(PROG)

# Rule to debug with Spike
debug: $(PROG)
	$(SPIKE) -d --log-commits $(PROG)

# Clean up
clean:
	rm -f *.o $(PROG)

.PHONY: all run debug clean
