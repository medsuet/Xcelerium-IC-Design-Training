#compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories and files for 4bit_counter
COUNTER_VERILOG_FILES = src/Counter.sv test/tb.sv
COUNTER_OUTPUT_FILE = out.vvp

# Default target
all: counter

#Compile and simulate 4bit_counter
counter: compile_counter simulate_counter

compile_counter:
	$(IVERILOG) -g2012 -o $(COUNTER_OUTPUT_FILE) $(COUNTER_VERILOG_FILES)

simulate_counter:
	$(VVP) $(COUNTER_OUTPUT_FILE)

#Clean up generated files
clean:
	rm -f $(COUNTER_OUTPUT_FILE)

.PHONY: all counter compile_counter simulate_counter clean

