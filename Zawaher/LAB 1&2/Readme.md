# Digital Design and Verification Training - C Language Lab

## Objective
The objective of this lab is to gain practical experience with advanced pointer concepts in C, including pointer arithmetic, pointers and arrays, and function pointers. This lab also covers basic syntax, data types, operators, expressions, control structures, functions, arrays, and strings in C.

## Materials Needed
- Computer with a C compiler (e.g., GCC)
- Text editor or IDE

## LAB 0

### Task 0.1: Basic Syntax and Data Types
**Description**: 
- Write a program that declares variables of different data types (int, float, double, char) and prints their sizes using the `sizeof` operator.
- Demonstrate type casting between these data types.

**Usage**: 
This task does not require any arguments to run. The function `printSizes()` is called directly in the `main` function.

### Task 0.2: Operators and Expressions
**Description**: 
- Create a program that takes two numbers as input and performs all arithmetic operations (+, -, *, /, %) on them.
- Implement a simple calculator that uses the switch statement to perform operations based on user input.

**Usage**: 
Run the program and enter the required numbers and operator when prompted. The function `simpleCalculator()` is called directly in the `main` function.

### Task 0.3: Control Structures
**Description**: 
- Write a program that prints the Fibonacci sequence up to `n` terms (where `n` should be user input) using a for loop.
- Implement a guessing game where the computer generates a random number, and the user tries to guess it. Use if-else statements to provide "higher" or "lower" hints.

**Usage**: 
Run the program and follow the prompts for each subtask:
- For Fibonacci sequence: Enter the number of terms when prompted. The function `printFibonacci(int n)` is called directly in the `main` function.
- For guessing game: Follow the prompts to guess the number. The function `guessingGame()` is called directly in the `main` function.

### Task 0.4: Functions
**Description**: 
- Create a function that checks if a number is prime. Use this function to print all prime numbers between 1 and 100.
- Implement a recursive function to calculate the factorial of a number.

**Usage**: 
These tasks do not require any arguments to run. The functions `isPrime(int num)` and `factorial(int n)` are called directly in the `main` function.

### Task 0.5: Arrays and Strings
**Description**: 
- Write a program that reverses a string without using any library functions.
- Implement a function that finds the second largest element in an array.

**Usage**: 
These tasks do not require any arguments to run. The functions `reverseString(char* str)` and `secondLargest(int arr[], int size)` are called directly in the `main` function.


## LAB 1

### Part 1: Pointer Basics and Arithmetic

- **Task 1.1:** Create a program that demonstrates basic pointer usage.
- **Task 1.2:** Implement a function that swaps two integers using pointers.
- **Task 1.3:** Create an array of integers and use pointer arithmetic to print elements, calculate the sum, and reverse the array.

**Usage**: 
These tasks do not require any arguments to run. The functions `swap(int* a, int* b)`, `reverseArray(int arr[], int size)`, and other pointer operations are called directly in the `main` function.

### Part 2: Pointers and Arrays

- **Task 2.1:** Create a 2D array (matrix) of integers and write functions to initialize, print, and find the maximum element in the matrix.
- **Task 2.2:** Implement a function that calculates the sum of each row in a 2D array.

**Usage**:
 These tasks involve working with matrices and arrays. The functions `initializeMatrix(int rows, int cols, int (*matrix)[cols])`, `printMatrix(int rows, int cols, int (*matrix)[cols])`, `findMaxInMatrix(int rows, int cols, int (*matrix)[cols])`, and `sumOfMatrixRow(int rows, int cols, int (*matrix)[cols])` are called directly in the `main` function.


### Part 3: Function Pointers

- **Task 3.1:** Create an array of integers and implement Bubble sort and Selection sort algorithms.
- **Task 3.2:** Create a function pointer for the sorting algorithms and use it to sort the array.
- **Task 3.3:** Implement a simple calculator program using function pointers for basic arithmetic operations.

**Usage**:
 These tasks demonstrate the usage of function pointers. The functions `bubbleSort(int arr[], int size)`, `selectionSort(int arr[], int size)`, and the calculator functions (`add(int a, int b)`, `subtract(int a, int b)`, etc.) are called using function pointers in the `main` function.


### Part 4: Advanced Challenge

- **Task 4.1:** Implement a simple linked list with operations to insert a node at the beginning, delete a node by value, and print the list.
- **Task 4.2:** Use function pointers to create a generic linked list that can store different data types.

**Usage**:
 These tasks involve advanced concepts like linked lists and unions. The functions `insertAtBeginning(struct Node** headRef, union Data newData)`, `deleteByValue(struct Node** headRef, union Data delData)`, and operations on linked lists are demonstrated in the `main` function.

### Part 5: Dynamic Memory Allocation

- **Task 5.1:** Create a program to dynamically allocate an array of integers, input its size and elements, and calculate the sum and average.
- **Task 5.2:** Implement a function that uses `realloc()` to extend an existing dynamically allocated array.
- **Task 5.3:** Create a simple memory leak detector.

**Usage**:
 These tasks involve dynamic memory management. The functions `allocateMemory(size_t size)`, `extendArray(int** arr, int* size, int newSize)`, `calculateSumAndAverage(int arr[], int size, int* sum, float* average)`, and memory management functions (`freeMemory(void* ptr)`, `checkMemoryLeaks()`) are used in the `main` function.

### Part 6: Structures and Unions

- **Task 6.1:** Create a structure to represent a student with fields for name, ID, and grades in three subjects.
- **Task 6.2:** Implement functions to input student data, calculate the average grade, and print student information.
- **Task 6.3:** Create a nested structure to represent a university with departments and students.
- **Task 6.4:** Implement a union to store different types of data (int, float, char) and demonstrate its usage.

**Usage**:
 These tasks involve working with structures and unions. The functions `createUniversity(struct University* uni)`, `printUniversityHierarchy(struct University* uni)`, file I/O functions (`writeStudentToFile(struct Student* s, const char* filename)`, `readStudentFromFile(struct Student* s, const char* filename)`), and logging functions (`logMessage(const char* message, const char* filename)`, `displayLog(const char* filename)`) are used in the `main` function.


### Part 7: File I/O

- **Task 7.1:** Create a program to write student data to a text file and read it back.
- **Task 7.2:** Modify the program to write and read student data in binary format.
- **Task 7.3:** Implement a simple log file system.


**Usage**:
 These tasks involve file input and output operations. The functions for reading from and writing to text and binary files (`writeStudentToFile(struct Student* s, const char* filename)`, `readStudentFromFile(struct Student* s, const char* filename)`, `writeStudentToBinaryFile(struct Student* s, const char* filename)`, `readStudentFromBinaryFile(struct Student* s, const char* filename)`, `logMessage(const char* message, const char* filename)`, `displayLog(const char* filename)`) are used in the `main` function.

### Final Tasks

- **Task Y:** Implement Booth's multiplication algorithm in C with unit tests.
- **Task Z:** Create a memory management maze using pointers and dynamic allocation.


## Compilation Instructions

To compile the programs, use the provided Makefile. Open your terminal or command prompt and navigate to the directory containing the Makefile and source files.

### Steps:

1. **Open Terminal/Command Prompt:**
   
   Navigate to the directory containing the Makefile and source files using the `cd` command.

2. **Compile All Parts:**
   
   To compile all parts of the project (part0, part1, maze, and boothMultiplier), simply type:
   ```markdown
   make all
    ```
3. **Compile Individual Parts:**

    Alternatively, you can compile each part individually by specifying the target:

<<<<<<< HEAD
    ```sh
=======
    ```markdown

>>>>>>> 371e5ee (Added the Reademe and gitignore file in each folder)
        make part0
        make part1
        make maze
        make boothMultiplier

    ```
## Running the Programs

    After successfully compiling, you can run each program directly from the command line:

<<<<<<< HEAD
```sh
./part0
./part1
./maze
./boothMultiplier
```
## Cleaning Up

To clean up (delete) all compiled executables, use:

```sh
make clean

```
=======
    ```markdown

        ./part0
        ./part1
        ./maze
        ./boothMultiplier
    ```
## Cleaning Up

    To clean up (delete) all compiled executables, use:

    ```markdown

        make clean
    ```
>>>>>>> 371e5ee (Added the Reademe and gitignore file in each folder)

