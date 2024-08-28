# Compiler
cc = tclsh

# Define the source directory
SRC_DIR = src

# Define the Tcl scripts
DESIGN_DATA_TCL = $(SRC_DIR)/design_data.tcl
DIGITAL_CALC_TCL = $(SRC_DIR)/digital_calc.tcl

# Default target to help the user with commands
all: help

# Target to run design_data.tcl
design_data:
	@echo "Running design_data.tcl..."
	$(cc) $(DESIGN_DATA_TCL)

# Target to run digital_calc.tcl
digital_calc:
	@echo "Running digital_calc.tcl..."
	$(cc) $(DIGITAL_CALC_TCL)

# Help target - To help the user
help:
	@echo "Usage:"
	@echo "  make design_data    - Run the design_data.tcl script"
	@echo "  make digital_calc   - Run the digital_calc.tcl script"

# PHONY target to keep these 'keywords' as 'targets
.PHONY: all design_data digital_calc help
