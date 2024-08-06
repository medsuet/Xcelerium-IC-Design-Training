# Makefile
# Defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
# Specify the directory containing your Verilog source files
VERILOG_SRC_DIR = $(PWD)
# List all your Verilog source files here
VERILOG_SOURCES += $(VERILOG_SRC_DIR)/Top_module.sv \
                   $(VERILOG_SRC_DIR)/Control.sv \
                   $(VERILOG_SRC_DIR)/sequential_multiplier.sv
# Top level module in your design
TOPLEVEL = top_multiplier
# Basename of the Python test file
MODULE = test_bench
# Include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim