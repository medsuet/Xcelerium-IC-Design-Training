# Makefile for RISC-V Assembly Exercises

# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike

#PROG := example htif

# Find all .s files in the directory
SRCS := $(wildcard *.s)
PROG := $(SRCS:.s=)

# Default target
all: help

help:
	@echo "Usage:"
	@echo "  make <filename>"
	@echo "  Possible filenames are: [abs_diff, example, factorial, function, htif, insertion_sort, reverse_array]"
	@echo "	 make run			- Run the generated executeable file"
	@echo "	 make debug			- Debug the generated executeable file using spike"
	@echo "         make clean			- Clean the executeable and object files"

# Rule to assemble and link
# Compile specific file from cmd-line argument
%: %.s
	rm -f *.o $(PROG)
	$(AS) -o $@.o $<
	$(LD) -T linker.ld -o $@ $@.o

# Rule to run with Spike
run:
	for prog in $(PROG); do \
		if [ -f "$$prog" ]; then \
			$(SPIKE) $$prog; \
		fi; \
	done

# Rule to debug with Spike
debug:
	for prog in $(PROG); do \
		if [ -f "$$prog" ]; then \
			$(SPIKE) -d --log-commits $$prog; \
		fi; \
	done

# Clean up
clean:
	rm -f *.o $(PROG)

#.PHONY: all run debug clean
