# Combination Signed Multiplier

## Overview
  This repository contains an implementation of 16 bit signed multiplier but can be used for any size by changing the width of inputs and output in the header file.

## Languages Used
  * System Verilog
  * Makefile 


## Environments Used

  * Linux Ubuntu 22.04.2

# System Design Overview

  Representation of architecture through clear block diagrams is shown below.
## Block Diagram
The block diagram of the  combinational signed multiplier is given below.
![Datapath](./docs/Signed_Multiplier.drawio.png)

## Signed Multiplication Algorithm
  * Take the **compliment** of the every **partial product MSB** except the **last partial product**
  * Take the **compliment** of **last partial product each bit except MSB**
  * Add 1 at the **n+1** position and at **2n** position


# Getting Started



## Installation of Vivado  

Install [Vivado](https://github.com/ALI11-2000/Vivado-Installation) . Follow the instructions provided in the corresponding links to build these tools.

## Build Model and Run Simulation

To build Signed Combinational Multplier, use the provided Makefile. Follow the steps below for simulation using  Vivado.


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

 ![Vivado](./docs/signed_multiplier.png)

# Waveform Drawn

The expected waveform is shown below:
## Vivado
 ![Waveform](./docs/waveform.png)

 

