# This file is public domain, it can be freely copied without restrictions.
# SPDX-Identifier: CC0-1.0
# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Verilog sources
VERILOG_SOURCES += $(PWD)/sequential_multiplier.sv
VERILOG_SOURCES += $(PWD)/controller.sv

# Toplevel module
TOPLEVEL = sequential_multiplier

# Python test module
MODULE = test_sequential_multiplier

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# Add the current directory to PYTHONPATH
PYTHONPATH := $(PWD):$(PYTHONPATH)
export PYTHONPATH

# Additional settings for test discovery (if needed)
# Add test discovery settings here if you have a custom configuration
