# Define variables
TOP_MODULE = seq_multiplier_tb
SRC_FILES =  seq_multiplier.sv seq_multiplier_tb.sv seq_multiplier_con.sv
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
	vsim -L $(WORK_DIR) $(TOP_MODULE) -do "add wave -radix Decimal sim:/$(TOP_MODULE)/DUT/*; run $(RUNTIME)"

run: compile
	@echo "Running the module..."
	vsim -c -do "run $(RUNTIME); quit;" -L $(WORK_DIR) $(TOP_MODULE)

# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -rf $(WORK_DIR) transcript vsim.wlf


.PHONY: all compile simulate clean