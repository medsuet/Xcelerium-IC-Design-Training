#compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories and files for Shift_reg
SHIFT_REG_VERILOG_FILES = src/shift_reg.sv test/tb.sv
SHIFT_REG_OUTPUT_FILE = out.vvp

# Default target
all:sr

#Compile and simulate Shift_Reg
sr: compile_sr simulate_sr

compile_sr:
	$(IVERILOG) -g2012 -o $(SHIFT_REG_OUTPUT_FILE) $(SHIFT_REG_VERILOG_FILES)

simulate_sr:
	$(VVP) $(SHIFT_REG_OUTPUT_FILE)
	
#Clean up generated files
clean:
	rm -f $(SHIFT_REG_OUTPUT_FILE) 
	
.PHONY: all sr compile_sr simulate_sr clean
