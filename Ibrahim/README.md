# Xcelerium_Training
## Table of Contents
1. [Lab 1 - Basics of C language](#lab-1---basics-of-c-language)
2. [Lab 2 - Advanced C Programming Exercises](#lab-2---advanced-c-programming-exercises)
3. [Lab 3 - Shell Scripting & MakeFile](#lab-3---shell-scripting--makefile)

# Lab 1 - Basics of C language

## Overview

`lab1.c` is a C program that includes various functions to demonstrate fundamental concepts and syntax in C programming. This program is divided into several parts, covering basic data types, operators, control structures, functions, arrays, and strings. Each section contains practical exercises and examples to help understand these concepts better.

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

1. **Compilation**
    ```sh
    gcc lab1.c -o lab1
    ```

2. **Execution**
    ```sh
    ./lab1
    ```

# Lab 2 - Advanced C Programming Exercises

This project contains a series of exercises designed to enhance your understanding of advanced C programming concepts, including structures, pointers, dynamic memory allocation, linked lists, file I/O, and unions.

## Table of Contents
1. [Introduction](#introduction)
2. [Compilation](#compilation)
3. [Execution](#execution)
4. [Exercises](#exercises)
   - [Part 1: Basic Operations](#part-1-basic-operations)
   - [Part 2: Structures](#part-2-structures)
   - [Part 3: Pointers and Functions](#part-3-pointers-and-functions)
   - [Part 4: Linked List](#part-4-linked-list)
   - [Part 5: Dynamic Memory Allocation](#part-5-dynamic-memory-allocation)
   - [Part 6: Unions](#part-6-unions)
   - [Part 7: File I/O](#part-7-file-io)

## Introduction
This lab focuses on applying advanced concepts in C programming. Each part builds on previous knowledge and incorporates new techniques to solve problems.

## Compilation
To compile the code, use the following command:
```bash
gcc -o lab2 lab2.c
```
## Execution
```bash
./lab2
```
## Exercises

### Part 1: Basic Operations
- **Function Definitions**: Implement basic arithmetic operations.
  - `add`: Adds two integers.
  - `subtract`: Subtracts the second integer from the first.
  - `multiply`: Multiplies two integers.
  - `divide`: Divides the first integer by the second (if the second is not zero).

### Part 2: Structures
- **Student Structure**: Define a structure to store student information.
- **Department Structure**: Define a structure to store department information, which includes an array of students.

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
This project demonstrates the use of a Makefile for compiling and managing a C program with `main.c` and `functions.c`. The Makefile includes various targets to build the project, clean up generated files, and compile with debugging symbols. Additionally, it handles multiple source files automatically and implements dependency tracking for header files.

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
   