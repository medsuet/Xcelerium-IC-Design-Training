## Module 2: Advanced C Language

### Contents

**Part 1: Pointer Basics and Arithmetic**

**Task 1.1:** Create a program that demonstrates basic pointer usage:
**Task 1.2:** Implement a function that swaps two integers using pointers
**Task 1.3:** Create an array of integers and use pointer arithmetic to
- Print all elements of the array
- Calculate the sum of all elements
- Reverse the array in-place

**Part 2: Pointers and Arrays**

**Task 2.1:** Initialize a 2D Array and find maximum element from it
**Task 2.2:** Implement a function that takes a 2D array as a parameter and calculates the sum of each row

**Part 3: Function Pointers**
**Task 3.1:** Create an array of integers and implement the following sorting algorithms:
- Bubble sort
- Selection sort
**Task 3.2:** Create a function pointer for the sorting algorithm and use it to sort the array
**Task 3.3:** Implement a simple calculator program that uses function pointers to perform simple arithmetic calculations.

**Part 4: Advanced Challenge**

**Task 4.1:** Implement a simple linked list with the following operations:
• Insert a node at the beginning
• Delete a node by value
• Print the list
**Task 4.2:** Use function pointers to create a generic linked list that can store different data types.


**Part 5: Dynamic Memory Allocation**

**Task 5.1:** Create a program that dynamically allocates and initializes the array through user inputs.
**Task 5.2:** Implement a function that uses realloc() to extend an existing dynamically allocated array
**Task 5.3:** Create a simple memory leak detector.

**Part 6: Structures and Unions**

**Task 6.1:** Create a structure to represent a student with fields for name, ID, and grades in three subjects
**Task 6.2:** Create a function to initialize and print student data aswell as calculate the average grades.
**Task 6.3:** Create a nested structure to represent a university with departments and students
**Task 6.4:** Implement a union to store different types of data (int, float, char) and demonstrate its usage

**Part 7: File I/O**
**Task 7.1:** Create a program that write student's data into a file and reads it.
**Task 7.2:** Modify the program to write and read the student data in binary format
**Task 7.3:** Implement a simple log file system:
- Create functions to log messages with timestamps
- Allow appending to an existing log file
- Implement a function to read and display the log

**Task Y: Implement Booth Multiplier**

**Task Z: Implement Memory Management Maze Game**
---
### Executing Scripts

To execute **Task 1 to Task 7**, simply open the *module2* folder and run the following command on terminal:
`make module2`
If the terminal says that it is *up to date*, run the following command first and rerun the previous command again.
`make clean`

To execute the **Task Y: Implementation of Booth Multiplier**, simple run the following command on terminal:
`make booth`
If the terminal says that it is *up to date*, run the following command first and rerun the previous command again.
`make clean`

To execute the **Task Z: Implementation of Memory Management Maze Game**, simple run the following command on terminal:
`make maze`
If the terminal says that it is *up to date*, run the following command first and rerun the previous command again.
`make clean`

After running the code, make sure to delete your executable files using:
`make clean`