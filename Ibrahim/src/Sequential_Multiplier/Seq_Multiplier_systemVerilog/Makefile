# Variables
SRC_FILES = src/seq_multiplier.sv 
TEST_FILES = test/tb_seq_multiplier.sv
TOP_MODULE = tb_seq_multiplier
WAVEFORM_FILE = multiplier.vcd
COMPILER_IVERILOG = iverilog
SIMULATOR_IVERILOG = vvp
COMPILER_VSIM = vlog
SIMULATOR_VSIM = vsim -c

# Default target
all: run

# Select the simulator
ifeq ($(sim),vsim)
    COMPILER = $(COMPILER_VSIM)
    SIMULATOR = $(SIMULATOR_VSIM)
    SIM_FLAGS = -do "run -all; exit"
else
    COMPILER = $(COMPILER_IVERILOG)
    SIMULATOR = $(SIMULATOR_IVERILOG)
    SIM_FLAGS = 
endif

# Compile the SystemVerilog code
compile:
	@echo "Compiling SystemVerilog code..."
ifeq ($(sim),vsim)
	@echo "Compiling using VSIM"
	$(COMPILER) $(SRC_FILES)
	$(COMPILER) $(TEST_FILES)
else
	@echo "Compiling using IVERILOG"
	$(COMPILER) -g2012 -o $(TOP_MODULE) $(SRC_FILES) $(TEST_FILES)
endif

# Run the simulation
run: compile
	@echo "Running the simulation..."
ifeq ($(sim),vsim)
	@echo "Running simulation using VSIM"
	vlib work
	$(SIMULATOR) $(SIM_FLAGS) $(TOP_MODULE)
else
	@echo "Running simulation using IVERILOG"
	$(SIMULATOR) $(TOP_MODULE)
endif

# View the waveform
view: $(WAVEFORM_FILE)
	@echo "Viewing the waveform in GTKWave..."
	gtkwave $(WAVEFORM_FILE)

# Clean up generated files
clean:
	@echo "Cleaning up generated files..."
	rm -f $(TOP_MODULE) $(WAVEFORM_FILE)
	@echo "Removing the work library..."
	rm -rf work

# Help target
help:
	@echo "Makefile targets:"
	@echo "  make            - Compile and run the simulation (default target (iverilog))."
	@echo "  make sim=vsim   - Compile and run the simulation using ModelSim."
	@echo "  make sim=iverilog - Compile and run the simulation using Icarus Verilog."
	@echo "  make compile    - Compile the SystemVerilog source files only using iverilog."
	@echo "  make run        - Run the simulation only using iverilog."
	@echo "  make view       - View the waveform in GTKWave."
	@echo "  make clean      - Remove the compiled executable, waveform file, and work library."
	@echo "  make help       - Display this help message."

# Phony targets
.PHONY: all compile run view clean help
