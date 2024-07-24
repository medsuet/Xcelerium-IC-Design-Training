# Makefile for RISC-V Assembly Exercises
ERR=err
SRC=src
OBJ=obj

# Give the file name on the terminal
# e.g make PROG=factorial

PROG ?=

# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike

# Default target
all: $(PROG)

# Rule to assemble and link
$(PROG): $(SRC)/$(PROG).s
	#rm -rf $(OBJ)
	mkdir -p $(OBJ)
	$(AS) -o $(OBJ)/$(PROG).o $(SRC)/$(PROG).s
	$(LD) -T link.ld -o $(OBJ)/$@ $(OBJ)/$(PROG).o

# Rule to run with Spike
run: $(PROG)
	$(SPIKE) $(PROG)

# Rule to debug with Spike
debug: $(PROG)
	$(SPIKE) -d --log-commits $(OBJ)/$(PROG)

# Logfile for debug
log: $(PROG)
	$(SPIKE) -l --log-commits $(OBJ)/$(PROG) 2> $(OBJ)/$(PROG).log

# Clean up
clean:
	rm -f *.o $(PROG)
	rm -rf obj

.PHONY: all run debug clean
