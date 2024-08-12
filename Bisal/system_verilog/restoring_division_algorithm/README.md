# Restoring Division Algorithm Project with Python Test

## Introduction

This project implements a restoring division algorithm using system verilog. The system divides two 32-bit unsigned numbers sequentially and outputs a 32-bit unsigned quotient and a 32-bit unsigned remainder. The project also includes a testbench for verification using Cocotb.

## What is Cocotb?

Cocotb (Coroutine-based Co-simulation Testbench) is a Python library that allows you to write testbenches for your HDL code (e.g., Verilog, VHDL) in Python. It leverages the simulator's VPI/VHPI interface to provide an efficient way to drive and monitor signals in your design. Cocotb is particularly useful for writing complex testbenches, as it provides a high-level, Pythonic interface for interacting with your HDL.

## Prerequisites

- Verilog/SystemVerilog simulator (e.g., Icarus Verilog)
- Python 3.x
- Cocotb library

## Installation

### Cocotb

To install Cocotb, you can use pip:

```bash
pip install cocotb
```

### Icarus Verilog

To install Icarus Verilog, follow these steps:

On Ubuntu:

```bash
sudo apt-get update
sudo apt-get install iverilog
```

On macOS (using Homebrew):

```bash
brew install icarus-verilog
```

## Setting Up Cocotb in a Virtual Environment

1. **Create a virtual environment:**

    ```bash
    python -m venv myenv
    ```

2. **Activate the virtual environment:**

    On Windows:

    ```bash
    myenv\Scripts\activate
    ```

    On Unix or macOS:

    ```bash
    source myenv/bin/activate
    ```

3. **Install Cocotb in the virtual environment:**

    ```bash
    pip install cocotb
    ```

## Running the Testbench

To run the testbench, use the following command:

```bash
make SIM=icarus
```

This command runs the simulation using Icarus Verilog and executes the Cocotb testbench.

## Viewing Waveforms

To generate waveforms for viewing, ensure your Makefile includes commands to dump VCD files. Once the simulation is complete, you can use GTKWave to view the waveform:

```bash
gtkwave waveform.vcd
```

## Project Structure

### Top Module
The Top Module integrates the Control Unit and Data Path, coordinating the overall division process.

#### Inputs
- `clk`: Clock signal.
- `reset`: Reset signal to initialize the state.
- `src_valid`: Indicates when the input data is valid.
- `dst_ready`: Indicates when the module is ready to output data.
- `Dividend, Divisor`: 32-bit input values to be divided.

#### Outputs
- `Quotient`: 32-bit result of the division.
- `Remainder`: 32-bit remainder after division.
- `src_ready`: Indicates when the module is ready to accept new data.
- `dst_valid`: Indicates when the output data is valid.

#### Top-Level Module Diagram

### Control Unit

The Control Unit module manages the state transitions and control signals required for the division process.

**Key Features:**
- State management using an FSM (Finite State Machine).
- Control signals for enabling registers, counting, and shifting operations.
- Handles the ready/valid handshake protocol for input and output signals.

### 3. `Data_Path.sv`
The Data Path module performs the core division operation by iteratively shifting and subtracting.

**Key Features:**
- Handles the arithmetic operations required for the restoring division.
- Manages internal registers for the quotient and remainder.
- Supports loading initial values, shifting, and counting operations.

### 4. `tb_top_module.sv`
A SystemVerilog testbench that instantiates the `Top_Module` and simulates the division operation.

**Key Features:**
- Generates clock signals and applies reset conditions.
- Provides stimulus to the `Top_Module` by setting the dividend (`Q`) and divisor (`M`).
- Monitors and displays the results of the division, including the quotient and remainder.

### 5. `testbench.py`
A Python-based testbench using Cocotb for automated verification of the division algorithm.

**Key Features:**
- Clock generation using `cocotb`.
- Functions to apply directed tests with predefined inputs and expected outputs.
- Randomized tests to validate the robustness of the design.
- Logs the results of each test, indicating pass or fail status.

*NOTE*: Current file tests the code for 100k runs.

### 6. `Makefile`
A Makefile to automate the compilation and simulation process.

**Key Commands:**
- `make`: Compiles the SystemVerilog files and runs the simulation.
- `make view`: Opens the waveform in GTKWave after the simulation completes.

### 7. `dump.vcd`
This file is generated during the simulation and contains waveform data that can be viewed using GTKWave or any other waveform viewer.

## Running the Project

To compile and simulate the design:

```bash
make
