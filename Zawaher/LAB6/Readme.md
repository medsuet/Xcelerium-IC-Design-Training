# Digital Design and Verification Training Lab Experiment

## Objective
This lab experiment aims to bridge the gap between high-level algorithm implementation in Python and hardware design in SystemVerilog by implementing core concepts in digital systems design and computer architecture.

## Prerequisites
- Basic understanding of programming concepts
- Python
- Text editor (e.g., nano, vim, or gedit)

## Tasks Overview


### 1. Implement 32-bit Booth’s Multiplier in Python
- **Task:** Implement Booth's multiplication algorithm for 32-bit integers.
- **Description:** Write a Python program to multiply two 32-bit integers using Booth's algorithm, which efficiently handles both positive and negative multiplicands by encoding them in two's complement form.

### 2. Implement 32-bit Unsigned Non-Restoring Division Algorithm in Python
- **Task:** Implement the non-restoring division algorithm for 32-bit unsigned integers.
- **Description:** Develop a Python program that performs division operations using the non-restoring division algorithm, involving shift and subtract/add operations to compute the quotient and remainder.

### 3. Implement a Simple Cache Simulator
- **Task:** Implement a direct-mapped cache simulator in Python.
- **Description:** Create a simulator that models a direct-mapped cache with 128 cache lines, handling read and write operations, tracking hits and misses, and reporting cache performance statistics.

## Usage
The Makefile is given to run each file. To run each file use:
    
```sh

    make  Execute=file_name_to_executed 

```
    
