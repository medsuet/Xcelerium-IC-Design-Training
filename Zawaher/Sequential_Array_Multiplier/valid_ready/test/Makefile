# Defaults
SIM ?= verilator
TOPLEVEL_LANG ?= verilog

# Define the source directories
SRC_DIR = $(PWD)/../src
INC_DIR = $(PWD)/../define

# Source files
VERILOG_SOURCES += $(INC_DIR)/array_mul.svh
VERILOG_SOURCES += $(SRC_DIR)/array_multiplier_datapath.sv
VERILOG_SOURCES += $(SRC_DIR)/array_multiplier_controller_valready.sv
VERILOG_SOURCES += $(SRC_DIR)/array_multiplier.sv
VERILOG_SOURCES += $(PWD)/cocotb.sv

# TOPLEVEL is the name of the top-level module in the Verilog files
TOPLEVEL = cocotb

# MODULE is the basename of the Python test file
MODULE = array_multiplier_tb

# Additional Verilator arguments
VERILATOR_ARGS += -I$(INC_DIR) --Wno-WIDTHTRUNC --Wno-LATCH --trace

# Include cocotb's make rules to handle simulator setup
COCOTB_MAKEFILES := $(shell cocotb-config --makefiles)
ifneq ($(COCOTB_MAKEFILES),)
include $(COCOTB_MAKEFILES)/Makefile.sim
else
$(error "cocotb-config is not correctly set up or Makefile.sim not found.")
endif

