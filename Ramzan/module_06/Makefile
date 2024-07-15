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
all: $(PROG)

# Rule to assemble and link
# Compile specific file from cmd-line argument
%: %.s
	rm -f *.o $(PROG) # clean executable and .o files before compiling - multiple files won't be executed in 'debug' and 'run' targets
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
