# Default tool is verilator
TOOL ?= verilator

# Select simulation tool
SIM ?= $(TOOL)
TOPLEVEL_LANG ?= verilog

# Source files
VERILOG_SOURCES += $(PWD)/../src/Controller.sv
VERILOG_SOURCES += $(PWD)/../src/Datapath.sv
VERILOG_SOURCES += $(PWD)/../src/restoring_division.sv
VERILOG_SOURCES += $(PWD)/../src/Register.sv
VERILOG_SOURCES += $(PWD)/../src/ALU.sv
VERILOG_SOURCES += $(PWD)/../src/Mux.sv
VERILOG_SOURCES += $(PWD)/tb_restoring_division.sv

# Verilator specific flags
VERILATOR_FLAGS += --noassert --no-timing -Wno-WIDTHEXPAND

# Target for running the simulation
all: $(TOOL)

# Rule for Icarus Verilog
iverilog:
	rm -rf sim_build
	 $(MAKE) sim MODULE=tb_restoring_division TOPLEVEL=tb_restoring_division

# Rule for Verilator
verilator:
	rm -rf sim_build
	$(MAKE) sim MODULE=tb_restoring_division TOPLEVEL=tb_restoring_division EXTRA_ARGS="$(VERILATOR_FLAGS)"

# Rule for viewing results
view:
	gtkwave restoring_tb.vcd

# Include cocotb makefile if using cocotb
include $(shell cocotb-config --makefiles)/Makefile.sim
