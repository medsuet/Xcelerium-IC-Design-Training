# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/sequential_multiply.sv $(PWD)/sequential_multiply_controller.sv
# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = sequential_multiply

# MODULE is the basename of the Python test file
MODULE = testbench

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim


clean_files:
	rm results.xml
	rm -rf __pycache__ sim_build
