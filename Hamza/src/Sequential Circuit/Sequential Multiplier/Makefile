# Makefile for Verilog simulation using VSIM and iverilog

# Define VSIM variables
VSIM = vsim
VSIM_FLAGS = -R

# Define simulation variables
SIM_BINARY = sim_bin

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories and files for Seq_Mult
SIM_SRC = src/Controller.sv src/Datapath.sv src/Multiplier.sv test/Multiplier_tb.sv
OUTPUT_FILE = out.vvp

TB_TOP = Multiplier_tb

# Default target
.PHONY: all
all: help

# Help target
.PHONY: help
help:
	@echo "Verilog Simulation Makefile"
	@echo "---------------------------"
	@echo "Targets:"
	@echo "  help          - Display this help message"
	@echo "  sim TOOL=vsim - Run simulation using VSIM"
	@echo "  sim TOOL=iverilog - Run simulation using IVerilog"
	@echo "  clean         - Remove generated files"

# Simulation target
.PHONY: sim
sim:
ifdef TOOL
ifeq ($(TOOL),vsim)
	@echo "Running VSIM simulation..."
	vlog $(SIM_SRC)
	$(VSIM) $(VSIM_FLAGS) $(TB_TOP)

else ifeq ($(TOOL),iverilog)
	$(IVERILOG) -g2012 -o $(OUTPUT_FILE) $(SIM_SRC)
	$(VVP) $(OUTPUT_FILE)
	gtkwave waveform.vcd

else
	@echo "Invalid TOOL specified. Please use 'vsim' or 'iverilog'."
endif
else
	@echo "Please specify the simulation tool using 'make sim TOOL=vsim' or 'make sim TOOL=iverilog'."
endif

# Clean target
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -f $(OUTPUT_FILE) waveform.vcd
