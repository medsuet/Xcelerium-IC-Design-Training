# simulator
SIM ?= icarus
#language
TOPLEVEL_LANG ?= verilog

# Define variables
TOP_MODULE = restoring_division_tb
SRC_FILES += $(PWD)/../src/restoring_division.sv 
SRC_FILES += $(PWD)/../src/restoring_division_con.sv
SRC_FILES += $(PWD)/restoring_division_tb.sv 
WORK_DIR = work
RUNTIME = -all

# source files
VERILOG_SOURCES += $(PWD)/../src/restoring_division.sv
VERILOG_SOURCES += $(PWD)/../src/restoring_division_con.sv
VERILOG_SOURCES += $(PWD)/tb_cocotb.sv

#MODULE---->is the python test file 
#TOPLEVEL--->is the top-level in which our main module is instaiate
MODULE = tb_py_cocotb

all: run 


#all: restoring_div 
cocotb_test:
	$(MAKE) sim $(MODULE) 
include $(shell cocotb-config --makefiles)/Makefile.sim


# Create a working library and compile source files
compile:
	@echo "Creating work library..."
	vlib $(WORK_DIR)
	@echo "Compiling source files..."
	vlog -work $(WORK_DIR) $(SRC_FILES)

# Run the simulation and generate WLF file
simulate: compile
	@echo "Running simulation..."
	vsim -L $(WORK_DIR) $(TOP_MODULE) -do "add wave -radix Decimal sim:/$(TOP_MODULE)/DUT/*; run $(RUNTIME)"

run: compile
	@echo "Running the module..."
	vsim -c -do "run $(RUNTIME); quit;" -L $(WORK_DIR) $(TOP_MODULE)



.PHONY: all compile  clean cocotb_test

