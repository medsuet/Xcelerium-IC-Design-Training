#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp;
    temp = *a;
    *a = *b;
    *b = temp;
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    for (int i=0; i<size/2; i++){
        swap(&arr[i], &arr[size-i-1]);
    }
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
}

void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
}

typedef void (*SortFunction)(int*, int);

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

// Part 4: Linked List
struct Node {
    int data;
    struct Node* next;
};

void insertAtBeginning(struct Node** head, int value) {
    // TODO: Implement insert at beginning
}

void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
}

void printList(struct Node* head) {
    // TODO: Implement print list
}

// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
}

void extendArray(int** arr, int* size, int newSize) {
    // TODO: Extend the array using realloc()
}

// Memory leak detector
void* allocateMemory(size_t size) {
    // TODO: Allocate memory and keep track of it
}

void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
}

void checkMemoryLeaks() {
    // TODO: Check for memory leaks
}

// Part 6: Structures and Unions

struct Student {
    char name[50];
    int id;
    float grades[3];
};

struct Department {
    char name[50];
    struct Student* students;
    int numStudents;
};

struct University {
    char name[100];
    struct Department* departments;
    int numDepartments;
};

union Data {
    int i;
    float f;
    char c;
};


void inputStudentData(struct Student* s) {
    // TODO: Implement this function
}

float calculateAverage(struct Student* s) {
    // TODO: Implement this function
}

void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
}

// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
}

void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
}


int main() {
    srand(time(NULL));

    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3
    int a = 5, b = 10;
    printf("Before swap: a = %d, b = %d\n", a, b);
    swap(&a, &b); // Pass addresses of a and 
    printf("After swap: a = %d, b = %d\n", a, b);

    printf("Before Reverse Array: ");
    int arr[] = {1,2,3,4,5,6,7,8,9};
    for (int i=0; i<9; i++){
        printf("%d, ", arr[i]);
    }
    printf("\n");
    reverseArray(arr,9);
    printf("After Reverse Array: ");
    for (int i=0; i<9; i++){
        printf("%d, ", arr[i]);
    }
    printf("\n");

    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3

    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2

    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3

    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3

    checkMemoryLeaks();

    return 0;
}
