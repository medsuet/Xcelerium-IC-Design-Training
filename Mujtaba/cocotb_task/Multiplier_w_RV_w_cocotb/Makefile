TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES = $(shell pwd)/sequential_multiplier.sv \
                  $(shell pwd)/datapath.sv \
                  $(shell pwd)/controller.sv
TOPLEVEL = sequential_multiplier
MODULE = sequential_multiplier_tb

SIM ?= verilator

include $(shell cocotb-config --makefiles)/Makefile.sim

.PHONY: remove

remove:
	@rm -rf *.vcd *.vvp *.xml __pycache__/ sim_build/

