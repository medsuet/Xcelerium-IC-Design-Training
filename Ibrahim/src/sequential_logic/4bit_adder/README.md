# Sequential Adder Project

## Overview

This project implements a sequential adder in Verilog. The sequential adder takes a 4-bit input number and processes it bit by bit to produce an output. The project includes both the design of the sequential adder and a testbench to verify its functionality.

The files in this project are:
- `docs/4bit_adder`: This is the state transition graph(STG) of the adder.
- `src/adder.sv`: The Verilog module implementing the sequential adder.
- `test/adder_tb.sv`: The testbench for the sequential adder.
- `test/adder_tb.cpp`: The C++ testbench for sequential adder.

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