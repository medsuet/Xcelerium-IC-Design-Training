# Makefile for SystemVerilog simulation in iverilog

# File names
VERILOG_FILES = signed_comb_multiplier.sv signed_comb_multiplier_tb.sv
TOP_MODULE = signed_comb_multiplier_tb
OUTPUT_FILE = simulation.vvp
VCD_FILE = waveform.vcd

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

# Default target
all: compile simulate

# Compile the design along with testbench
compile:
	$(IVERILOG) -g2012 -o $(OUTPUT_FILE) $(VERILOG_FILES)

# This target will run simulation
simulate:
	$(VVP) $(OUTPUT_FILE)

# Run this target to view the results
view:
	$(GTKWAVE) $(VCD_FILE)

# Clean up generated files
clean:
	rm -f $(OUTPUT_FILE) $(VCD_FILE)

.PHONY: all compile simulate view clean
