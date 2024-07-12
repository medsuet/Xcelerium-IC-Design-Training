# Makefile for RISC-V Assembly Exercises

# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike
PK = pk

# Program name
PROG ?= 

# Linker script
LINKER_SCRIPT = link.ld

# Default target
all: help

# Help target
help:
	@echo "Please enter the program name (e.g., abs_diff, factorial, count_set_bits, reverse_array, insertion_sort)"
	@echo "Usage: make PROG=<program_name> build"

# Build target
build: $(PROG)

# Rule to assemble and link
$(PROG): $(PROG).s
	$(AS) -o $(PROG).o $<
	$(LD) -T $(LINKER_SCRIPT) -o $@ $(PROG).o

# Rule to run with Spike
run: $(PROG)
	$(SPIKE) $(PK) $(PROG)

# Rule to debug with Spike
debug: $(PROG)
	$(SPIKE) -d $(PK) $(PROG)

# Clean up
clean:
	rm -f *.o $(PROG)
