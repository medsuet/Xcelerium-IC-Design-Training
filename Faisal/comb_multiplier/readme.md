# 16-bit Signed Combinatorial Multiplier

This Verilog project implements a 16-bit signed combinatorial multiplier. The multiplier takes two 16-bit signed inputs and produces a 32-bit signed output, representing the product of the inputs.

## Overview

The multiplier module (`comb_16bit_mul`) follows these steps to compute the product:

1. **Input Handling**: Determines if two's complement conversion is necessary based on the signs of the inputs.
2. **Partial Products Generation**: Generates partial products for each bit of the multiplier.
3. **Accumulation**: Accumulates the partial products to generate the final product.
4. **Output Adjustment**: Adjusts the final product if necessary using two's complement.

The testbench (`tb_comb_16bit_mul`) verifies the functionality of `comb_16bit_mul` 

## Datapath Diagram
![16bit_signed_combinational_mul](https://github.com/user-attachments/assets/954a17ba-85f8-445d-8fb8-570139c72f65)

## How to Run

To simulate and test the 16-bit signed combinatorial multiplier:

### Clone the Repository:
```
   git clone <repository-url>
   cd comb_multiplier
```
### Compile with Icarus Verilog
```
iverilog -g2012 -o sim comb_16bit_mul.sv tb_comb_16bit_mul.sv
```
### Run Simulation:
```
./sim
```
### View Results:
The simulation will display the test cases along with their expected results.

