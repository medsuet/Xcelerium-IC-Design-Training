# Pop Quiz Project

## Overview

This project includes the implementation of a simple circuit using D flip-flops and a testbench to verify its functionality.

The files in this project are:
- `src/pop_quiz.sv`: The main Verilog module implementing the pop quiz circuit.
- `test/pop_quiz_tb.sv`: The testbench for the pop quiz circuit.

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

1. **Compile, Simulate, and View the Waveform:**
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
    This command will compile the Verilog files (if not already compiled) and simulate the testbench.

4. **View the Waveform:**
    ```bash
    make view
    ```
    This command will open the generated waveform in GTKWave.

5. **Clean the Project:**
    ```bash
    make clean
    ```
    This command will remove the generated files and directories.

6. **Display Help:**
    ```bash
    make help
    ```
    This command will display help information about using the Makefile.

### Example

To compile and simulate run:
```bash
make all
```
To view the waveform, run:
```bash
make view
```

