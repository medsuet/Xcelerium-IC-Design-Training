IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SRC = adder.sv adder_tb.sv
OUT = adder.vvp
LOG = adder.vcd

all: $(OUT) $(LOG)

$(OUT): $(SRC)
	$(IVERILOG) -g2012 -o $(OUT) $(SRC)
$(LOG): $(OUT)
	$(VVP) $(OUT)
waveform: $(LOG)
	$(GTKWAVE) $(LOG)
clean:
	rm -f $(OUT) $(LOG)
.PHONY: $(OUT) all waveform clean
