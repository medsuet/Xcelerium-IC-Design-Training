# Makefile for Verilog simulation

# File names
VERILOG_FILES = Multiplier.sv Multiplier_tb.sv
TOP_MODULE = Multiplier_tb
OUTPUT_FILE = out
VCD_FILE = dump.vcd

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Default target
all: compile simulate view

# Compile the design and testbench
compile:
	$(IVERILOG) -o $(OUTPUT_FILE) -g2012 $(VERILOG_FILES)

# Run the simulation
simulate:
	$(VVP) $(OUTPUT_FILE)

# View the results using gtkwave
view:
	$(GTKWAVE) $(VCD_FILE)

# Clean up generated files
clean:
	rm -f $(OUTPUT_FILE) $(VCD_FILE)
