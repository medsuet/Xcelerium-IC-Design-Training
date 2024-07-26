# ADDER 

## Overview
  This repository contains an implementation of adder that adds 1 to a four bit number using the finite state machine(FSM) 

## Languages Used
  * System Verilog
  * Makefile 


## Environments Used

  * Linux Ubuntu 22.04.2

# System Design Overview

  Representation of architecture through clear block diagrams is shown below.
## State Machine
The  state machine of the adder is given below.

![](./docs/Adder_Controller.drawio.png)

# Getting Started



## Installation of Vivado  

Install [Vivado](https://github.com/ALI11-2000/Vivado-Installation) . Follow the instructions provided in the corresponding links to build these tools.

## Build Model and Run Simulation

To build Adder, use the provided Makefile. Follow the steps below for simulation using  Vivado.


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

 ![Vivado](./docs/adder_output.png)

# Waveform Drawn

The expected waveform is shown below:

 ![Waveform](./docs/waveform.png)

 

