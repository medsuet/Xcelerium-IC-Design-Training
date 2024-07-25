
# Add 1  design
Language: System Verilog

Adds 1 to the input number.\
Input is given serially (bit by bit), and can be of any length. Reset before inputting a new number.

### Working
![image](Add1.drawio.svg)
The adder has been implemented as a state machine.

The state remembers the carry: if current state is CARRY1, there is a carry of 1 leftover from previous bit that is to be added to current bit, while CARRY0 state means there is no carry (a carry of 0).

At reset state, lsb of the input number arrives and is added to 1, and the bit is output. For other bits, the carry is added to them to get the output. Any carry generated determines the next state (CARRY0 or CARRY1).  If, at any time, there is 0 carry, the rest of input number can just be passed to output.

### Test
ModelSim is used as System Verilog simulator.
- `make compile` 
Compiles the System Verilog files.

- `make simulate`
Runs the compile target if required. Runs predefined simulation that tests Add1 module for all 4 bit numbers and displays results on console.

- `make clean`
Deletes the work folder produced by ModelSim.