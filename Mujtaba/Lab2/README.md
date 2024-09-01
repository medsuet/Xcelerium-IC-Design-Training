# C Programming Exercises Part 2

This folder contains a set of shell script exercises aimed at mastering the advanced concepts.

## Part 1: Pointer Basics and Arithmetic

- **Function:** `swap(int *a, int *b)`
- **Description:** Function to swap the variables content using pointers.

- **Functions:** `reverseArray(int *arr, int size)`
- **Description:** Reverse the content of the array having particular size.

## Part 2: Pointers and Arrays

- **Function:** `initializeMatrix(int rows, int cols, int (*matrix)[cols])`
- **Description:** Initialize the 2-D Matrix with random values having particular rows and columns.

- **Function:** `printMatrix(int rows, int cols, int (*matrix)[cols])`
- **Description:** Visualize the 2-D Matrix.

- **Function:** `findMaxInMatrix(int rows, int cols, int (*matrix)[cols])`
- **Description:** Function to find the maximum element in the 2-D matrix.

## Part 3: Functions Pointers

- **Function:** `bubbleSort(int *arr, int size)`
- **Description:** Sort the elements of array using the Bubble Sort Algorithm.

- **Function:** `selectionSort(int *arr, int size)`
- **Description:** Sort the elements of array using the Selection Sort Algorithm.

## Part 4: Linked Lists

- **Function:** `insertAtBeginning(struct Node** head, int value)`
- **Description:** Insert the `Node` at the beginning of the Linked List having particular `value`.

- **Function:** `deleteByValue(struct Node** head, int value)`
- **Description:** Deletes the `Node` by `value` and if `value` is not present then simply return through the function.

- **Function:** `printList(struct Node* head)`
- **Description:** Visualize the Linked Lists by print in a particular pattern.

## Part 5: Dynamic Memory Allocation

- **Function:** `createDynamicArray(int size)`
- **Description:** Reserves space by creating the array of `size` at runtime and simply return the pointer that points to that particular chunk of memory.

- **Function:** `extendArray(int** arr, int newSize)`
- **Description:** Extend the dynamically allocated memory using `reallco()`.

- **Function:** `allocateMemory(size_t size)`
- **Description:** Allocate Memory of any type.

- **Function:** `freeMemory(void* ptr)`
- **Description:** Free the memory if not needed anymore.

- **Function:** `checkMemoryLeaks()`
- **Description:** Check the allocated memory is free or not.

## Part 6: Structures and Unions

- **Function:** `inputStudentData(struct Student* s)`
- **Description:** Take the Student Data of type `struct Student`.

- **Function:** `calculateAverage(struct Student* s)`
- **Description:** Calculate the average of grades of individual student.

- **Function:** `printStudentInfo(struct Student* s)`
- **Description:** Visualize the information that you given.

## Part 7: File I/O

- **Function:** `writeStudentToFile(struct Student* s, const char* filename)`
- **Description:** Open the file in `w` mode and then add the info of the student that user just entered.

- **Function:** `readStudentFromFile(struct Student* s, const char* filename)`
- **Description:** Read that previous wrote file or any other file.

- **Function:** `writeStudentToBinaryFile(struct Student* s, const char* filename)`
- **Description:** Write the information of the student in binary format.

- **Function:** `readStudentFromBinaryFile(struct Student* s, const char* filename)`
- **Description:** Read the information of the student in binary format.

- **Function:** `logMessage(const char* message, const char* logfile)`
- **Description:** Adding the log message with time stamped.

- **Function:** `displayLog(const char* logfile)`
- **Description:** Display or Read the file that have logs.

## Task Y: Booth's Multiplier
Implemented the Booth's Multiplier in C by using arrays as a register to store content.

- **Function:** `BoothMultiplier(int multiplicand, int multiplier)`
- **Description:** Implemented the main logic or algorithm.

- **Function:** `intToBinary(int n, int res[], int sc)`
- **Description:** Convert the integer to binary.

- **Function:** `printBinary(int sc, int bin[])`
- **Description:** Visualize the binary format.

- **Function:** `ShiftRight(int sc, int bin[])`
- **Description:** Logical Shift Right Function Implementation.

- **Function:** `addBinary(int A[], int B[], int res[], int size)`
- **Description:** Function added two binary numbers and store the result in separate register.

- **Function:** `TwosComplement(int A[], int res[], int size)`
- **Description:** Implementing Two's Complement Format and store the result in separate register.

- **Function:** `BinToInt(int bin[], int size)`
- **Description:** Covert the Binary Number into Integer Format.
## Task Z: Memory Maze Management

- **Function:** `CreateDynamicArray2D(int maze_size)`
- **Description:** Allocate Memory on run time for maze.

- **Function:** `initializeDArray(int** DArray, int maze_size)`
- **Description:** Initialize the memory with `0 (path)` and `1 (wall)`.

- **Function:** `freeMemory(int** DArray, int maze_size)`
- **Description:** When the game ends, the allocated memory is freed by the freeMemory routine.

- **Function:** `printArray2D(int **DArray, int maze_size)`
- **Description:** Visualize the Maze.

- **Function:** `navigateMaze(int *current_position, int **DArray, int maze_size)`
- **Description:** Performs the main logic by exploring the adjacent positions and call function recursively if position is valid.

# Run the script 
- **To make all the builds:** `make`
- **To run the `template_code_Part1.c` file:** `make run`
- **To run the `Booth_Multiplier.c` file:** `make BoothMul`
- **To run the `memory_maze.c` file:** `make maze`
- **To clean all the builds:** `make clean`
