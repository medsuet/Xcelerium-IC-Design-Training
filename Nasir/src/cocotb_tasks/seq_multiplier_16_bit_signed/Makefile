# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Verilog sources
VERILOG_SOURCES += $(PWD)/src/sequential_multiplier.sv
VERILOG_SOURCES += $(PWD)/src/datapath.sv
VERILOG_SOURCES += $(PWD)/src/controller.sv

# Toplevel module
TOPLEVEL = sequential_multiplier

# Python test module
MODULE = tests.sequential_multiplier_tb

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# Add the current directory to PYTHONPATH
PYTHONPATH := $(PWD):$(PYTHONPATH)
export PYTHONPATH

# Define the post-simulation step
POST_SIM_COMMANDS = gtkwave dump.vcd

# # Define the default target
# all: run

# # Run the simulation
# run:
# 	$(MAKE) -C $(BUILD_DIR)
	
simulate:
	$(POST_SIM_COMMANDS)

# # Clean up
# clean:
# 	rm -f dump.vcd
# 	$(MAKE) -C $(BUILD_DIR) clean
