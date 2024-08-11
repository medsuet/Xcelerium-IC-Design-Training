IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SRC = restore.sv restore_tb.sv
OUT = restore.vvp
LOG = restore.vcd

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
