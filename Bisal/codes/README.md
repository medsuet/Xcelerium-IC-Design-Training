# C Language Lab Experiments

## Description
This repository contains various C programs developed to gain practical experience with advanced pointer concepts, pointer arithmetic, function pointers, dynamic memory allocation, structures, unions, and file I/O. The tasks range from basic pointer usage to complex memory management and data structures.

## Objective
- Gain practical experience with advanced pointer concepts in C, including pointer arithmetic, pointers and arrays, and function pointers.
- Master usage of the GCC compiler and GDB.

## Materials Needed
- Computer with a C compiler (e.g., GCC)
- Debugger (GDB)
- Text editor or IDE

## Tasks Description

### Part 1: Pointer Basics and Arithmetic
1. **Basic Pointer Usage**:
   - Declare an integer variable and a pointer to it.
   - Print the value of the variable using both direct access and the pointer.
   - Modify the value using the pointer and print the new value.

2. **Swap Function**:
   - Implement a function that swaps two integers using pointers.

3. **Pointer Arithmetic**:
   - Create an array of integers and use pointer arithmetic to print all elements, calculate the sum, and reverse the array in-place.

### Part 2: Pointers and Arrays
1. **2D Array Operations**:
   - Initialize a 2D array with random values.
   - Print the 2D array.
   - Find the maximum element in the 2D array.
   - Calculate the sum of each row in a 2D array.

### Part 3: Function Pointers
1. **Sorting Algorithms**:
   - Implement Bubble Sort and Selection Sort.
   - Use a function pointer to sort the array using the implemented algorithms.

2. **Calculator**:
   - Implement a simple calculator program using function pointers for basic arithmetic operations (addition, subtraction, multiplication, division).

### Part 4: Advanced Challenge
1. **Linked List**:
   - Implement a simple linked list with operations to insert a node at the beginning, delete a node by value, and print the list.
   - Use function pointers to create a generic linked list that can store different data types.

### Part 5: Dynamic Memory Allocation
1. **Dynamic Array**:
   - Dynamically allocate an array of integers, allow user input for the size and elements, and calculate the sum and average of the elements.
   - Use `realloc()` to extend an existing dynamically allocated array.
   - Implement a simple memory leak detector.

### Part 6: Structures and Unions
1. **Student Structure**:
   - Create a structure to represent a student with fields for name, ID, and grades.
   - Implement functions to input student data, calculate the average grade, and print student information.
   - Create a nested structure to represent a university with departments and students.
   - Implement a union to store different types of data (int, float, char).

### Part 7: File I/O
1. **File Operations**:
   - Write the student data (from Part 6) to a text file and read it back.
   - Modify the program to handle binary format.
   - Implement a simple log file system to log messages with timestamps and read/display the log.

### Final Tasks
1. **Booth's Multiplier**:
   - Implement Booth's multiplication algorithm with unit tests.
   - Write test cases for various scenarios.

2. **Memory Management Maze**:
   - Implement a function to dynamically allocate memory for a 2D array representing a maze.
   - Navigate the maze using pointers and recursively explore valid adjacent positions.
   - Deallocate the dynamically allocated memory to avoid memory leaks.

## How to Run
1. **Clone the repository**:
   ```sh
   git clone <repository_url>
   cd <repository_directory>
2. **Compile the C file**:
   ```sh
   gcc -o output_file source_file.c
3. **Run the compiled programs**:
   ```sh
   ./output_file

   
