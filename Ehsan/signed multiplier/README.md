
## Installation

Install iverilog
```bash
sudo apt install iverilog
```

## Run testing
Run following command on your console
```bash
iverilog -o out -g2012 signed_multplier.sv tb.sv
```
```bash
vvp out
```

