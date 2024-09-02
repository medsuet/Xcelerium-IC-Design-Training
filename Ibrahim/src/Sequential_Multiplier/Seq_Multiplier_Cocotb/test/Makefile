SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../src/Controller.sv
VERILOG_SOURCES += $(PWD)/../src/Datapath.sv
VERILOG_SOURCES += $(PWD)/../src/seq_multiplier.sv
VERILOG_SOURCES += $(PWD)/../src/Register.sv
VERILOG_SOURCES += $(PWD)/../src/ALU.sv
VERILOG_SOURCES += $(PWD)/../src/Mux.sv
VERILOG_SOURCES += $(PWD)/tb_seq_multiplier.sv

# Verilator specific flags to ignore #1 warnings and timing errors, and to suppress WIDTHEXPAND warnings
VERILATOR_FLAGS += --noassert --no-timing -Wno-WIDTHEXPAND

all: multiplier

multiplier:
	rm -rf sim_build
	$(MAKE) sim MODULE=tb_seq_multiplier TOPLEVEL=tb_seq_multiplier EXTRA_ARGS="$(VERILATOR_FLAGS)"

view:
	gtkwave multiplier_tb.vcd

include $(shell cocotb-config --makefiles)/Makefile.sim
