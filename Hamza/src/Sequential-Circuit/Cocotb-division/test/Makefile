SIM ?= verilator
TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES += $(PWD)/../src/Controller.sv
VERILOG_SOURCES += $(PWD)/../src/Datapath.sv
VERILOG_SOURCES += $(PWD)/../src/Rest_div.sv
VERILOG_SOURCES += $(PWD)/tb_rest_div.sv

# Verilator specific flags to enable tracing
VERILATOR_FLAGS +=  --noassert --no-timing -Wno-WIDTHEXPAND -Wno-WIDTHTRUNC

all: divider

divider:
	rm -rf sim_build
	$(MAKE) sim MODULE=tb_rest_div TOPLEVEL=tb_rest_div EXTRA_ARGS="$(VERILATOR_FLAGS)"
	
include $(shell cocotb-config --makefiles)/Makefile.sim