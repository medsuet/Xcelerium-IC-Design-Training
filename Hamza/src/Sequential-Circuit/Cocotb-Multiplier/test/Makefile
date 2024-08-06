SIM ?= icarus
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES += $(PWD)/../src/Controller.sv
VERILOG_SOURCES += $(PWD)/../src/Datapath.sv
VERILOG_SOURCES += $(PWD)/../src/Multiplier.sv
VERILOG_SOURCES += $(PWD)/multiplier_tb.sv

all: multiplier

multiplier:
	rm -rf sim_build
	$(MAKE) sim MODULE=multiplier_tb TOPLEVEL=multiplier_tb

include $(shell cocotb-config --makefiles)/Makefile.sim