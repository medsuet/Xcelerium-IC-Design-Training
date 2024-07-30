# Sequential Multiplier

## Overview

The Sequential Multiplier is a hardware implementation of Booth's multiplication algorithm.This design include the state transition diagram, datapath and its controller, which is an efficient way to perform binary multiplication. This project includes System Verilog codes, testbenches, and its documentation.

## Directory Structure

- `docs/`: Contains top level diagram, datapath and controller images related to the Sequential Multiplier project.
- `src/`: Contains System Verilog codes files for the Sequential Multiplier.
- `test/`: Contains testbenches for verifying the functionality of the Sequential Multiplier.

## Top Level Diagram
Here is a simple representation of the top level diagram:
![alt text](docs/top_level_diagram(2).png)

## Datapath and Contoller
Here is a simple representation of the datapath and controller diagram:
![alt text](docs/datapath.png)

## State Transition Diagram
Here is a simple representation of the state transition diagram:
![alt text](docs/controller(2).png)


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