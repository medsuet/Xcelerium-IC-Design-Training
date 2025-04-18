SOURCES = src/bitsel.sv src/controller.sv src/counter.sv src/data_path.sv src/Extender.sv src/mux21.sv src/register16.sv src/register32.sv  src/seqMul.sv . src/controller.sv
TB = seqMul_tb.py

# simulator
SIM ?= vsim

# language
TOPLEVEL_LANG ?= verilog

# source files
VERILOG_SOURCES = $(SOURCES)

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = seqMul

# MODULE is the basename of the Python test file
MODULE = $(basename $(notdir $(TB)))
export PYTHONPATH := $(PWD)/Test:$(PYTHONPATH)

EXTRA_ARGS += --trace --trace-structs

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

