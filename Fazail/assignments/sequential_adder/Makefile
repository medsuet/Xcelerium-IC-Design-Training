SRC_SV:= src/add_1.sv		\
	 test/tb_add_1.sv
	 
DEFINES_VER:= src/defines/verilator.svh

MODULE := tb_add_1

WORK_DIR = work

vsim: vsim_compile simulate

# Create a working library and compile source files
vsim_compile: $(wildcard *.sv)
	@echo "Creating work library..."
	vlib $(WORK_DIR)
	@echo "Compiling source files..."
	vlog -work $(WORK_DIR) $(SRC_SV)

# Run the simulation and generate WLF file
simulate: vsim_compile
	@echo "Running simulation..."
	vsim -L $(WORK_DIR) $(MODULE) -do "add wave -radix Unsigned sim:/$(MODULE)/UUT/*; run 3000"

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
	
.PHONY : clean
clean :
	@echo "Cleaning up..."
	rm -rf $(WORK_DIR) transcript vsim.wlf
	rm -rf *.jou *.log *.pb *.wdb xsim.dir *.str
	rm -rf .*.timestamp *.tcl *.vcd .*.verilate
	rm -rf obj_dir .Xil
