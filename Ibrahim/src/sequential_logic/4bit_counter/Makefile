# Makefile for 4-bit counter project

# Variables
SRC_DIR = src
TEST_DIR = test

SRC_FILES = $(SRC_DIR)/4bit_counter.sv
TB_FILES = $(TEST_DIR)/4bit_counter_tb.sv
TB_MODULE = counter_tb
VSIM_CMD = vsim -c -do "run -all; exit"

# Default target
all: compile simulate

# Compile target
compile:
	@echo "Compiling Verilog files..."
	vlib work
	vlog $(SRC_FILES)
	vlog $(TB_FILES)

# Simulate target
simulate: compile
	@echo "Simulating the testbench..."
	$(VSIM_CMD) $(TB_MODULE)

# View waveform target
view:
	@echo "Opening waveform in GTKWave..."
	gtkwave $(TEST_DIR)/counter.vcd &

# Clean the build directory
clean:
	@echo "Cleaning up..."
	rm -rf work
	rm -f $(VCD_FILE)
	@echo "Clean complete."

# Help target
help:
	@echo "Makefile Usage:"
	@echo "  all       : Compile the Verilog files and simulate the testbench"
	@echo "  compile   : Compile the Verilog files."
	@echo "  simulate  : Simulate the testbench."
	@echo "  view      : View the waveform in GTKWave."
	@echo "  clean     : Clean the generated files and directories."
	@echo "  help      : Display this help information."

.PHONY: all compile simulate view clean help

