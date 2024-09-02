# Define variables
TOP_MODULE = tb_sequential_multiplier
SRC_FILES = src/controller.sv 				\
			src/datapath.sv 				\
			src/sequential_multiplier.sv 	\
			test/tb_sequential_multiplier.sv

DEFINES_VER:= src/defines/verilator.svh
WORK_DIR = work

# Default target
all: compile run

# Create a working library and compile source files
compile:
	@mkdir -p log
	@echo "Creating work library..."
	vlib $(WORK_DIR)
	@echo "Compiling source files..."
	vlog -work $(WORK_DIR) $(SRC_FILES)

# Run the simulation and generate WLF file
simulate: compile
	@echo "Running simulation and generating WLF file..."
	vsim -L $(WORK_DIR) $(TOP_MODULE) -do "add wave -radix Decimal sim:/$(TOP_MODULE)/*; run -all"

# Show the simulation output
run: compile
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

verilator: ./obj_dir/V$(TOP_MODULE)
	@echo
	@echo "### SIMULATING ###"
	@./obj_dir/V$(TOP_MODULE)

./obj_dir/V$(TOP_MODULE): .stamp.verilate
	@echo
	@echo "### BUILDING SIM ###"
	make -C obj_dir -f V$(TOP_MODULE).mk V$(TOP_MODULE)

.stamp.verilate: ./src/*.sv ./test/$(TOP_MODULE).*
	@echo
	@echo "### VERILATING ###"
	verilator --trace -cc $(SRC_FILES) $(DEFINES_VER) 	\
	  	  --top-module $(TOP_MODULE) 		\
		  -Wno-DECLFILENAME 			\
		  -Wno-WIDTH 				\
		  -Wno-REDEFMACRO			\
		  -Wno-INITIALDLY			\
		  -Wno-STMTDLY				\
		  --exe ./test/$(TOP_MODULE).cpp 		\
		  --timing
	@touch .stamp.verilate

# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -rf $(WORK_DIR) transcript vsim.wlf
	rm -rf *.jou *.log *.pb *.wdb xsim.dir *.str
	rm -rf .*.timestamp *.tcl *.vcd .*.verilate
	rm -rf obj_dir .Xil

.PHONY: all compile simulate clean

