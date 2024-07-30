# Implementation of 16-bit Sequential Signed Multiplier

This folder contains the files of system verilog implementation of 16-bit Sequential Signed Multiplier and its test bench aimed to learn the hardware implementation of the Multiplier.

## Problem 1: 16-bit Sequential Signed Multiplier Implementation

- **File:** `sequential_multiplier.sv`
- **Description:** Build the chip of 16-bit Signed Multiplier that multiplies two numbers in hardware in 16 clock cycles and 1 cycle for placing the result in the `result` regiter. The default circuit implemented for 16-bit multiplier having the hardware with top level module shown in the figure below. The state diagram on which the controller is operated, also shown below under `State Diagram` section. 

- **File:** `sequential_multiplier_tb.sv`
- **Description:** This file used to test the chip or verify its functionality. The file included the 2 lac random tests to ensures the correct implementation of the chip. `To view the waveform on the gtkwave, you first have to comment out the lines in test bench file.`

# Run the script or verify the chip
To verify chip, you have to first download the compiler that compiles the system verilog source file e.g: iverilog. To visualize the signal, you have to download the gtkwave waveform visualizer.
- **To make all the builds files:** `make`
- **To run and make the `vcd` script:** `make run prog=<file_with_extension_.vvp>`
- **To clean all the builds:** `make clean`
- **To visualize the vcd file** `gtkwave <file_name_with_extension_.vcd>`

# Top Level Diagram
![Top Level of Multiplier](docs/top_module.drawio.svg)

# Circuit Diagram
![Circuit Diagram of Datapath and controller](docs/datapath.drawio.svg)

# State Diagram
![State Diagram](docs/state_diagram.drawio.svg)

