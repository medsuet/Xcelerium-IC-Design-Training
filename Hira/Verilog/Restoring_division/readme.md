# Restoring Division Algorithm in Verilog with cocotb Testbench

## Overview
This project implements the **Restoring Division Algorithm** in Verilog, alongside a testbench developed using the **cocotb** framework. The algorithm is used for binary division, producing both quotient and remainder for given dividend and divisor inputs.

## Restoring Division Algorithm

The Restoring Division Algorithm is a method of binary division, consisting of the following steps:

1. **Initialization**: 
   - The dividend is loaded into the quotient register.
   - The remainder register is initialized to zero.

2. **Shifting**: 
   - The quotient register is shifted left.
   - The most significant bit (MSB) of the remainder is brought down into the quotient.

3. **Subtraction**:
   - The divisor is subtracted from the remainder.

4. **Decision**:
   - If the result is positive or zero, the MSB of the quotient is set to 1.
   - If the result is negative, the MSB is set to 0, and the previous remainder is restored.

5. **Iteration**:
   - Steps 2-4 are repeated for each bit of the dividend until all bits are processed.

6. **Completion**:
   - After processing all bits, the quotient and remainder are finalized.


## State Diagram
State diagram of the 

## Verilog Implementation

The Verilog code is divided into two main modules:

### 1. `Datapath_Restoring_Division`

- **Inputs**: `clk`, `rst`, `enable_count`, `enable_registers`, `selc_A`, `dividend`, `divisor`
- **Outputs**: `done`, `temp`, `quotient`, `remainder`
(Top_module.png)

This module implements the datapath for the restoring division algorithm. It handles the initialization, shifting, subtraction, and decision-making process.
(data_path.png)


### 2. `Control_unit`

- **Inputs**: `clk`, `rst`, `done`, `src_valid`, `dd_ready`, `temp`
- **Outputs**: `selc_A`, `enable_count`, `enable_registers`, `src_ready`, `dd_valid`

The control unit manages the state machine, controlling the overall flow of the division process based on the inputs and intermediate results.
(flow.png)

## cocotb Testbench

The cocotb testbench is designed to verify the functionality of the Verilog implementation using both random and directed test cases.

### Key Components:

- **Clock Generator**: Generates clock pulses for the simulation.
- **Random Testing**: Runs a series of random test cases to validate the division logic.
- **Directed Testing**: Executes specific test cases to cover edge conditions and expected results.

### Usage

To run the testbench, ensure you have cocotb installed and set up with your preferred simulator. The test cases will verify the correctness of the quotient and remainder against expected values.
### Makefile

- **To run and compile the code write**: `make`



## Conclusion

This project demonstrates a hardware implementation of the restoring division algorithm and validates its functionality using cocotb. The combination of Verilog and cocotb allows for a robust testing environment that ensures the design works correctly across a range of inputs.
