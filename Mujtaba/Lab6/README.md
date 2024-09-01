# Intro to RISC V Assembly Programming

This folder contains a set of RISC V Assembly exercises aimed to master the RISC V Assembly concepts.

## Problem 1: Absolute Difference of two numbers

- **File:** `abs_diff.S`
- **Description:** Finding the absolute difference between two numbers. Absolute means from two numbers, the greater one is subtracted from the smallest integer. You have to change the numbers accordingly under the `.section .data`.

## Problem 2: Counting of Set Bit in 32-bit number

- **File:** `count_sbits.S`
- **Description:** Count the number of ones in 32-bit binary word. You have to change the numbers accordingly under the `.section .data`.

## Problem 3: Finding Factorial of Number

- **File:** `factorial.S`
- **Description:** Find the factorial of a number. You have to change the number accordingly under the `.section .data`.

## Problem 4: Reverse Array in-place

- **File:** `reverse_array.S`
- **Description:** Reverse the elements of array in place. You to change the array elements accordingly under the `.section .data`.

## Problem 5: Implementation of Insertion Sort Algorithm

- **File:** `insertion_sort.S`
- **Description:** Sort the elements of array in RISC V assembly programming using insertion sort algorithm. You have to change the array elements accordingly under the `.section .data`.

## Task 1: Restoring Division Algorithm

- **File:** `resorting_division.S`
- **Description:** Implements the division of two unsigned numbers using the resorting division algorithm in RISC V Assembly. You have to changes the numbers to be divided accordingly under the `.section .data`.

## Task 2: Setting or Clearing Bits in 32-bit number

- **File:** `set_clear_bit.S`
- **Description:** Setting or Clearing the bit of number. Setting means placing one at certain bit index. Clearing means placing zero at certain bit index. You have to changes the numbers and bit index accordingly under the `.section .data`.


## Task 3: Non-Resorting Division Algorithm

- **File:** `nonRestore_division.S`
- **Description:** Implements the division of two unsigned numbers using the non-restoring algorithm in RISC V Assembly. You have to changes the numbers to be divided accordingly under the `.section .data`.


# Run the script
To run all the scripts of the RISC V Assembly, you have to first download the RISC V Tool-Chain either 32-bit or 64-bit. To simulate or run the scripts, you have to download the Spike Simulator.
- **To make all the builds files:** `make`
- **To check or run the scripts:** `make run`
- **To clean all the builds:** `make clean`
- **To run scripts on Spike in the debug mode** `make debug prog=<file_name_without_extension>`
