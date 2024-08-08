# defaults
# SIM ?= verilator
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

#SIM_ARGS = -lrestoring_division_algorithm.log

#EXTRA_ARGS += --trace --trace-structs
#WARNING_ARGS += -Wno-TIMESCALEMOD -Wno-WIDTH -Wno-UNOPT

VERILOG_SOURCES += $(PWD)/../src/controller.sv
VERILOG_SOURCES += $(PWD)/../src/restoring_division_algorithm.sv
VERILOG_SOURCES += $(PWD)/../src/datapath.sv
VERILOG_SOURCES += $(PWD)/wrapper/tb_restoring_division_algorithm.sv

# TOPLEVEL is the name of the toplevel module in your verilog or VHDL file
TOPLEVEL = tb_restoring_division_algorithm

# MODULE is the basename of the pythone test file
MODULE = testbench

include $(shell cocotb-config --makefiles)/Makefile.sim
