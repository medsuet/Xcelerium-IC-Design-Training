# defaults
# SIM ?= verilator
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

#SIM_ARGS = -lrestoring_division_algorithm.log

#EXTRA_ARGS += --trace --trace-structs
#WARNING_ARGS += -Wno-TIMESCALEMOD -Wno-WIDTH -Wno-UNOPT

VERILOG_SOURCES += $(PWD)/../src/controller.sv
VERILOG_SOURCES += $(PWD)/../src/sequential_multiplier.sv
VERILOG_SOURCES += $(PWD)/../src/datapath.sv
VERILOG_SOURCES += $(PWD)/wrapper/tb_sequential_multiplier.sv

# TOPLEVEL is the name of the toplevel module in your verilog or VHDL file
TOPLEVEL = tb_sequential_multiplier

# MODULE is the basename of the pythone test file
MODULE = testbench

include $(shell cocotb-config --makefiles)/Makefile.sim
