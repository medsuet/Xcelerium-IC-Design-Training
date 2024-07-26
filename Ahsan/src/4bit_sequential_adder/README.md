# 4-bit Sequential Adder

This project implements a 4-bit sequential adder using Verilog and simulates it using a testbench. The design includes state transitions to handle the addition of each bit along with the carry.

## States

    State S0: Initial state, waiting to start addition.
    State S1: Adding the first bit (LSB) of B and 1.
    State S2: Adding the second bit of B and the carry from the previous addition.
    State S3: Adding the third bit of B and the carry from the previous addition.
    State S4: Adding the fourth bit (MSB) of B and the carry from the previous addition.
    
## State Transitions

    Transition from S0 to S1: When the start signal is received.
    Transition from S1 to S2: After the first bit addition is complete, move to the second bit.
    Transition from S2 to S3: After the second bit addition is complete, move to the third bit.
    Transition from S3 to S4: After the third bit addition is complete, move to the fourth bit.
    Transition from S4 to S0: After the fourth bit addition is complete, return to the initial state.

## State Transition Graph

The state transition graph represents the transitions between states. Here is the textual representation:

    S0 --[Start]--> S1
    S1 --[Add first bit and carry]--> S2
    S2 --[Add second bit and carry]--> S3
    S3 --[Add third bit and carry]--> S4
    S4 --[Add fourth bit and carry, complete]--> S0
    
# Directory Structure
4bit_sequential_adder/
├── src/
│   └── adder.sv
├── test/
│   └── tb.sv
└── Makefile
# Makefile

there is makefile to automate the task

## How to use

### Compile
Compile the Verilog Code:
```
make compile_adder
```

### Simulate
Simulate the Verilog Code:
```
make simulate_adder
```

### cleanup
```
make clean
```
