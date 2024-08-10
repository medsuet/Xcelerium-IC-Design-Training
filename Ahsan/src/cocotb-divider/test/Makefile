SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../src/Controller.sv
VERILOG_SOURCES += $(PWD)/../src/Datapath.sv
VERILOG_SOURCES += $(PWD)/../src/Top.sv
VERILOG_SOURCES += $(PWD)/../test/tb.sv

MODULE = divider_tb

include $(shell cocotb-config --makefiles)/Makefile.sim
