# Xcelerium_Training
<<<<<<< HEAD
## Table of Contents
1. [Lab 1 - Basics of C language](#lab-1---basics-of-c-language)
2. [Lab 2 - Advanced C Programming Exercises](#lab-2---advanced-c-programming-exercises)
3. [Lab 3 - Shell Scripting & MakeFile](#lab-3---shell-scripting--makefile)
4. [Lab6 RISC-V Assembly Exercises](#lab6-risc-v-assembly-exercises)
5. [LAB 7 - Python](#lab-7---python)

# Lab 1 - Basics of C language

## Overview

<<<<<<< HEAD
`lab1.c` is a C program that includes various functions to demonstrate fundamental concepts and syntax in C programming. This program is divided into several parts, covering basic data types, operators, control structures, functions, arrays, and strings. 
=======
`lab1.c` is a C program that includes various functions to demonstrate fundamental concepts and syntax in C programming. This program is divided into several parts, covering basic data types, operators, control structures, functions, arrays, and strings. Each section contains practical exercises and examples to help understand these concepts better.
>>>>>>> e5fdb7d (Added README.md)

## Contents

1. **Basic Syntax and Data Types**
    - `printSizes()`: Demonstrates the size of various data types and type casting.
    
2. **Operators and Expressions**
    - `simpleCalculator()`: A simple calculator that performs basic arithmetic operations.

3. **Control Structures**
    - `printFibonacci(int n)`: Prints the first `n` terms of the Fibonacci series.
    - `guessingGame()`: A number guessing game.
   
4. **Functions**
    - `isPrime(int num)`: Checks if a number is prime.
    - `factorial(int n)`: Computes the factorial of a number.

5. **Arrays and Strings**
    - `reverseString(char* str)`: Reverses a given string.
    - `secondLargest(int arr[], int size)`: Finds the second largest element in an array.

## How to Use
<<<<<<< HEAD
``` bash
cd xce_lab1
```
1. **Compilation**
    ```sh
    make all
=======

1. **Compilation**
    ```sh
    gcc lab1.c -o lab1
>>>>>>> e5fdb7d (Added README.md)
    ```

2. **Execution**
    ```sh
<<<<<<< HEAD
    make run
    ```
3. **Clean Up**
    ```sh
    make clean
    ```
# Lab 2 - Advanced C Programming Exercises

This project contains a series of exercises in C programming including structures, pointers, dynamic memory allocation, linked lists, file I/O, and unions.
=======
    ./lab1
    ```

# Lab 2 - Advanced C Programming Exercises

This project contains a series of exercises designed to enhance your understanding of advanced C programming concepts, including structures, pointers, dynamic memory allocation, linked lists, file I/O, and unions.
>>>>>>> e5fdb7d (Added README.md)

## Table of Contents
1. [Introduction](#introduction)
2. [Compilation](#compilation)
<<<<<<< HEAD
3. [Running Executables](#running-executables)
4. [Clean Up](#clean-up)
5. [Exercises](#exercises)
=======
3. [Execution](#execution)
4. [Exercises](#exercises)
>>>>>>> e5fdb7d (Added README.md)
   - [Part 1: Basic Operations](#part-1-basic-operations)
   - [Part 2: Structures](#part-2-structures)
   - [Part 3: Pointers and Functions](#part-3-pointers-and-functions)
   - [Part 4: Linked List](#part-4-linked-list)
   - [Part 5: Dynamic Memory Allocation](#part-5-dynamic-memory-allocation)
   - [Part 6: Unions](#part-6-unions)
   - [Part 7: File I/O](#part-7-file-io)

## Introduction
<<<<<<< HEAD
This lab focuses on applying advanced concepts in C programming.
## Compilation
``` bash
cd xce_lab2
```

To compile all the C files and create executables, run:

```bash
make
```
This command will generate the following executables:
- memoryMaze
- lab2
- boothMultiplier
## Running Executables
To run all the generated executables sequentially, use:
```bash
make run
```
To run a specific executable, use one of the following commands:
### Run lab2:
```bash
make run-lab2
```
### Run memoryMaze:
```bash
make run-memoryMaze
```
### Run boothMultiplier:
```bash
make run-boothMultiplier
```
## Clean Up
To clean up the directory by removing object files and executables, run:
```bash
make clean
=======
This lab focuses on applying advanced concepts in C programming. Each part builds on previous knowledge and incorporates new techniques to solve problems.

## Compilation
To compile the code, use the following command:
```bash
gcc -o lab2 lab2.c
```
## Execution
```bash
./lab1
>>>>>>> e5fdb7d (Added README.md)
```
## Exercises

### Part 1: Basic Operations
- **Function Definitions**: Implement basic arithmetic operations.
  - `add`: Adds two integers.
  - `subtract`: Subtracts the second integer from the first.
  - `multiply`: Multiplies two integers.
  - `divide`: Divides the first integer by the second (if the second is not zero).

### Part 2: Structures
<<<<<<< HEAD
- **Student Structure**
- **Department Structure**
- **University Structure** 
=======
- **Student Structure**: Define a structure to store student information.
- **Department Structure**: Define a structure to store department information, which includes an array of students.
>>>>>>> e5fdb7d (Added README.md)

### Part 3: Pointers and Functions
- **Function Pointers**: Define and use function pointers for arithmetic operations.

### Part 4: Linked List
- **Linked List Operations**:
  - `insertAtBeginning`: Insert a node at the beginning of the list.
  - `deleteByValue`: Delete a node by its value.
  - `printList`: Print all the elements in the list.

### Part 5: Dynamic Memory Allocation
- **Dynamic Array**: Create and manipulate a dynamically allocated array.

### Part 6: Unions
- **Union Usage**: Demonstrate the use of unions to store different data types.

### Part 7: File I/O
- **File Operations**:
  - `writeStudentToFile`: Write student information to a text file.
  - `readStudentFromFile`: Read student information from a text file.
  - `writeStudentToBinaryFile`: Write student information to a binary file.
  - `readStudentFromBinaryFile`: Read student information from a binary file.
  - `logMessage`: Log messages to a file.
  - `displayLog`: Display the contents of the log file.

# Lab 3 - Shell Scripting & MakeFile
This lab is designed to provide hands-on experience with Linux shell scripting and makefiles

## How to Use

1. **Compilation**
  Enter the task and the part you want to execute. a and b are the tasks and its parts respectively.

    ```sh
    chmod +x ./taska_b.sh
    ```

2. **Execution**
    ```sh
    ./taska_b.sh
    ```
## Task 5 - Makefiles
<<<<<<< HEAD
This project demonstrates the use of a Makefile for compiling and managing a C program with `main.c` and `functions.c`. It handles multiple source files automatically and implements dependency tracking for header files.
=======
This project demonstrates the use of a Makefile for compiling and managing a C program with `main.c` and `functions.c`. The Makefile includes various targets to build the project, clean up generated files, and compile with debugging symbols. Additionally, it handles multiple source files automatically and implements dependency tracking for header files.
>>>>>>> e5fdb7d (Added README.md)

### Makefile Targets

### Basic Targets

- `all`: Default target that compiles the source files into an executable named `main`.
- `clean`: Removes all object files (`*.o`), dependency files (`*.d`), and the executable `main`.

### Advanced Targets

- `debug`: Compiles the source files with debugging symbols (`-g` flag).
- `%.o`: Compiles individual source files into object files.
- `%.d`: Generates dependency files for the source files.

### Usage

#### To use the Makefile
 run the following command in the terminal:

- Compile the project:
    ```sh
    make
    ```
- Clean the project:
  ```sh
  make clean
  ```
-  Compile with debugging symbols:
   ```sh
   make debug
   ```
<<<<<<< HEAD

# Lab6 RISC-V Assembly Exercises

This lab contains RISC-V assembly programs demonstrating basic operations such as arithmetic calculations and bit manipulation. The programs are run on spike simulator.

## Programs

### Problem 1: Absolute Difference Calculation

**Assembly File:** `Problems/Problem_1/problem_1.s`

### Problem 2: Bit Count in a 32-bit Number

**Assembly File:** `Problems/Problem_2/problem_2.s`

### Problem 3: Factorial of a number

**Assembly File:** `Problems/Problem_3/problem_3.s`

### Problem 4: Reverse an array

**Assembly File:** `Problems/Problem_4/problem_4.s`
### Problem 5: Sorting array using Insertion Sort

**Assembly File:** `Problems/Problem_5/problem_5.s`

### Task 1: restoring division algorithm

**Assembly File:** `Tasks/task_1.s`

### Task 2: setting and clearing a bit

**Assembly File:** `Tasks/task_2.s`

### Task 3: non-restoring division algorithm

**Assembly File:** `Tasks/task_3.s`

## Build and Run

To build and run the programs, use the provided `Makefile`. The Makefile includes rules to assemble, link, and run the programs using Spike.

### Build All Programs
move to directory
``` bash
cd xce_lab6_assembly
```
```bash
make all 
```
### Run a Specific Program

To run a specific program, set the `PROG` variable: x could be 1, 2, 3, 4 and 5.

```bash
make run PROG=Problems/Problem_x/problem_x
```
To run a specific Task, set the `PROG` variable: x could be 1,2 and 3.
```bash
make run PROG=Tasks/task_x
```
### Debug a Specific Program
To debug a specific program, set the `PROG` variable and use the debug rule:
Replace x with 1, 2, 3, 4, and 5.
```bash
make debug PROG=Problems/Problem_x/problem_x
```
To debug a specific task, set `PROG` variable, set x as 1,2 and 3. Use the debug rule:
```bash
make debug PROG=Tasks/task_x 
```
### Clean Up
To clean up the generated files:
```bash
make clean
```
# LAB 7 - Python
This lab contains three tasks:
- problem1.py
- problem2.py
- cacheSimulator.py
## Scripts Description
### problem1.py
This script performs multiplication using Booth's Multiplier algorithm.

### problem2.py
This script performs division using non-restoring division algorithm.

### cacheSimulator.py

This script simulates a direct-mapped cache. It models the behavior of a direct-mapped cache handles read and write operations, and tracks hits and misses.

## Running the Scripts

### Using the Makefile

A `Makefile` is provided to simplify running the scripts. The `Makefile` includes targets to run each script individually or all of them together.

Navigate to the directory containing python scripts
```bash
cd xce_lab7
```
- To run all scripts:
```bash
make all
```
- To run problem1.py:
```bash
make run_problem1
```
- To run problem2.py:
```bash
make run_problem2
```
- To run cacheSimulator.py:
```bash
make run_cache_simulator
```

## Clean Up
```bash
make clean
```
=======
   
>>>>>>> e5fdb7d (Added README.md)
