# Implementation of Cache Memory with AXI4 Lite Protocol

This folder contains the files of system verilog implementation of Cache Memory having Ready/Valid Handshake Protocol at the CPU interface and AXI4 Lite Protocol interface at the memory side and its test bench aimed to verify the functionality of the cache along with their protocol.

## Problem 1: Cache Memory Implementation

- **File:** `cache_mem_axi4.sv`
- **Description:** Build the chip that integrates the cache datapath and cache controller along with AXI4 Lite Master interface. The top level module of cache memory is shown in the figure below. The state diagram of controller is also shown below under `State Diagram` section. 

- **File:** `cache_mem_axi4_tb.sv`
- **Description:** This file used to test the chip or verify its functionality. The file included the 10 thousand random tests to ensures the correct implementation of the chip. `To view the waveform on the gtkwave, you first have to comment out the lines in test bench file.`

# Run the script or verify the chip
To verify chip, you have to first download the compiler that compiles the system verilog source file e.g: iverilog. To visualize the signal, you have to download the gtkwave waveform visualizer.
- **To make all the builds files:** `make`
- **To run and make the `vcd` script:** `make run prog=<file_with_extension_.vvp>`
- **To clean all the builds:** `make clean`
- **To visualize the vcd file** `gtkwave <file_name_with_extension_.vcd>`

# Top Level Diagram
![Top Level of Cache Memory ](docs/top_level.drawio.svg)

# Circuit Diagram
![Circuit Diagram of Datapath and controller](docs/datapath.drawio.svg)

# State Diagram
![State Diagram](docs/state_diagram.drawio.svg)

