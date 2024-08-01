# 16x16 Sequential Signed Multiplier

## Introduction

16x16 bit sequential signed multiplier.
A and B are signed inputs of 16 bits, product is 32-bits signed output.
Finite State Machine(controller) has 1-bit register for states.
For valid output after the start signal required 16 cycles.
The testbench will randomly test for a number of inputs and also supports directed test tasks.


## Usage: Automated for Multisim

Path to code: `Moazzam/src/systemverilog/seq_multiplier`

To execute the code and view the waveform on Multisim, simply use the following command:
```
make simulator
```

To execute the code on command line, simply use the following command:
```
make run
```

You can also decide the runtime for your code using the following command:
```
make run RUNTIME=xxxx
```
OR
```
make simulate RUNTIME=xxxx
```
**Note:** Where xxxx is the time in ps, you can give *RUNTIME=1000* --> which mean run for 1000ps

Once you've completely executed the code, don't forget to clean extra files through:
```
make clean
```

## Design Details

### Top Level Diagram

![Top Level](i_o.png)

### Datapath
![Datapath](data-path.png)

### Controller
![Datapath](controller.png)

## Gate Count
Total number of gates used in combinational logic

### Gate Count for Sequiential Multipler
This Gate Count is with respect to 16-bits input and 32-bits output

| Module                  | Total Element | Gate Count |
| ----------------------- | -----------   | ---------- |
| 32'b Ripple Carry Adder | 1             | 160        |
| 5'b Ripple Carry Adder  | 1             | 25         |
| 32 bit 2's Compliment   | 1             | 161        |
| 32-bit 2x1 MUX          | 3             | 96         |
| 16-bit 2x1 MUX          | 1             | 48         |
| 5'b Equal Comparator    | 4             | 29         |


**Total Gate Count in Sequential Multiplier is: 794**

### Gate Count for Combinational Multipler
This Gate Count is with respect to 16-bits input and 32-bits output

| Module                  | Total Element | Gate Count |
| ----------------------- | -----------   | ---------- |
| Full adder              | 225           | 5          |
| Half Adder              | 16            | 2          |
| AND-Gate                | 226           | 1          |
| NAND-Gate               | 30            | 1          |


**Total Gate Count in Combinational Multiplier is: 1413**