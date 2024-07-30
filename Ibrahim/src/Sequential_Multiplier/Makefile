# Makefile for compiling and running SystemVerilog code using Icarus Verilog

# Variables
SRC_FILES = src/seq_multiplier.sv test/tb_seq_multiplier.sv
TOP_MODULE = tb_seq_multiplier
WAVEFORM_FILE = multiplier.vcd
COMPILER = iverilog
SIMULATOR = vvp

# Default target
all: run

# Compile the SystemVerilog code
compile:
	$(COMPILER) -g2012 -o $(TOP_MODULE) $(SRC_FILES)

# Run the simulation
run: compile
	$(SIMULATOR) $(TOP_MODULE)

# View the waveform
view: $(WAVEFORM_FILE)
	gtkwave $(WAVEFORM_FILE)

# Clean up generated files
clean:
	rm -f $(TOP_MODULE) $(WAVEFORM_FILE)

# Help target
help:
	@echo "Makefile targets:"
	@echo "  make            - Compile and run the simulation (default target)."
	@echo "  make compile    - Compile the SystemVerilog source files."
	@echo "  make run        - Run the simulation."
	@echo "  make view       - View the waveform in GTKWave."
	@echo "  make clean      - Remove the compiled executable and waveform file."
	@echo "  make help       - Display this help message."

# Phony targets
.PHONY: all compile run view clean help
