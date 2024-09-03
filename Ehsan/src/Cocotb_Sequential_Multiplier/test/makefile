SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../src/data_path.sv
VERILOG_SOURCES += $(PWD)/../src/controller.sv
VERILOG_SOURCES += $(PWD)/../src/sequential_multiplier_top.sv
VERILOG_SOURCES += $(PWD)/tb.sv

all: multiplier

multiplier:
	rm -rf sim_build
	$(MAKE) sim MODULE=tb TOPLEVEL=tb
	
include $(shell cocotb-config --makefiles)/Makefile.sim


