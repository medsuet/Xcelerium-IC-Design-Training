# Makefile

# Defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

# Specify the directory containing your Verilog source files
VERILOG_SRC_DIR = $(PWD)/src

# List all your Verilog source files here
VERILOG_SOURCES += $(VERILOG_SRC_DIR)/Top_Module.sv \
                   $(VERILOG_SRC_DIR)/controller.sv \
                   $(VERILOG_SRC_DIR)/datapath.sv

# Top level module in your design
TOPLEVEL = Top_Module

# Basename of the Python test file
MODULE = testbench

# Include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
