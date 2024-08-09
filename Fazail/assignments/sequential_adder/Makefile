SRC_SV:= src/add_1.sv		\
	 test/tb_add_1.sv

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
	vsim -L $(WORK_DIR) $(MODULE) -do "add wave -radix Unsigned sim:/$(MODULE)/UUT/*; run 1000"

.PHONY : clean
clean :
	@echo "Cleaning up..."
	rm -rf $(WORK_DIR) transcript vsim.wlf