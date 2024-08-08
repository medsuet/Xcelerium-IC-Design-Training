# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0
# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Verilog/SystemVerilog sources
VERILOG_SOURCES += $(PWD)/datapath.sv
VERILOG_SOURCES += $(PWD)/controller.sv

# Toplevel Verilog/SystemVerilog module
# If `division_tb` is your testbench, this should be the top-level design module name.
TOPLEVEL = datapath

# Python test module (your Python test file name without the .py extension)
MODULE = division_tb

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# Add the current directory to PYTHONPATH for Python imports
PYTHONPATH := $(PWD):$(PYTHONPATH)
export PYTHONPATH

# Additional settings for test discovery (if needed)
# Add test discovery settings here if you have a custom configuration
