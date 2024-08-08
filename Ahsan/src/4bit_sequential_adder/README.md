# 4-bit Sequential Adder

This project implements a 4-bit sequential adder using Verilog and simulates it using a testbench. The design includes state transitions to handle the addition of each bit along with the carry.

## States

- **State S0 (LSB)**: Initial state, waiting to start addition.
- **State S1 (B1_C0)**: Adding the first bit of B and the initial carry of 0.
- **State S2 (B1_C1)**: Adding the first bit of B and the initial carry of 1.
- **State S3 (B2_C0)**: Adding the second bit of B and a carry of 0 from the previous addition.
- **State S4 (B2_C1)**: Adding the second bit of B and a carry of 1 from the previous addition.
- **State S5 (B3_C0)**: Adding the third bit of B and a carry of 0 from the previous addition.
- **State S6 (B3_C1)**: Adding the third bit of B and a carry of 1 from the previous addition.

    
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
