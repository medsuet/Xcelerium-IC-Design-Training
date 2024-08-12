# Makefile for Verilog simulation using Verilator, and VSIM

# Define VSIM variables
VSIM = vsim
VSIM_FLAGS = -R

# Define Verilator variables
VERILATOR = verilator
VERILATOR_FLAGS = -Wall --cc

# Define simulation variables
SIM_BINARY = sim_bin

SIM_SRC_VSIM = src/binary_adder.sv \
					test/binary_adder_tb.sv

SIM_SRC_VERILATOR = $(SIM_SRC_VSIM)

COMP_OPTS_SV := --incr --relax

DEFINES_VER:= src/defines/verilator.svh

TB_TOP = binary_adder_tb
MODULE = binary_adder_tb


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
	@echo "  sim TOOL=verilator - Run simulation using Verilator"
	@echo "  clean         - Remove generated files"

# Simulation target
.PHONY: sim
sim:
ifdef TOOL
ifeq ($(TOOL),vsim)
	@echo "Running VSIM simulation..."
	vlog $(SIM_SRC_VSIM)
	vsim $(TB_TOP)

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
	gtkwave tb_sequential_adder.vcd

else
	@echo "Invalid TOOL specified. Please use 'vsim' or 'verilator'."
endif
else
	@echo "Please specify the simulation tool using 'make sim TOOL=vsim' or 'make sim TOOL=verilator'."
endif

# Clean target
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -rf $(SIM_BINARY) obj_dir