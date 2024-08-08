# Defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Source files
SOURCES_SV += ../define/array_mul.svh \
               ../src/array_multiplier_datapath.sv \
               ../src/array_multiplier_controller_valready.sv \
               ../src/array_multiplier.sv

# TOPLEVEL is the name of the top-level module in your Verilog or VHDL file
TOPLEVEL = array_multiplier

# MODULE is the basename of the Python test file
MODULE = array_multiplier_tb

# Include cocotb's make rules to handle simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# Override default simulator flags for Icarus Verilog
IVERILOG_ARGS += -g2012 -o $(SIM_BUILD)/simv

# Rules
all: $(SIM_BUILD)/simv

$(SIM_BUILD)/simv: $(SOURCES_SV) $(MODULE).py
	mkdir -p $(SIM_BUILD)
	iverilog $(IVERILOG_ARGS) $(SOURCES_SV) $(MODULE).py
	vvp $(SIM_BUILD)/simv

clean:
	rm -rf $(SIM_BUILD) *.vcd

.PHONY: all clean
