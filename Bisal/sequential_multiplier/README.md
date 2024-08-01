# Sequential Signed Multiplier Project

## Objective

This project implements a sequential multiplier using Verilog, consisting of two main components: the Control Unit and the Data Path. The system multiplies two 16-bit signed numbers sequentially and outputs a 32-bit signed product. The project also includes a testbench for verification.

## Project Structure

- **Top Module**: Integrates the Control Unit and Data Path, managing the overall operation.
- **Control Unit**: Manages the state transitions and control signals for the multiplication process.
- **Data Path**: Performs the actual multiplication operation, utilizing registers and combinational logic.

### Top Module

The Top Module integrates the Control Unit and Data Path, coordinating the overall multiplication process.

#### Inputs
- `clk`: Clock signal.
- `reset`: Reset signal to initialize the state.
- `start`: Signal to start the multiplication process.
- `A`, `B`: 16-bit input values to be multiplied.

#### Outputs
- `P`: 32-bit product of the multiplication.
- `ready`: Indicates when the multiplication is complete.

![Control Unit State Diagram](images/topmodule.png)


### Control Unit

The Control Unit handles the state transitions between different stages of the multiplication process, including initialization, calculation, and completion.

#### Inputs
- `clk`: Clock signal.
- `reset`: Reset signal to initialize the state.
- `start`: Signal to start the multiplication process.
- `count`: Counter value indicating the current step in the multiplication.

#### Outputs
- `enReg`: Enable signal for loading inputs into registers.
- `enCount`: Enable signal for the counter and calculation operations.
- `enShift`: Enable signal for shifting calculated product for each count.
- `ready`: Indicates when the multiplication is complete.

#### State Diagram

The Control Unit operates in a finite state machine with the following states:
1. **START**: Waits for the start signal. On receiving the start signal, it transitions to the CALC state.
2. **CALC**: Performs the multiplication by iterating through the bits of the multiplicand. The state transitions back to START after completion.

![Control Unit State Diagram](images/statediagram.png)

### Data Path

The Data Path module performs the multiplication operation by accumulating partial products and computes final result 'P'.

#### Inputs
- `clk`: Clock signal.
- `reset`: Reset signal to initialize registers.
- `enReg`: Enable signal to load the input values into internal registers.
- `enCount`: Enable signal to increment the count.
- `enShift`: Enable signal to perform shift operations.
- `ready`: Signal indicating that the result is ready.
- `A`, `B`: 16-bit input values to be multiplied.

#### Outputs
- `P`: 32-bit product of the multiplication.
- `count`: 4-bit counter value.

The Data Path uses registers to store the multiplicand, multiplier, and intermediate results. It shifts the multiplicand and accumulates the partial products in each clock cycle.

![Data Path Diagram](images/datapath.png)

#### Testbench

The testbench verifies the functionality of the Top Module by providing test cases and checking the output.

## Running the Project

### Prerequisites

To run this project, you need a SystemVerilog simulator (e.g., ModelSim).

### Makefile Commands

Run the project using commands given below:

- **Compile the project:**

  ```bash
    make compile
  
- **Simulate the project:**

  ```bash
    make simulate
  
- **Display waveform:**

  ```bash
    make waveform

- **Remove the project:**

  ```bash
    make clean
  
  
### Example Waveform

For the example inputs `A = 1` and `B = 1`, the waveform will show the progression through the states, the accumulation of partial products, and the final product output. The `ready` signal will be asserted when the product is available.

![Example Waveform](images/example_waveform.png)




