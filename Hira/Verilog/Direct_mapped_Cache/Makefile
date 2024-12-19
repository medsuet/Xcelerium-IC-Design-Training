IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SRC = mul.sv mul_tb.sv
OUT = mul.vvp
LOG = mul.vcd

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