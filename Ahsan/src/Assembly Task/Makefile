# Makefile for RISC-V Assembly Exercises

# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike


all: $(PROG)


$(PROG): $(PROG).s
	$(AS) -o $(PROG).o $(PROG).s
	$(LD) -T linker.ld -o $(PROG) $(PROG).o

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



help:
	@echo "Usage:"
	@echo "  make all PROG=<program_name>    - Assemble and link the specified RISC-V assembly program"
	@echo "  make run PROG=<program_name>    - Run the specified program with Spike"
	@echo "  make debug PROG=<program_name>  - Debug the specified program with Spike"
	@echo "  make clean                      - Clean up temporary files"

