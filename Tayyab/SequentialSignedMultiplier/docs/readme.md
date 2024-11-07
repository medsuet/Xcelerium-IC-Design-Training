# Sequential Signed Multiplier Design

Language: SystemVerilog

Multiplies two 16 bit signed numbers sequentially in 35 clock cycles.\
(35 cycles is maximum; result can be available in less cycles).\
Sets ready signal when result is available.
```
Paramater: NUMBITS  : width (number of bits) of multiplier and multiplicand.

Inputs: clk             : clock signal
        reset           : reset signal (active low)
        num_a, num_b    : <NUMBITS> wide multiplier and multiplicand.
                        Must be stable for 1 clock cycle after start signal.
        valid_scr       : valid signal from source signaling availability of inputs (num_a, num_b)
        ready_dst       : ready signal from detination signaling that output (product) has been processed

Outputs: product         : <2*NUMBITS> wide result of num_a * num_b
         valid_dst       : valid signal to destination signaling  availability of output (product)
         ready_scr       : ready signal to source signaling that inputs (num_a, num_b) has been processed

Supports valid/ready interface.
```
### Run tests
Verilator is used as SystemVerilog simulator.

Use makefile to run random tests on the unit.

`make verilate`\
Compiles the modules source files.\

`make simulate`\
Simulates random tests on SequentialSignedMultiplier module.\
Displays scoreboard on console and generates waveform.vcd file.\
(No need to run verilate target).\
See simulation options.

`make clean`\
Cleans the simulation files and directories.

### Simulation options
These parameters can be set on simulation time.\
For example: `make simulate NUMTESTS=1000000`

`NUMTESTS` (default 10000)\
Number of random tests to run on the module.

### C model
Model of SequentialSignedMultiplier module written in C.\
Path: "docs/C model/SequentialSignedMultiplier.c"

### Structure
Top level diagram:

![image](images/top_level_diagram.drawio.svg)


Controller, datapath connections:

![image](images/datapath_controller.drawio.svg)


Datapath:

![image](images/datapath.drawio.svg)


Controller:

![image](images/stg.drawio.svg)


#### Gate count
The sequential signed multiplier uses 416 gates.\
In contrast, the combinational signed multiplier used 979 gates.