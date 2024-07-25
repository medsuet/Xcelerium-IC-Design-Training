# Counter (counts upto 13)

## Overview
  This repository contains an implementation of 4 bit Counter that counts upto 13.

## Languages Used
  * System Verilog
  * Makefile 


## Environments Used

  * Linux Ubuntu 22.04.2

# System Design Overview

  Representation of architecture through clear block diagrams is shown below.
## Block Diagram
The block diagram of the Counter is given below.

![Datapath](./docs/counter.png)

# Getting Started



## Installation of Vivado  

Install [Vivado](https://github.com/ALI11-2000/Vivado-Installation) . Follow the instructions provided in the corresponding links to build these tools.

## Build Model and Run Simulation

To build Counter, use the provided Makefile. Follow the steps below for simulation using  Vivado.


### Simulation with Vivado
For simulation on vivado run the following command:

```markdown
make 
```

The waves on vivado will be created that can be viewed by running

```markdown
make viv_waves
``` 

# Successful Implementation

### Implementation with Vivado

Running the `make viv_waves` command generates the terminal log output as shown below:

 ![Vivado](./docs/counter_output.png)

# Waveform Drawn

The expected waveform is shown below:
## Vivado
 ![Waveform](./docs/wavedrom.png)

 

