# Define variables
TOP_MODULE = tb_cache_top
SRC_FILES = AXI_controller.sv cache_controller.sv cache_datapath.sv cache_top.sv tb_cache_top.sv
WORK_DIR = work
RUNTIME = -all


# Create a working library and compile source files
compile:
	@echo "Creating work library..."
	vlib $(WORK_DIR)
	@echo "Compiling source files..."
	vlog -work $(WORK_DIR) $(SRC_FILES)

# Run the simulation and generate WLF file
simulate: compile
	@echo "Running simulation..."
	vsim -L $(WORK_DIR) $(TOP_MODULE) -do "add wave -radix Unsigned sim:/$(TOP_MODULE)/DUT/*; run $(RUNTIME);"

run: compile
	@echo "Running the module..."
	vsim -c -do "run $(RUNTIME); quit;" -L $(WORK_DIR) $(TOP_MODULE)

# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -rf $(WORK_DIR) transcript vsim.wlf

.PHONY: compile simulate run clean
