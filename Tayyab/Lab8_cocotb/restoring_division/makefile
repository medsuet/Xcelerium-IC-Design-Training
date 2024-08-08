
SOURCES = src/restoring_division.sv src/datapath.sv src/controller.sv src/counter.sv
TB = restoring_division_tb.py

# simulator
SIM ?= verilator

# language
TOPLEVEL_LANG ?= verilog

# source files
VERILOG_SOURCES = $(SOURCES)

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = restoring_division

# MODULE is the basename of the Python test file
MODULE = $(basename $(notdir $(TB)))
export PYTHONPATH := $(PWD)/sim:$(PYTHONPATH)

EXTRA_ARGS += --trace --trace-structs

# include cocotb's make rules to take care of the simulator setup 
include $(shell cocotb-config --makefiles)/Makefile.sim
