# Sequential Multiplier

It's a 16-bit signed multiplier that multiplies two 16-bit signed integers. It works on the booth multiplication algorithm. It contains datapath and a controller for working sequentially.


## Datapath and Controller

Datapath contains two shift registers for shifting multiplier and accumulator. It also contains one counter for counting 16 iterations and a flipflop for storing multiplicand. It also contains four mux for selecting right signal at output in accordance to control signal.
q------------------------------>Multiplier <br />
m------------------------------>Multiplicand <br />
p------------------------------>Product <br />
clk------------------------------>clock <br />
rst------------------------------>Asynchronous active low reset <br />
start------------------------------>Indicator for starting multiplication <br />
ready------------------------------>Indicator for completion of multiplication <br />
### Top Module
![Top Module](https://drive.google.com/uc?id=1m9hw0Qw2GRCjbj70ecxzAMXc4HwKlsCn)
### Datapath and Controller
![Datapath and Controller](https://drive.google.com/uc?id=1OBvjs564oGijMuhNYmC7wM_Xsi_AjyQM)

### State Transition Graph
Controller contains state machine having two states: <br />
S0------------------------------>Starting state or Idle state <br />
S1------------------------------>Processing state <br />
![STG](https://drive.google.com/uc?id=1scMFOle8yd8ZBpTJu6mAmIpV4THX8OsJ)

## Gate Comparison between Combinational multiplier and Seuential multiplier
|Multiplier Type | Gates |
|--|--|
| Combinational Multiplier | 961 |
| Sequential Multiplier | 354 |
## Simulation using Iverilog and Gtkwave

To simulate code on iverilog, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul directory:

    make

To add waves, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul directory:

    make waveform
To clean .vvp and .vcd, run the following command in Xcelerium-IC-Design-Training/Masooma/seq_mul directory:

    make clean




