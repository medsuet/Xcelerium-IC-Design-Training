# Python Tasks

This repository contains various Python scripts, along with a Makefile to simplify running and managing these scripts.

## Directory Structure

Python_Tasks/
├── src/
│ ├── Booth.py
│ ├── cache.py
│ ├── Non_Restoring.py
├── Makefile
└── README.md


## Files

- **src/Booth.py**: Contains the Python implementation for Booth's algorithm.
- **src/cache.py**: Contains the Python implementation related to cache management.
- **src/Non_Restoring.py**: Contains the Python implementation for the non-restoring division algorithm.
- **Makefile**: Makefile to manage the execution and cleanup of the Python scripts.
- **README.md**: This README file.

## Prerequisites

To run the Python scripts, you need to have the following installed:

- **Python 3.x**

## Usage

### Running a Python Script

To run a specific Python script, use the `make run` command with the `SCRIPT` variable set to the name of the script. For example, to run the `Booth.py` script, use:

```sh
make run SCRIPT=Booth.py

