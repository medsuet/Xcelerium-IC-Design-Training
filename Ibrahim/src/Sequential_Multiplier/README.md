# Sequential Multiplier Project

## Project Description

This project implements a sequential multiplier using SystemVerilog. The design consists of a Controller and Datapath. The multiplication process is executed sequentially, where controller manages the state transitions and control signals for the datapath components.

### Files in the Project

- **Controller.sv**: Implements the control logic to manage the multiplication process.
- **Datapath.sv**: Implements the datapath, including registers and multiplexers, for the sequential multiplication.
- **ALU.sv**: Implements the Arithmetic Logic Unit for addition and subtraction operations.
- **Register.sv**: Implements a register for storing intermediate values.
- **Mux.sv**: Implements a multiplexer for selecting input signals.
- **seq_multiplier.sv**: Top-level module that instantiates the controller and datapath.
- **tb_seq_multiplier.sv**: Testbench for verifying the functionality of the sequential multiplier.

## Using the Makefile

The provided Makefile automates the process of compiling, running, and cleaning up the simulation files using Icarus Verilog. Below is a description of the available targets in the Makefile and how to use them.

### Makefile Targets

- **all**: The default target that compiles and runs the simulation.
- **compile**: Compiles the SystemVerilog source files into an executable.
- **run**: Runs the compiled simulation.
- **view**: Opens the generated waveform file (`multiplier.vcd`) in GTKWave for viewing.
- **clean**: Removes the compiled executable and waveform file to clean up the directory.
- **help**: Displays help information about the available targets and their usage.

### How to Use the Makefile

1. **Compile and Run the Simulation**
    ```bash
    make
    ```
   This command will compile the SystemVerilog source files and run the simulation, generating a waveform file (`multiplier.vcd`).

2. **Compile the Source Files**
    ```bash
    make compile
    ```
   This command will compile the SystemVerilog source files into an executable.

3. **Run the Simulation**
    ```bash
    make run
    ```
   This command will run the compiled simulation.

4. **View the Waveform**
    ```bash
    make view
    ```
   This command will open the waveform file (`multiplier.vcd`) in GTKWave for viewing.

5. **Clean Up**
    ```bash
    make clean
    ```
   This command will remove the compiled executable and waveform file, cleaning up the directory.

6. **Display Help Information**
    ```bash
    make help
    ```
   This command will display help information about the available targets and their usage.

### Example Usage

1. **Initialize the Project**
    ```bash
    make
    ```
   This will compile and run the simulation, then you can view the waveform using:
    ```bash
    make view
    ```

2. **Clean the Project**
    ```bash
    make clean
    ```

3. **Get Help**
    ```bash
    make help
    ```

## Testbench Details

The testbench (`tb_seq_multiplier.sv`) includes the following:

- Clock generation with a period of 10ns.
- Tasks for driving inputs (`drive_inputs`) and monitoring outputs (`monitor_outputs`).
- Test sequences for:
  - Multiplication with 0.
  - Multiplication with 1.
  - Multiplication with negative numbers.
  - Random multiplications.

### Running the Testbench

The testbench is designed to run various test cases to verify the functionality of the sequential multiplier. The results are printed to the console, indicating whether each test case passes or fails.

### Viewing the Waveform

After running the simulation, you can view the generated waveform in GTKWave by using the `make view` command. This allows you to visually inspect the signals and verify the operation of your design.

