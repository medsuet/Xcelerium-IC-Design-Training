# Define variables
TOP_MODULE = tb_top_multiplier
SRC_FILES = Control.sv,Top_module.sv,sequential_multiplier.sv
WORK_DIR = work

# Default target
all: compile simulate

# Create a working library and compile source files
compile:
	@echo "Creating work"
	vlib $(WORK_DIR)
	@echo "Compiling source files"
	vlog -work $(WORK_DIR) $(SRC_FILES)

# Run the simulation
simulate:
	@echo "Simulating"
	vsim -c -do "run -all; quit" -L $(WORK_DIR) $(TOP_MODULE)

debug: simulate
	@echo "gtk for wave simulation"
	gtkwave $(VCD_FILE)

# Clean up generated files
clean:
	@echo "Cleaning up"
	rm -rf $(WORK_DIR) transcript vsim.wlf

.PHONY: all compile simulate clean
