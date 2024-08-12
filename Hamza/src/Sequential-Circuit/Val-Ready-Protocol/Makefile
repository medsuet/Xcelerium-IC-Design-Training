# Makefile for Verilog simulation using Verilator, VSIM, and Iverilog

# Define VSIM variables
VSIM = vsim

# Define Verilator variables
VERILATOR = verilator
VERILATOR_FLAGS = -Wall --cc

# Define simulation variables
SIM_BINARY = sim_bin

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories and files for Sequential Multiplier
SIM_SRC = src/Controller.sv src/Datapath.sv src/Multiplier.sv test/Multiplier_tb.sv

# Source files for Verilator simulation
SIM_SRC_VERILATOR = $(SIM_SRC)

# Top-level testbench module
TB_TOP = Multiplier_tb
MODULE = Multiplier_tb

# Output and wave files
GTKWAVE = Multiplier_tb.vcd
OUTPUT_FILE = Multiplier_tb.vvp

COMP_OPTS_SV := --incr --relax

DEFINES_VER := src/defines/verilator.svh

# Default target
.PHONY: all
all: help

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
	@echo "  sim TOOL=verilator - Run simulation using Verilator"
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
	$(VSIM) $(TB_TOP)

else ifeq ($(TOOL),verilator)
	@echo "Running Verilator simulation..."
	verilator --trace -cc $(SIM_SRC_VERILATOR) $(DEFINES_VER) \
	  	  --top-module $(MODULE)     \
		  -Wno-DECLFILENAME 		 \
		  -Wno-WIDTH 				 \
		  -Wno-REDEFMACRO			 \
		  -Wno-INITIALDLY			 \
		  --exe ./test/$(TB_TOP).cpp \
		  --timing
	make -C obj_dir -f V$(MODULE).mk V$(MODULE)
	./obj_dir/V$(MODULE)
	gtkwave $(GTKWAVE)

else ifeq ($(TOOL),iverilog)
	$(IVERILOG) -g2012 -o $(OUTPUT_FILE) $(SIM_SRC)
	$(VVP) $(OUTPUT_FILE)
	gtkwave $(GTKWAVE)

else
	@echo "Invalid TOOL specified. Please use 'verlator', 'vsim' or 'iverilog'."
endif
else
	@echo "Please specify the simulation tool using 'make sim TOOL=verilator', 'make sim TOOL=vsim' or 'make sim TOOL=iverilog'."
endif

# Clean target
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -f $(OUTPUT_FILE) tb.vcd
