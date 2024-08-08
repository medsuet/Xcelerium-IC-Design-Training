# Define variables
TOP_MODULE = tb_sequential_multiplier
MODULE = tb_sequential_multiplier
SRC_SV = src/controller.sv 				\
			src/datapath.sv 				\
			src/sequential_multiplier.sv 	\
			test/tb_sequential_multiplier.sv

PY_TB := ./test/*.py
VCD := ./test/*.vcd

WORK_DIR = work

# Default target
all: compile vsim

# Create a working library and compile source files
compile:
	@mkdir -p log
	@echo "Creating work library..."
	vlib $(WORK_DIR)
	@echo "Compiling source files..."
	vlog -work $(WORK_DIR) $(SRC_SV)

# Run the simulation and generate WLF file
vs_simulate: compile
	@echo "Running simulation and generating WLF file..."
	vsim -L $(WORK_DIR) $(TOP_MODULE) -do "add wave -radix Decimal sim:/$(TOP_MODULE)/*; run -all"

# Show the simulation output
vsim: compile
	@echo "Running simulation"
	vsim -c -do "run -all; quit;" -L $(WORK_DIR) $(TOP_MODULE)
	
#----------------------#
#----- VERILATOR ------#
#----------------------#

.PHONY: verilator ver_waves 

ver_waves: verilator
	@echo
	@echo "### WAVES ###"
	gtkwave waveform.vcd &

verilator: ./obj_dir/V$(MODULE)
	@echo
	@echo "### SIMULATING ###"
	@./obj_dir/V$(MODULE)

./obj_dir/V$(MODULE): .stamp.verilate
	@echo
	@echo "### BUILDING SIM ###"
	make -C obj_dir -f V$(MODULE).mk V$(MODULE)

.stamp.verilate: ./src/*.sv ./test/$(TB_TOP).*
	@echo
	@echo "### VERILATING ###"
	verilator --trace -cc $(SRC_SV) $(DEFINES_VER) 	\
	  	  --top-module $(MODULE) 		\
		  -Wno-DECLFILENAME 			\
		  -Wno-WIDTH 				\
		  -Wno-REDEFMACRO			\
		  -Wno-INITIALDLY			\
		  -Wno-STMTDLY				\
		  --exe ./test/$(MODULE).cpp 		\
		  --timing
	@touch .stamp.verilate

#----------------------#
#------ COCO TB -------#
#----------------------#

cocotb: $(PY_TB)
	cd ./test/ && $(MAKE)

coco_wave: cocotb $(VCD)
	gtkwave $(VCD)
	
# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -rf ./test/__pycache__ ./test/sim_build
	rm -rf ./test/*.vcd ./test/*.xml ./test/*.log
	rm -rf $(WORK_DIR) transcript vsim.wlf
	rm -rf *.jou *.log *.pb *.wdb xsim.dir *.str
	rm -rf .*.timestamp *.tcl *.vcd .*.verilate
	rm -rf obj_dir .Xil

.PHONY: all compile simulate clean

