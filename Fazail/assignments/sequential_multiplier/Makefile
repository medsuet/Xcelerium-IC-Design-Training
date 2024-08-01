# Define variables
TOP_MODULE = tb_sequential_multiplier
SRC_FILES = src/controller.sv 				\
			src/datapath.sv 				\
			src/sequential_multiplier.sv 	\
			test/tb_sequential_multiplier.sv

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
# Clean up generated files
clean:
	@echo "Cleaning up..."
	rm -rf $(WORK_DIR) transcript vsim.wlf

.PHONY: all compile simulate clean

