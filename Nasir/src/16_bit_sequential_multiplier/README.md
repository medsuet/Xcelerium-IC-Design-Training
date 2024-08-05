# 16-bit Sequential Booth Multiplier 

## Table of Contents
- [Overview](#overview)
- [Top-Level Module](#top-level-module)
- [Datapath Module](#datapath-module)
- [Datapath Block Diagram](#datapath-block-diagram)
- [Controller Module](#controller-module)
- [Controller State Transition Graph](#controller-state-transition-graph)
- [Sequential Multiplier Integration](#sequential-multiplier-integration)
- [Usage Compilation and Simulation](#usage-compilation-and-simulation)

## Overview
This project implements a 16-bit sequential Booth multiplier, designed for efficient multiplication of signed integers. The design features a `Datapath` module for arithmetic operations and a `Controller` module for managing control signals and state transitions. A valid-ready interface is used to manage the data flow between the testbench (source) and the multiplier (destination).


## Top-Level Module
The top-level module integrates the `Datapath` and `Controller` to form the complete multiplier system. It handles the valid-ready interface signals along with the core multiplication inputs and outputs.

### I/O Description
- **Inputs**:
  - **Multiplicand (16-bit)**: The number to be multiplied.
  - **Multiplier (16-bit)**: The number to multiply by.
  - **Clock and Reset**: Standard control signals for synchronous operation.
  - **start**: start the multiplication.

- **Outputs**:
  - **Product (32-bit)**: The final multiplication result.
  - **ready**: Indicates that the output data is ready to read.

![Top Level Diagram](./docs/Top_level_diagram.png)

## Datapath Module
The `Datapath` module performs the core arithmetic operations, including the Booth multiplication steps and managing internal registers.

## Datapath Block Diagram

![Datapath Block Diagram](./docs/datapath_16_bit_sequential_multiplier.png)

## Controller Module
The `Controller` module handles the state machine logic, orchestrating the sequence of operations based on the valid-ready signals and other control inputs.

## Controller State Transition Graph

![Controller State Transition Graph](./docs/Controller.png)

## Sequential Multiplier Integration
The `seq_multiplier` module combines the `Datapath` and `Controller`, managing the overall operation of the multiplier.

## Usage Compilation and Simulation

#### Compile and Run
```bash
  make 
```
```bash
  make all
```
```bash
  make run
```

#### Delete .o . vcd and .exe file

```bash
  make clean
```

#### Simulation

```bash 
  make vsim
```

