# Implementation of Sequential Binary Adder

This folder contains the files of system verilog implementation of sequential binary adder which adds 1 to any binary number. This functionality is verified by the test bench aimed to learn the sequential circuits concepts deeper.

## Problem 1: Sequential Binary Adder

- **File:** `sequential_adder.sv`
- **Description:** Build the chip binary sequential adder that adds 1 to any binary number. The circuit is basically the state machine or FSM having the diagram shown below. The hand written waveform (shown in the below figure) is verified by the waveform produced by simulator `vvp` that is visualized using the `gtkwave` for the value input 3 and 7. 

- **File:** `sequential_adder_tb.sv`
- **Description:** This file used to test the chip or verify its functionality.

# Run the script or verify the chip
To verify chip, you have to first download the compiler that compiles the system verilog source file e.g: iverilog. To visualize the signal, you have to download the gtkwave waveform visualizer.
- **To make all the builds files:** `make`
- **To run and make the `vcd` script:** `make run prog=<file_with_extension_.vvp>`
- **To clean all the builds:** `make clean`
- **To visualize the vcd file** `gtkwave <file_name_with_extension_.vcd>`

# State Diagram
![Circuit Diagram sequential binary adder](docs/state_diagram.drawio.svg)

# Results as Waveform Format
![Waveform](docs/wavedrom.svg)

