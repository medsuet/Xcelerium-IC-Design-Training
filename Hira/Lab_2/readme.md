# C Language Lab Implementation
## Materials Needed
- Computer with a C compiler (e.g., GCC)
- Debugger (GDB)
- Text editor or IDE

## Implemented Tasks

### Part 1: Pointer Basics and Arithmetic

#### Task 1.1: Basic Pointer Usage
- **Description**: Create a program that demonstrates basic pointer usage by declaring an integer variable and a pointer to it. Print the value of the variable using both direct access and the pointer. Modify the value using the pointer and print the new value.
- **File**: `template_code_Part1.c`

#### Task 1.2: Swapping Integers
- **Description**: Implement a function that swaps two integers using pointers.
- **File**: `template_code_Part1.c`

#### Task 1.3: Array and Pointer Arithmetic
- **Description**: Create an array of integers and use pointer arithmetic to:
  - Print all elements of the array
  - Calculate the sum of all elements
  - Reverse the array in-place
- **File**: `template_code_Part1.c`

### Part 5: Advanced Tasks

#### Task 5.1: Memory Management Maze
- **Description**: Implement a memory management maze using pointers and dynamic allocation. The maze will be represented as a 2D array, dynamically allocated with pointers. Navigate the maze using a pointer to the current position, checking for walls and paths.
- **File**: `Task5/Maze.c`

#### Task 5.2: Sequential Multiplier
- **Description**: Implement Booth's multiplication algorithm in C. The function takes two signed integers as input and returns their product. Include test functions to verify the correctness of the multiplier function with various test cases.
- **File**: `Task5/Multiplier.c`

### Additional Files

- **logfile.txt**: Contains logs of the program execution.
- **filehandling.txt**: Describes file handling operations performed in the tasks.

## Compilation and Execution

To compile and run the code for Part 1:

```sh
gcc -o template_code_Part1 template_code_Part1.c && ./template_code_Part1
gcc -o Maze Task5/Maze.c && ./Maze
gcc -o Multiplier Task5/Multiplier.c && ./Multiplier

