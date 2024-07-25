# Counter RTL design
Language: System Verilog

Binary up-counter. Counts up from 0 till UBOUND-1.\
Resets when count == UBOUND-1, or at rising reset signal.

    Inputs: 1'b clk: clock signal.
            1'b reset: asynchronous reset signal. sets count to zero.
            
    Output: <NUMBITS>'b count: current value of counter.

    Parameters: NUMBITS: number of bits (width) of counter.
                UBOUND: maximum value the counter will count before reseting.

![image](Counter.svg)

### Run tests
By default ModelSim is used as System Verilog simulator.

Simulation parameters:

`COMPILER` (default vlog)     :System Verilog compiler.\
`SIMULATOR` (default vsim)    :System Verilog simulator.\
`SIMTIME` (default "0.5 ns")  :Running time of simulation.\
`RESETTIME` (default 0)       :Time after which reset signal is given to the counter  .

#### Run tests:
`make simulate`\
Instantiates Counter, gives it a 10 ps clock and a reset signal after <RESETTIME> ps and runs it for <SIMTIME>. Displays value of counter at each clock positive edge.

Custom tests: (example)\
`make simulate SIMTIME="10 ms" RESETTIME=25`\
This runs counter for 10 ms and gines reset signal after 25 ps.






