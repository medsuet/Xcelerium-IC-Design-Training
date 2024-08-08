# Makefile for RISC-V Assembly Exercises

# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike

# Source directory
SRC_DIR = src

all: $(PROG)

$(PROG): $(SRC_DIR)/$(PROG).s
	$(AS) -o $(SRC_DIR)/$(PROG).o $(SRC_DIR)/$(PROG).s
	$(LD) -T $(SRC_DIR)/linker.ld -o $(PROG) $(SRC_DIR)/$(PROG).o

# Rule to run with Spike
run: $(PROG)
	$(SPIKE) $(PROG)

# Rule to debug with Spike
debug: $(PROG)
	$(SPIKE) -d --log-commits $(PROG)

# Clean up
clean:
	rm -f $(SRC_DIR)/*.o $(PROG)

.PHONY: all run debug clean

help:
	@echo "Usage:"
	@echo "  make all PROG=<program_name>    - Assemble and link the specified RISC-V assembly program"
	@echo "  make run PROG=<program_name>    - Run the specified program with Spike"
	@echo "  make debug PROG=<program_name>  - Debug the specified program with Spike"
	@echo "  make clean                      - Clean up temporary files"

