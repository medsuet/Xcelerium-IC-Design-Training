# Sequential Multiplier with Ready-Val interface

It's a 16-bit signed multiplier with Ready-val interface that multiplies two 16-bit signed integers. It works on the booth multiplication algorithm. It contains datapath ,a controller and an interface to control back-pressure.


## Datapath and Controller

Datapath contains two shift registers for shifting multiplier and accumulator. It also contains one counter for counting 16 iterations and a flipflop for storing multiplicand. It also contains four mux for selecting right signal at output in accordance to control signal.
q------------------------------>Multiplier <br />
m------------------------------>Multiplicand <br />
p------------------------------>Product <br />
clk------------------------------>clock <br />
rst------------------------------>Asynchronous active low reset <br />
src_valid------------------------------>Indicator for getting valid inputs <br />
src_ready------------------------------>Indicator for idle state <br />
dest_valid------------------------------>Indicator for completion of multiplication <br />
dest_ready------------------------------>Indicator for getting output <br />

### Top Module
![Top Module](https://drive.google.com/uc?id=1hT8bbG7P7hPx5XWerwEfiEe3f09Tx1gR)
### Datapath and Controller
![Datapath and Controller](https://drive.google.com/uc?id=1C_kK64Cud8xMGOvUlfHM6NeG4tY1sp80)

### State Transition Graph
Controller contains state machine having two states: <br />
S0------------------------------>Starting state or Idle state <br />
S1------------------------------>Processing state <br />
S2------------------------------>Waiting state <br />
![STG](https://drive.google.com/uc?id=1Hy6SxX7PMi24NDgHHsMOXx7LOku5sxJ-)

## Simulation using Iverilog and Gtkwave

To simulate code on iverilog, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_val_ready directory:

    make

To add waves, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_val_ready  directory:

    make waveform
To clean .vvp and .vcd, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul_val_ready  directory:

    make clean







