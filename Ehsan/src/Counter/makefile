VERILOG_FILES = src/counter.sv test/tb_counter.sv
TOP_MODULE = tb
OUTPUT_FILE = simulation.vvp
VCD_FILE = waveform.vcd

IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave

all: compile simulate

install:
	sudo apt install $(IVERILOG)
	sudo apt install $(GTKWAVE)


compile:
	$(IVERILOG) -g2012 -o $(OUTPUT_FILE) $(VERILOG_FILES)

simulate:
	$(VVP) $(OUTPUT_FILE)

view_simulation:
	$(GTKWAVE) $(VCD_FILE)


clean:
	rm -f $(OUTPUT_FILE) $(VCD_FILE)

.PHONY: all compile simulate view clean
