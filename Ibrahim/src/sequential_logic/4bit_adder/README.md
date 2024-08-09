# Sequential Adder Project

## Overview

This project implements a sequential adder in Verilog. The sequential adder takes a 4-bit input number and processes it bit by bit to produce an output. The project includes both the design of the sequential adder and a testbench to verify its functionality.

The files in this project are:
- `docs/4bit_adder`: This is the state transition graph(STG) of the adder.
- `src/adder.sv`: The Verilog module implementing the sequential adder.
- `test/adder_tb.sv`: The testbench for the sequential adder.

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
    This command will simulate the testbench.

4. **View the Waveform:**
    ```bash
    make view
    ```
    This command will open the waveform in GTKWave if the VCD file already exists.

5. **Clean the Project:**
    ```bash
    make clean
    ```
    This command will clean the generated files and directories.

6. **Display Help Information:**
    ```bash
    make help
    ```
    This command will display the help information.

## Example Output

After running `make all`, you will see the following steps in your terminal:

1. **Compiling Verilog Files:**
    ```
    Compiling Verilog files...
    ```
    Compilation messages will follow.

2. **Simulating the Testbench:**
    ```
    Simulating the testbench...
    ```
    Simulation messages will follow.
After running make view, you will see the following in your terminal:
3. **Opening Waveform in GTKWave:**
    ```
    Opening waveform in GTKWave...
    ```
    GTKWave will open with the generated waveform file `sequential_adder.vcd`.

## Project Files

### src/adder.sv

This file contains the Verilog implementation of the sequential adder. It includes the state machine logic to process the 4-bit input number and generate the output.

### test/adder_tb.sv

This file contains the testbench for the sequential adder. It includes:
- Clock generation.
- Reset logic.
- Test case application.
- Output monitoring.
- VCD file generation for waveform analysis.

