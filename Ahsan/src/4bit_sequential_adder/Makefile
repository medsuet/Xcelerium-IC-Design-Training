#compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories and files for 4bit_adder
ADDER_VERILOG_FILES = src/adder.sv test/tb.sv
ADDER_OUTPUT_FILE = out.vvp

# Default target
all: adder

#Compile and simulate 4bit_adder
counter: compile_adder simulate_adder

compile_adder:
	$(IVERILOG) -g2012 -o $(ADDER_OUTPUT_FILE) $(ADDER_VERILOG_FILES)

simulate_adder:
	$(VVP) $(ADDER_OUTPUT_FILE)

#Clean up generated files
clean:
	rm -f $(ADDER_OUTPUT_FILE) tb_serial_adder.vcd

.PHONY: all counter compile_counter simulate_counter clean

