# Variables
SRC_DIR = src
TEST_DIR = test
SRC_FILE = $(SRC_DIR)/seq_multiplier.sv
TB_FILE = $(TEST_DIR)/tb_sequential_multiplier.sv

IVERILOG = iverilog
VVP = vvp
VSIM = vsim
GTKWAVE = gtkwave
VSIM_FLAGS = -c -do "run -all; quit"

IVERILOG_OUT = iverilog_sim.vvp
VSIM_OUT = modelsim_sim.out
VCD_FILE = val_ready.vcd

# Default target
all: help

# Icarus Verilog compile and run
iverilog: $(SRC_FILE) $(TB_FILE)
	@echo "Compiling with Icarus Verilog..."
	$(IVERILOG) -g2012 -o $(IVERILOG_OUT) $(TB_FILE) $(SRC_FILE)
	@echo "Running simulation with Icarus Verilog..."
	$(VVP) $(IVERILOG_OUT)

# ModelSim compile and run
vsim: $(SRC_FILE) $(TB_FILE)
	@echo "Compiling with ModelSim..."
	vlog $(SRC_FILE) $(TB_FILE)
	@echo "Running simulation with ModelSim..."
	$(VSIM) $(VSIM_FLAGS) tb_sequential_multiplier

# View waveform using GTKWave
view: 
	@echo "Opening waveform with GTKWave..."
	$(GTKWAVE) $(VCD_FILE)

# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -f $(IVERILOG_OUT) $(VSIM_OUT) $(VCD_FILE)
	rm -rf work

# Help target
help:
	@echo "Makefile for compiling and running simulations with Icarus Verilog and ModelSim"
	@echo
	@echo "Usage:"
	@echo "  make iverilog       Compile and run simulation with Icarus Verilog"
	@echo "  make vsim           Compile and run simulation with ModelSim"
	@echo "  make view           View waveform using GTKWave"
	@echo "  make clean          Clean up generated files"
	@echo "  make help           Display this help message"

# Phony targets
.PHONY: all iverilog vsim view clean help
