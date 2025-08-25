# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
# defaults
SIM ?= icarus
SIM_ARGS = -lsequential_multiplier.log
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/seq_multiplier.sv
VERILOG_SOURCES += $(PWD)/seq_multiplier_con.sv
VERILOG_SOURCES += $(PWD)/wapper/seq_multiplier_tb.sv

# TOPLEVEL is the name of the toplevel module in your verilog or VHDL file
TOPLEVEL = seq_multiplier_tb

# MODULE is the basename of the pythone test file
MODULE = testbench

include $(shell cocotb-config --makefiles)/Makefile.sim