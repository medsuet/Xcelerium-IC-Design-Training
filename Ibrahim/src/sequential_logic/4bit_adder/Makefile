# Makefile for compiling and simulating Verilog files using ModelSim

# Directories
SRC_DIR = src
TEST_DIR = test

# Files
VERILOG_FILES = $(SRC_DIR)/adder.sv $(TEST_DIR)/adder_tb.sv
TB_MODULE = tb_sequential_adder
VCD_FILE = sequential_adder.vcd

# Simulation command
VSIM_CMD = vsim -c -do "run -all; exit"

# Targets
all: compile simulate

# Compile the Verilog files
compile:
	@echo "Compiling Verilog files..."
	vlib work
	vlog $(VERILOG_FILES)
	@echo "Compilation complete."

# Simulate the testbench
simulate:
	@echo "Simulating the testbench..."
	$(VSIM_CMD) $(TB_MODULE)
	@echo "Simulation complete."

# View the waveform
view: $(VCD_FILE)
	@echo "Opening waveform in GTKWave..."
	gtkwave $(VCD_FILE)

# # Ensure the VCD file is up-to-date
# $(VCD_FILE): simulate
# 	@echo "Simulation complete. Moving VCD file to current directory..."
# 	mv $(VCD_FILE) .

# Clean the build directory
clean:
	@echo "Cleaning up..."
	rm -rf work
	rm -f $(VCD_FILE)
	@echo "Clean complete."

# Help target to give instructions
help:
	@echo "Makefile for compiling and simulating Verilog files using ModelSim"
	@echo
	@echo "Targets:"
	@echo "  all      : Compile and simulate the waveform"
	@echo "  compile  : Compile the Verilog files"
	@echo "  simulate : Simulate the testbench"
	@echo "  view     : View the waveform in GTKWave"
	@echo "  clean    : Clean the build directory and generated files"
	@echo "  help     : Display this help message"
	@echo
	@echo "Usage:"
	@echo "  make all     : To compile and simulate the waveform"
	@echo "  make view    : To just view the waveform if the VCD file already exists"
	@echo "  make clean   : To clean the build directory and generated files"
	@echo "  make help    : To display this help message"

.PHONY: all compile simulate view clean help
