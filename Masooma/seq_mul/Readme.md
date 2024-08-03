# Sequential Multiplier

It's a 16-bit signed multiplier that multiplies two 16-bit signed integers. It works on the booth multiplication algorithm. It contains datapath and a controller for working sequentially.


## Datapath and Controller

Datapath contains two shift registers for shifting multiplier and accumulator. It also contains one counter for counting 16 iterations and a flipflop for storing multiplicand. It also contains four mux for selecting right signal at output in accordance to control signal.
q------------------------------>Multiplier
m------------------------------>Multiplicand
p------------------------------>Product
clk------------------------------>clock
rst------------------------------>Asynchronous active low reset
start------------------------------>Indicator for starting multiplication
ready------------------------------>Indicator for completion of multiplication
<figure>
  <iframe src="https://drive.google.com/file/d/1m9hw0Qw2GRCjbj70ecxzAMXc4HwKlsCn/preview" width="300" height="140" allow="autoplay"></iframe>
  <figcaption>Top Module Diagram</figcaption>
</figure>
<figure>
<iframe src="https://drive.google.com/file/d/1OBvjs564oGijMuhNYmC7wM_Xsi_AjyQM/preview" width="520" height="470" allow="autoplay"></iframe>
 <figcaption>Datapath and Controller</figcaption>
</figure>



## State Transition Graph
Controller contains state machine having two states:
S0------------------------------>Starting state or Idle state
S1------------------------------>Processing state
<figure>
<iframe src="https://drive.google.com/file/d/1scMFOle8yd8ZBpTJu6mAmIpV4THX8OsJ/preview" width="640" height="120" allow="autoplay"></iframe>
 <figcaption>STG</figcaption>
</figure>

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




