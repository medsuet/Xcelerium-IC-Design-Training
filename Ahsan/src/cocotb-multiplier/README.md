# Sequential Multiplier Project

This project implements a sequential multiplier using Verilog and simulates it using cocotb. The project structure includes source files for the controller, datapath, and top module of the multiplier, along with testbenches for simulation.

## Project Structure

├── src
│ ├── Controller.sv
│ ├── Datapath.sv
│ └── Seq_Mul_top.sv
└── test
  ├── Makefile
  ├── multiplier_tb.py
└── multiplier_tb.sv


## Requirements

- Python 3.x
- `cocotb`
- `iverilog` (for Verilog simulation)
- `virtualenv` (for virtual environment creation)

## Setup Instructions

### Step 1: Clone the Repository

Clone this repository to your local machine:

```bash
git clone <repository_url>
cd <repository_name>
```
### Step 2: Create a virtual environment

```
python3 -m venv venv
source venv/bin/activate  
```

### Step 3: Install dependencies

```
pip install cocotb
```

### Step 4: Run Simulation

```
cd test
make
```
##File Description

- Controller.sv: Verilog module for the controller of the sequential multiplier.
- Datapath.sv: Verilog module for the datapath of the sequential multiplier.
- Seq_Mul_top.sv: Top module combining the controller and datapath.
- multiplier_tb.sv: SystemVerilog testbench for the multiplier.
- multiplier_tb.py: Python testbench using cocotb for verification.
- Makefile: Makefile to automate the simulation process.






