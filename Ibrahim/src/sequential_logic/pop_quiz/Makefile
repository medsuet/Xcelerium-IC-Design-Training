# Makefile for the pop_quiz Verilog project

# Variables
SRC_DIR = src
TEST_DIR = test

SRC_FILES = $(SRC_DIR)/pop_quiz.sv
TB_FILE = $(TEST_DIR)/pop_quiz_tb.sv

# Top module in testbench
TB_MODULE = pop_quiz_tb

# VCD file name
VCD_FILE = pop_quiz.vcd
VSIM_CMD = vsim -c -do "run -all; quit"

# Default target
all: compile simulate

# Compile the Verilog files
compile:
	@echo "Compiling Verilog files..."
	vlib work
	vlog $(SRC_FILES) $(TB_FILE)
	@echo "Compilation complete."

# Simulate the testbench
simulate:
	@echo "Simulating the testbench..."
	$(VSIM_CMD) $(TB_MODULE)
	@echo "Simulation complete."

# View the waveform in GTKWave
view: simulate
	@echo "Opening waveform in GTKWave..."
	gtkwave $(VCD_FILE)

# Clean up generated files
clean:
	@echo "Cleaning up generated files..."
	rm -rf work transcript vsim.wlf $(VCD_FILE)

# Display help information
help:
	@echo "Usage:"
	@echo "  make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  all      - Compile and simulate"
	@echo "  compile  - Compile the Verilog files"
	@echo "  simulate - Simulate the testbench"
	@echo "  view     - View the waveform in GTKWave"
	@echo "  clean    - Clean up generated files"
	@echo "  help     - Display this help information"

# Declare phony targets
.PHONY: all compile simulate view clean help