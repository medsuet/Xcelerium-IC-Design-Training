# 4-bit Counter Project

## Overview

This project implements a 4-bit counter in Verilog. The counter increments its value on each clock cycle until it reaches a specified maximum count, then resets to zero. The project includes both the design of the counter and a testbench to verify its functionality.

The files in this project are:
- `docs/4bit_counter.drawio`: The draw.io file for the datapath of 4bit_counter.
- `src/4bit_counter.sv`: The Verilog module implementing the 4-bit counter.
- `test/4bit_counter_tb.sv`: The testbench for the 4-bit counter.
- `test/4bit_counter_tb.cpp`: The C++ testbench for verilator for 4-bit counter.

## Prerequisites

- ModelSim or another compatible Verilog simulator.
- GTKWave for viewing the simulation waveforms.
- Make utility installed on your system.

## Makefile Usage

A Makefile is provided to simplify the process of compiling, simulating, and viewing the waveform of the Verilog code.

### Targets

- `all`: Display the help message.
- `verilator`: Compile, run simulation, and view waveform with Verilator.
- `iverilog`: Compile and run simulation with Icarus Verilog.
- `vsim`: Compile and run simulation with ModelSim.
- `view`: View the waveform in GTKWave.
- `clean`: Clean the generated files and directories.
- `help`: Display help information.

### How to Use

1. **Compile and Simulate with ModelSim:**
    ```bash
    make vsim
    ```
    This command will:
    - Compile the Verilog files using ModelSim.
    - Run the simulation.

2. **Compile and Simulate with Verilator:**
    ```bash
    make verilator
    ```
    This command will:
    - Compile the Verilog files using Verilator.
    - Run the simulation.
    - Open the generated waveform in GTKWave.


3. **Compile and Simulate with Icarus Verilog:**
    ```bash
    make iverilog
    ```
    This command will:
    - Compile the Verilog files using Icarus Verilog.
    - Run the simulation.


4. **View Waveform:**
    ```bash
    make view
    ```
    This command will open the generated waveform in GTKWave.

5. **Clean Generated Files:**
    ```bash
    make clean
    ```
    This command will clean the generated files and directories.

6. **Display Help:**
    ```bash
    make help
    ```
    This command will display the help information on how to use the Makefile.