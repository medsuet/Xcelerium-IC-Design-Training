TOPLEVEL_LANG ?= verilog
VERILOG_SOURCES = $(shell pwd)/sequential_divider.sv \
                  $(shell pwd)/datapath.sv \
                  $(shell pwd)/controller.sv
TOPLEVEL = sequential_divider
MODULE = sequential_divider_tb

SIM ?= icarus

include $(shell cocotb-config --makefiles)/Makefile.sim

.PHONY: remove

remove:
	@rm -rf *.vcd *.vvp *.xml __pycache__/ sim_build/

