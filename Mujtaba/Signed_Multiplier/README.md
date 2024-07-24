# Implementation of Combinational Signed Multiplier

This folder contains the files of system verilog implementation of multiplier and its test bench aimed to learn the multiplier concepts.

## Problem 1: Combinational Signed Multiplier

- **File:** `comb_multiplier.sv`
- **Description:** Build the chip of n-bit multiplier using combinational logic. The default circuit that is implemented is 16-bit signed multiplier as shown in the figure below.

- **File:** `comb_multiplier_tb.sv`
- **Description:** This file used to test the chip or verify its functionality.

# Run the script or verify the chip
To verify chip, you have to first download the compiler that compiles the system verilog source file e.g: iverilog. To visualize the signal, you have to download the gtkwave waveform visualizer.
- **To make all the builds files:** `make`
- **To run and make the `vcd` script:** `make run prog=<file_with_vvp_extension>`
- **To clean all the builds:** `make clean`
- **To visualize the vcd file** `gtkwave <file_name_with_extension_.vcd>`

# Circuit Diagram
![Combinational 16-bit Signed Multiplier](Signed%20Multiplier.drawio.png)

