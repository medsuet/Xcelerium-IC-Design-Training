# Counter Module

## Description

The `counter` module is a SystemVerilog design implementing a 4-bit counter with asynchronous reset. It includes internal components such as an adder, a comparator, and a multiplexer to handle counting operations.

## Waveform Documentation

For a visual representation of the `counter` module’s behavior, refer to the waveform diagrams located in the `docs` folder. These diagrams illustrate the signal transitions and the internal workings of the module during simulation.

## Diagrams

![Val Ready Protocol Diagram](docs/Waveform.png)  
*Figure 1: Waveform Diagram*


### Waveform Files

- **Location:** `docs/`
- **Contents:** Includes waveform files and diagrams that show the operation of the counter module.

## Makefile

This project includes a Makefile to automate the simulation process using VSIM (ModelSim).

### Makefile Targets

- **help:** Displays help information about available targets.
- **sim:** Runs the simulation using the specified tool (VSIM).
- **clean:** Removes generated files and cleans up the directory.

### Usage

#### Running Simulation

To run the simulation using VSIM, use the following command:

```bash
make sim TOOL=vsim
```

### Cleaning Up

To remove generated files (compiled output and waveform files), run:

```bash
make clean
```
