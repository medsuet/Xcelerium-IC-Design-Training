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


### Prerequisites

Ensure you have the following tools installed on your system:

- [Icarus Verilog](http://iverilog.org/) or [ModelSim](https://www.mentor.com/products/fpga/modelsim/)

## Using the Makefile

The provided Makefile automates the process of compiling, running, and cleaning up the simulation files using Icarus Verilog. Below is a description of the available targets in the Makefile and how to use them.

### Makefile Targets

- **make or make all**: Compile and run the simulation using the default simulator (Icarus Verilog).
- **make sim=vsim**: Compile and run the simulation using ModelSim.
- **make compile**: Compile the SystemVerilog source files without running the simulation.
- **make run**: Run the simulation using the compiled files.
- **make view**: View the waveform in GTKWave.
- **make clean**: Remove the compiled executable, waveform file, and work library.
- **make help**: Displays help information about the available targets and their usage.

#### Running Simulations

1. **Compile and Run the Simulation:**

   By default, the Makefile is configured to use Icarus Verilog. Run the following command to compile and run the simulation:

   ```bash
   make
   ```
   This command will compile the SystemVerilog source files and run the simulation, generating a waveform file (`multiplier.vcd`).
   
   To use ModelSim instead, specify the sim variable:

    ```bash
    make sim=vsim
    ```
2. **View the Waveform**
    
    To view the waveform, first ensure the simulation has been run and the waveform file (multiplier.vcd) has been generated. Then run:
    ```bash
    make view
    ```
   This command will open the waveform file (`multiplier.vcd`) in GTKWave for viewing.

3. **Clean Up**
    
    To remove the compiled files and waveform, as well as the work library, use:
    ```bash
    make clean
    ```
   
4. **Display Help Information**
    ```bash
    make help
    ```
   This command will display help information about the available targets and their usage.

### Example Usage

1. **Initialize the Project**
    ```bash
    make
    ```
   This will compile and run the simulation using iverilog, then you can view the waveform using:

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

