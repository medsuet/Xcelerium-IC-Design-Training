VERILOG_FILES = src/state_machine.sv test/tb_state_machine.sv
TOP_MODULE = tb
OUTPUT_FILE = simulation.vvp
VCD_FILE = waveform.vcd

IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

all: compile simulate
compile:
	$(IVERILOG) -o $(OUTPUT_FILE) -g2012 $(VERILOG_FILES)
simulate:
	$(VVP) $(OUTPUT_FILE)
view_simulation:
	$(GTKWAVE) $(VCD_FILE)
clean:
	rm -f $(OUTPUT_FILE) $(VCD_FILE)

.PHONY: all compile simulate view clean
