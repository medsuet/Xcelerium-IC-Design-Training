# Sequential Adder with State Machine

This repository contains a Sequential Adder implemented using a state machine design in SystemVerilog. The design is tested using a comprehensive testbench to validate its functionality.

## Project Structure

- `sequential_adder.sv`: This is the main Verilog file implementing the sequential adder using a finite state machine (FSM) approach.
- `tb_adder.sv`: The testbench for the sequential adder, used to verify the correctness of the design.

## State Machine Diagram

The sequential adder operates based on the following state machine diagram:

![State Machine](docs/images/state_machine.png)

### State Descriptions
- **S0**: Initial state where the output is 1 if the input is 0.
- **S1**: State where the adder outputs 0 for input 0.
- **S2**: State where the adder outputs 1 for input 1 and 0 for input 0.

## Waveform Analysis

The following waveform demonstrates how the sequential adder processes a 4-bit input with an active high reset:

![Waveform Example](docs/images/waveform_example.png)

**Explanation:**
- The waveform illustrates the behavior of the sequential adder for the input sequence `0011` with an active high reset. The 'A' signal represents the input bits being fed into the adder, while the 'result' signal shows the output bits.

  - For the input bit `0`, the state machine transitions from state `S0` to `S2`, producing an output of `1`.
  - For the input bit `0`, the state machine remains in state `S2`, continuing to output `0`.
  - For the input bit `0`, the state machine remains in state `S2`, outputting `0`.
  - For the input bit `0`, the state machine remains in state `S2`, outputting `0`.

- As the input is feeded in form of LSB to MSB bits so expected result is 0001 as shown in above waveform.

This pattern illustrates how the state machine processes each bit of the input in sequence, according to the defined state transitions and outputs.

## Questa Sim Results

The simulation results obtained from Questa Sim are shown below, validating the design and functionality of the sequential adder:

![Questa Sim Results](docs/images/expected_output.png)

## How to Run the Testbench

To run the testbench and simulate the sequential adder:

1. Compile the design and testbench files using your preferred SystemVerilog simulator.
2. Run the simulation and observe the output for different input sequences.
3. Verify the output against the expected results as per the state machine design and truth table.
