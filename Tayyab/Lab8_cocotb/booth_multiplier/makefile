
SOURCES = src/booth_multiplier.sv src/datapath.sv src/controller.sv src/counter.sv
TB = boothmultiplier_tb.py

# simulator
SIM ?= verilator

# language
TOPLEVEL_LANG ?= verilog

# source files
VERILOG_SOURCES = $(SOURCES)

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = booth_multiplier

# MODULE is the basename of the Python test file
MODULE = $(basename $(notdir $(TB)))
export PYTHONPATH := $(PWD)/sim:$(PYTHONPATH)

EXTRA_ARGS += --trace --trace-structs

# include cocotb's make rules to take care of the simulator setup 
include $(shell cocotb-config --makefiles)/Makefile.sim
