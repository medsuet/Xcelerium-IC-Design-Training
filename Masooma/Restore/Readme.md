
# Sequential Divider with Ready-Val interface

It's a 32-bit unsigned divider with Ready-val interface that divides two 32-bit unsigned integers. It works on the restoring division algorithm. It contains datapath ,a controller and an interface to control back-pressure.


## Datapath and Controller

Datapath contains two shift registers for shifting dividend and accumulator. It also contains one counter for counting 32 iterations and a flipflop for storing divisor. It also contains four mux for selecting right signal at output in accordance to control signal.
dd------------------------------>Dividend <br />
ds------------------------------>Divisor <br />
quo------------------------------>Quotient <br />
rem------------------------------>Remainder <br />
clk------------------------------>clock <br />
rst------------------------------>Asynchronous active low reset <br />
src_valid------------------------------>Indicator for getting valid inputs <br />
src_ready------------------------------>Indicator for idle state <br />
dest_valid------------------------------>Indicator for completion of division <br />
dest_ready------------------------------>Indicator for getting output <br />

### Top Module
![Top Module](https://drive.google.com/uc?id=1OjSv3K21zUkXzHgcWnc5y0Pvx4BUijy7)
### Datapath and Controller
![Datapath and Controller](https://drive.google.com/uc?id=1zg4MpS_JzUw6QzlX8DiNqTi_SOuua0pC)

### State Transition Graph
Controller contains state machine having two states: <br />
S0------------------------------>Starting state or Idle state <br />
S1------------------------------>Processing state <br />
S2------------------------------>Waiting state <br />
![STG](https://drive.google.com/uc?id=1Up1QdJKdeLBuvLfASxZT53AT8iMeABgw)

## Simulation using Iverilog and Gtkwave

To simulate code on iverilog, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_val_ready directory:

    make

To add waves, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_val_ready  directory:

    make waveform
To clean .vvp and .vcd, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_val_ready  directory:

    make clean
## Simulation using Iverilog and Gtkwave using cocotb

To simulate code on iverilog using cocotb, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_cocotb directory:

    make -f py.mk

To add waves, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_cocotb directory:

    gtkwave mul.dump






