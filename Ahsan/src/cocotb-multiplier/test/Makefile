SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../src/Controller.sv
VERILOG_SOURCES += $(PWD)/../src/Datapath.sv
VERILOG_SOURCES += $(PWD)/../src/Seq_Mul_top.sv
VERILOG_SOURCES += $(PWD)/../multiplier_tb.sv

MODULE = multiplier_tb

include $(shell cocotb-config --makefiles)/Makefile.sim

