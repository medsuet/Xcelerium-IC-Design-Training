# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/restore.sv

# use VHDL_SOURCES for VHDL files

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = restore

# MODULE is the basename of the Python test file
MODULE = restore_tb_py

# include cocotb's make rules to take care of the sirestoreator setup
include $(shell cocotb-config --makefiles)/Makefile.sim