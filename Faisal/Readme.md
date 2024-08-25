# Xcelerium IC Design Training

This repository contains the solved exercises and labs for the Xcelerium IC Design Training. The directory structure is organized by lab assignments, each containing relevant source code and resources.

## Getting Started

### Prerequisites

Ensure you have the following installed on your system:
- GCC (for compiling C programs)
- TCL (for running TCL scripts)
- Spike ( for running Assembly files)

### Directory Structure

- **Combinational Multiplier**
  - Contains design and test related to combinational multiplier.
  
- **Lab1 Basic C Programming**
  - Contains tasks and lab exercises related to basic C programming.

- **Lab2 Advance C Programming**
  - Contains tasks and lab exercises related to advance C programming.

- **Lab3 Shell Scripting and makefile**
  - Contains tasks and lab exercises related to shell scripting and makefile.

- **Lab4 Tcl Scripting**
  - Contains tasks related to the use of tcl files.
  
- **Lab6 Assembly Task**
  - Contains tasks and exercises related to assembly programming.
  
- **Lab7 Python Tasks**
  - Contains tasks and exercises related to Python programming.

### Cloning the Repository

To clone the repository, use the following command:

```bash
git clone <repository_url>
cd Xcelerium-IC-Design-Training
```

## Running The Code

Navigate to the labs directory, for example:
```bash
cd Faisal/lab1
```


Compile and run the C program, for example:

```bash
gcc lab1.c -o lab1
./lab1
```

## Running TCL Files

To run a TCL script, navigate to the directory containing the script and use the tclsh command followed by the script name. For example:

```bash
tclsh script_name.tcl
```

## Running Assembly Files

To run assembly files, navigate to the directory containing the assembly files and use the this command followed by the assembly name. For example: program names such as non_restoring_division, restoring_division, set_or_clear_bit,task1

```bash
make PROG=<program_name> build
```

### Clean the Files
```bash
make clean
```

## Running Python Files

To run python files, navigate to the directory containing the python files and use the this command followed by the program name. For example: program names such as booth_multiplier.py, non_restoring_division.py, cache_simulator.py

```bash
python3 filename.py
```


