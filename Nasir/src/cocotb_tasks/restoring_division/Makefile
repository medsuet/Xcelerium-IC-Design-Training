# simulator
# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# system verilog sources
VERILOG_SOURCES += $(PWD)/src/restoring_division.sv
VERILOG_SOURCES += $(PWD)/src/datapath.sv
VERILOG_SOURCES += $(PWD)/src/controller.sv

# top level module

TOPLEVEL = restoring_division

# python verification environment

MODULE = tests.restoring_division_tb


# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim

# Add the current directory to PYTHONPATH
PYTHONPATH := $(PWD):$(PYTHONPATH)
export PYTHONPATH


# Define the post-simulation step
POST_SIM_COMMANDS = gtkwave restoring_division.vcd

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

