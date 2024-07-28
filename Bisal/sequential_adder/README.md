# Sequential Adder with State Machine

This repository contains a Sequential Adder implemented using a state machine design in SystemVerilog. The design is tested using a comprehensive testbench to validate its functionality.

## Project Structure

- `sequential_adder.sv`: This is the main Verilog file implementing the sequential adder using a finite state machine (FSM) approach.
- `tb_adder.sv`: The testbench for the sequential adder, used to verify the correctness of the design.

## State Machine Diagram

The sequential adder operates based on the following state machine diagram:

![State Machine](state_machine.png)

### State Descriptions
- **S0**: Initial state where the output is 1 if the input is 0.
- **S1**: State where the adder outputs 0 for input 0.
- **S2**: State where the adder outputs 1 for input 1 and 0 for input 0.

### Truth Table
The truth table for the sequential adder based on the FSM design:

| Present State | Input 1 | Input 0 | Next State | Output |
|---------------|---------|---------|------------|--------|
| S0            | S1      | S1      | 0          | 1      |
| S1            | S1      | S2      | 0          | 1      |
| S2            | S2      | S2      | 1          | 0      |

## How to Run the Testbench

To run the testbench and simulate the sequential adder:

1. Compile the design and testbench files using your preferred SystemVerilog simulator.
2. Run the simulation and observe the output for different input sequences.
3. Verify the output against the expected results as per the state machine design and truth table.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

Special thanks to all the contributors and supporters of this project.

