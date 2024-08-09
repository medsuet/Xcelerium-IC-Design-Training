# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/restoring_division.sv
VERILOG_SOURCES += $(PWD)/controller.sv 
VERILOG_SOURCES += $(PWD)/wrapper/tb_restoring_division.sv
# use VHDL_SOURCES for VHDL files
VCD = restoring-division-algorithm.vcd

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = tb_restoring_division

# MODULE is the basename of the Python test file
MODULE = testbench

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim


clean_files:
	rm -rf results.xml __pycache__ sim_build

wave:
	gtkwave $(PWD)/$(VCD)
