# Makefile for RISC-V Assembly Exercises

# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
CC = riscv64-linux-gnu-gcc
SPIKE = spike

#PROG := example htif

# Find all .s files in the directory
SRCS := $(wildcard *.s)
PROG := $(SRCS:.s=)
C_SRCS := $(wildcard *.c)
C_PROG := $(C_SRCS:.c=)

# Default target
all: $(PROG)

# Rule to assemble and link
# Compile specific file from cmd-line argument
%: %.s
	rm -f *.o $(PROG)
	$(AS) -o $@.o $<
	$(LD) -T linker.ld -o $@ $@.o
	$(CC) -c -S $(C_SRCS)

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
	rm -f *.o $(PROG) $(C_PROG).s

#.PHONY: all run debug clean
