# Makefile for RISC-V Assembly Exercises
# Compiler and emulator
AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
SPIKE = spike

# TARGETram name
TARGET = assemblytasks

# Default target
all: $(TARGET)

# Rule to assemble and link
$(TARGET): $(TARGET).s
	$(AS) -o $(TARGET).o $(TARGET).s
	$(LD) -T link.ld -o $(TARGET) $(TARGET).o

# Rule to run with Spike
run: $(TARGET)
	$(SPIKE) $(TARGET)

# Rule to debug with Spike
debug: $(TARGET)
	$(SPIKE) -d --log-commits $(TARGET)

# Clean up
clean:
	rm -f *.o $(TARGET)

.PHONY: all run debug clean
