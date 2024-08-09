# 4-bit Counter Project

## Overview

This project implements a 4-bit counter in Verilog. The counter increments its value on each clock cycle until it reaches a specified maximum count, then resets to zero. The project includes both the design of the counter and a testbench to verify its functionality.

The files in this project are:
- `docs/4bit_counter.drawio`: The draw.io file for the datapath of 4bit_counter.
- `src/4bit_counter.sv`: The Verilog module implementing the 4-bit counter.
- `test/4bit_counter_tb.sv`: The testbench for the 4-bit counter.

## Prerequisites

- ModelSim or another compatible Verilog simulator.
- GTKWave for viewing the simulation waveforms.
- Make utility installed on your system.

## Makefile Usage

A Makefile is provided to simplify the process of compiling, simulating, and viewing the waveform of the Verilog code.

### Targets

- `all`: Compile the Verilog files and simulate the testbench.
- `compile`: Compile the Verilog files.
- `simulate`: Simulate the testbench.
- `view`: View the waveform in GTKWave.
- `clean`: Clean the generated files and directories.
- `help`: Display help information.

### How to Use

1. **Compile and Simulate:**
    ```bash
    make all
    ```
    This command will:
    - Compile the Verilog files.
    - Simulate the testbench.
2. **Compile Only:**
    ```bash
    make compile
    ```
    This command will only compile the Verilog files.

3. **Simulate Only:**
    ```bash
    make simulate
    ```
    This command will compile and simulate the testbench.

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
