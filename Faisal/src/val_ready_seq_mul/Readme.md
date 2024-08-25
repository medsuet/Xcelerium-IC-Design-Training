# Sequential Multiplier

## Overview

The Sequential Multiplier is a hardware implementation of Booth's multiplication algorithm.This design include the state transition diagram, datapath and its controller, which is an efficient way to perform binary multiplication. This project includes System Verilog codes, testbenches, and its documentation.

## Directory Structure

- `docs/`: Contains top level diagram, datapath and controller images related to the Sequential Multiplier project.
- `src/`: Contains System Verilog codes files for the Sequential Multiplier.
- `test/`: Contains testbenches for verifying the functionality of the Sequential Multiplier.

### Signals
- **Inputs to `controller`**:
  - **src_valid**: Indicates that the testbench has valid data available (multiplicand and multiplier).
  - **dest_ready**: Indicates that the testbench is ready to accept the result which is product in our case.

- **Outputs from `controller`**:
  - **src_ready**: Indicates that the multiplier is ready to get data from the testbench. It is not busy
  - **dest_valid**: Indicates that the multiplication result is valid and ready to be read by the testbench.

## Val_Ready Handshake Protocol
Here is a simple representation of the val ready handshake protocol diagram:
![alt text](docs/val_ready_handshake.png)

## Top Level Diagram
Here is a simple representation of the top level diagram:
![alt text](docs/top_level_diagram(2)(1).png)

## Datapath and Contoller
Here is a simple representation of the datapath and controller diagram:
![alt text](docs/datapath(2).png)

## State Transition Diagram
Here is a simple representation of the state transition diagram:
![alt text](docs/controller_val_raedy(1).png)


## How to use

### Compile
Compile the Verilog Code:
```
make 
```

### Simulate
Simulate the Verilog Code:
```
make simulate
```

### cleanup
```
make clean
```