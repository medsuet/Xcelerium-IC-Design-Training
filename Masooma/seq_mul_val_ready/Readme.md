# Sequential Multiplier with Ready-Val interface

It's a 16-bit signed multiplier with Ready-val interface that multiplies two 16-bit signed integers. It works on the booth multiplication algorithm. It contains datapath ,a controller and an interface to control back-pressure.


## Datapath and Controller

Datapath contains two shift registers for shifting multiplier and accumulator. It also contains one counter for counting 16 iterations and a flipflop for storing multiplicand. It also contains four mux for selecting right signal at output in accordance to control signal.
q------------------------------>Multiplier
m------------------------------>Multiplicand
p------------------------------>Product
clk------------------------------>clock
rst------------------------------>Asynchronous active low reset
src_valid------------------------------>Indicator for getting valid inputs
src_ready------------------------------>Indicator for idle state
dest_valid------------------------------>Indicator for completion of multiplication
dest_ready------------------------------>Indicator for getting output

### Top Module
![Top Module](https://drive.google.com/uc?id=1m9hw0Qw2GRCjbj70ecxzAMXc4HwKlsCn)
### Datapath and Controller
![Datapath and Controller](https://drive.google.com/uc?id=1OBvjs564oGijMuhNYmC7wM_Xsi_AjyQM)

### State Transition Graph
Controller contains state machine having two states:
S0------------------------------>Starting state or Idle state
S1------------------------------>Processing state
![STG](https://drive.google.com/uc?id=1scMFOle8yd8ZBpTJu6mAmIpV4THX8OsJ)

## Simulation using Iverilog and Gtkwave

To simulate code on iverilog, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul directory:

    make

To add waves, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul directory:

    make waveform
To clean .vvp and .vcd, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul directory:

    make clean







