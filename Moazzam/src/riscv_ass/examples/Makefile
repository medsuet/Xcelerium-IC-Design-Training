# Makefile for RISC-V Assembly Exercises
# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike

# Use a variable for the source files
SRCS = $(wildcard *.s)

# Target executable
PROG = example

# Default target
all: $(PROG)

#rm -f *.o $(PROG)
$(PROG): $(SRCS)
	$(AS) -o $@.o $<
	$(LD) -T link.ld -o $@ $@.o

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