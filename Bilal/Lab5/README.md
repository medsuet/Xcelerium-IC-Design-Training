
# RISC-V Assembly Programming

## Overview:

The purpose of this lab is to understand RISC-V ISA, Spike simulator, and debugging techniques.

## Problems:

Here are some of the problems to understand the basics assembly programming.

### Problem No. 1
In this problem, we have to write a program to calculate the absolute difference between two numbers. The code is provided in the folder `src\prob1_absDiff.s`
### Problem No. 2
In this problem, we have to write a program to count the number of set bits in a 32-bit word. The code is provided in the folder `src\prob1_countSetBits.s`
### Problem No. 3
In this problem, we have to write a program to calculate the factorial of a number. The code is provided in the folder `src\prob1_factorialCal.s`
### Problem No. 4
In this problem, we have to write a program to reverse an array in-place. The code is provided in the folder `src\prob1_reverseArray.s`
### Problem No. 5
In this problem, we have to write a program to implement an insertion sort algorithm for sorting an array. The code is provided in the folder `src\prob1_insertionSort.s`

## Tasks:

In the folder `src\tasks`, there are some tasks to understand the working of spike. If you want to learn more then click here to check a tutorial.

## 🔗 Links

https://youtu.be/dbpDsXpp9zU?si=PvY7lwJy_lqOXVUz


## Usage

To run all the files using `MakeFile` Make a copy of all the files and paste these files in the document section of your computer.

### Compiling
To compile all executables:

```sh

make all

```
### Runnig a specific Executable
To run a specific executable with Spike:

```sh

make run EXECUTABLE=executable_name

```
### Debugging a specific Executable
To debug a specific executable with Spike:
```sh
make debug EXECUTABLE=executable_name

```
### Cleaning
    ```sh

    make clean

    ```
