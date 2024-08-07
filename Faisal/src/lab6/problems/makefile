# Makefile for RISC-V Assembly Exercises

# Compiler and emulator 
AS = riscv64-unknown-elf-as 
LD = riscv64-unknown-elf-ld 
SPIKE = spike 

# Program name
PROG ?= 


# Default target
all: prompt

# Help target
prompt:
	@echo "Please enter the program name (e.g., difference, factorial, count_set_bits, reverse_array, insertion_sort)"
	@echo "Usage: make PROG=<program_name> build"
 
# Build target
build: $(PROG)

# Rule to assemble and link 
$(PROG): $(PROG).s
	$(AS) -o $(PROG).o $<
	$(LD) -T link.ld -o $@ $(PROG).o

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
