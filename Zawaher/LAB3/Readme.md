# Digital Design and Verification Training - Shell Scripting & MakeFile


## Table of Contents

- [Introduction](#introduction)
- [Lab 1: Basic Shell Scripting](#lab-1-basic-shell-scripting)
- [Lab 2: Control Structures](#lab-2-control-structures)
- [Lab 3: Functions and Arrays](#lab-3-functions-and-arrays)
- [Lab 4: File Operations and Text Processing](#lab-4-file-operations-and-text-processing)
- [Lab 5: Introduction to Makefiles](#lab-5-introduction-to-makefiles)
- [Helping Material](#helping-material)

## Introduction

This repository contains lab exercises aimed at providing practical experience with Linux Shell scripting and Makefiles. It assumes a basic understanding of Linux commands and provides exercises to strengthen your skills in scripting, control structures, functions, arrays, file operations, text processing, and Makefiles.

## Lab 1: Basic Shell Scripting

### Exercise 1.1: Hello World

Create a simple shell script (`hello.sh`) that prints "Hello, World!" when executed.

### Exercise 1.2: Variables and User Input

Write a script that asks for the user's name, stores it in a variable, and prints a greeting using the stored name.

### Exercise 1.3: Command-line Arguments

Create a script that accepts two numbers as command-line arguments, calculates their sum, and prints the result.

## Lab 2: Control Structures

### Exercise 2.1: If-Else Statement

Write a script that checks if a number (provided as an argument) is even or odd using an if-else statement.

### Exercise 2.2: For Loop

Create a script that prints the first 10 multiples of a number (provided as an argument) using a for loop.

### Exercise 2.3: While Loop

Implement a simple guessing game using a while loop where the user guesses a randomly generated number.

## Lab 3: Functions and Arrays

### Exercise 3.1: Functions

Create a function that calculates the factorial of a number and call this function with different numbers.

### Exercise 3.2: Arrays

Define an array of fruits, write a function that prints each fruit, add a new fruit, and call the function again.

### Exercise 3.3: Associative Arrays

Create an associative array of country-capital pairs, implement a function that retrieves the capital for a given country with error handling.

## Lab 4: File Operations and Text Processing

### Exercise 4.1: File Reading

Write a script that reads a text file line by line, prefixes each line with its line number, and prints it.

### Exercise 4.2: Text Processing

Create a log file and write a script that counts total entries, lists unique usernames, and counts actions per user.

### Exercise 4.3: File Backup

Implement a script that creates a compressed tar backup of a specified directory with error handling.

## Lab 5: Introduction to Makefiles

### Exercise 5.1: Basic Makefile

Create a simple C program with main.c and functions.c, and write a Makefile to compile them into an executable with 'all', 'clean', and individual object file targets.

### Exercise 5.2: Advanced Makefile

Extend the previous Makefile to handle multiple source files, add a 'debug' target with debugging symbols, and implement dependency tracking for header files.

### Exercise 5.3: Makefile for a Shell Script Project

Create a project with multiple shell scripts, and write a Makefile that checks syntax errors, runs unit tests, and installs scripts to a specified directory.


## Building Executables

The Makefile automatically finds all `.c` source files in the `src/` directory and compiles them into corresponding object files in the `obj/` directory. These object files are then linked to create executable binaries stored in the `bin/` directory.

To build all C executables:
```markdown

make all_C
```

### Debugging

You can compile C code with debugging symbols using:

```marhdown

    make debug

```

## Shell Script Operations

### Checking Syntax

To verify the syntax of all Shell scripts in the scripts/ directory:

```markdown

    make check-syntax

```
### Installation

To install Shell scripts into a specified directory (install_dir/):

```markdown
make install
```

## Cleaning

To clean up generated object files and executables for C compilation:

```markdown

make clean
```

