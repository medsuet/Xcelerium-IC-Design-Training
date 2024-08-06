# Set up the environment
TOPLEVEL_LANG = verilog
COCOTB = $(shell python3 -c "import cocotb; print(cocotb.__file__)")
PYTHONPATH = $(shell python3 -c "import os; import cocotb; print(os.path.dirname(cocotb.__file__))")

# Design and testbench files
TOPLEVEL = array_multiplier
MODULE = array_multiplier_tb
SRC_DIR = ./src
TB_DIR = ./tb
IVERILOG_ARGS = -g2012 -o simv
VPI_ARGS = -I $(COCOTB)/include

# Makefile rules
all: sim

sim: $(TOPLEVEL).v $(TB_DIR)/array_multiplier.py
	@echo "Running simulation..."
	iverilog $(IVERILOG_ARGS) -I $(COCOTB)/include -I $(SRC_DIR) $(SRC_DIR)/array_multiplier.sv $(TB_DIR)/array_multiplier.py
	vvp simv

clean:
	@echo "Cleaning up..."
	rm -f simv

.PHONY: all sim clean
