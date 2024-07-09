#include <stdio.h>

#include <stdlib.h>

#include <time.h>

#include <string.h>



// Part 1: Pointer Basics and Arithmetic

void swap(int *a, int *b) {

    int temp = *a;
    *a = *b;
    *b = temp;

}



void reverseArray(int *arr, int size) {
    int *start = arr;        
    int *end = arr + size - 1;

    while (start < end) {
        swap(start, end);
        start++;
        end--;
    }
}


// Part 2: Pointers and Arrays

void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    srand(time(NULL));  
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 100; 
        }
    }
    // TODO: Initialize matrix with random values
}


void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
     for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d\t", matrix[i][j]);
        }
        printf("\n");
    }
}



int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    int i,j;
    int max = matrix[0][0];
    for (i = 0; i < rows; i++){
        for (j = 0; j < cols; j++){
            if (matrix[i][j] > max) {
                max = matrix[i][j];
            }
        }
    }
    return max;
}

void sumOfRows(int rows, int cols, int (*matrix)[cols]) {
    for (int i = 0; i < rows; i++) {
        int sum = 0;
        for (int j = 0; j < cols; j++) {
            sum += matrix[i][j];
        }
        printf("Sum of row %d: %d\n", i, sum);
    }
}



// Bubble sort implementation using pointers
void bubbleSort(int *arr, int size) {
    for (int i = 0; i < (size - 1); i++) {
        for (int j = 0; j < (size - i - 1); j++) {
            if (*(arr + j) > *(arr + j + 1)) {
                int temp = *(arr + j);
                *(arr + j) = *(arr + j + 1);
                *(arr + j + 1) = temp;
            }
        }
    }
}

// Selection sort implementation using pointers
void selectionSort(int *arr, int size) {
    for (int i = 0; i < (size - 1); i++) {
        int minIndex = i;
        for (int j = (i + 1); j < size; j++) {
            if (*(arr + j) < *(arr + minIndex)) {
                minIndex = j;
            }
        }
        int temp = *(arr + minIndex);
        *(arr + minIndex) = *(arr + i);
        *(arr + i) = temp;
    }
}

// Function pointer type for sorting functions
typedef void (*SortFunction)(int*, int);


// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

// Function pointer type for calculator operations
typedef int (*CalcFunction)(int, int);

// Function to perform a calculation
void performCalculation(CalcFunction func, int a, int b) {
    int result = func(a, b);
    printf("Result: %d\n", result);
}


// Part 4: Linked List

struct Node {

    int data;

    struct Node* next;

};


void insertAtBeginning(struct Node** head, int value) {
    // Allocate memory for the new node
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    
    // Assign the data
    newNode->data = value;

    // Set the new node's next to the current head
    newNode->next = *head;

    // Update the head to the new node
    *head = newNode;
}




void deleteByValue(struct Node** head, int value) {
    // Temporary pointers for traversal
    struct Node* temp = *head;
    struct Node* prev = NULL;

    // If the head node itself holds the value
    if (temp != NULL && temp->data == value) {
        *head = temp->next; // Update head
        free(temp); // Free the old head
        return;
    }

    // Search for the node with the value
    while (temp != NULL && temp->data != value) {
        prev = temp;
        temp = temp->next;
    }

    // If the value was not present in the list
    if (temp == NULL) return;

    // Unlink the node from the list
    prev->next = temp->next;
    free(temp); // Free memory
}




void printList(struct Node* head) {
    struct Node* temp = head;

    while (temp != NULL) {
        printf("%d -> ", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}




// Part 5: Dynamic Memory Allocation



int* createDynamicArray(int size) {
    return (int*)malloc(size * sizeof(int)); // Allocate memory for 'size' integers
}


void extendArray(int** arr, int* size, int newSize) {
    int* temp = (int*)realloc(*arr, newSize * sizeof(int)); // Extend array with realloc
    if (temp == NULL) {
        printf("Memory reallocation failed!\n");
        return;
    }

    *arr = temp;
    *size = newSize;
}


// Memory leak detector
typedef struct MemoryNode {
    void* address;
    struct MemoryNode* next;
} MemoryNode;

MemoryNode* head = NULL;


void* allocateMemory(size_t size) {
    void* ptr = malloc(size);
    if (ptr == NULL) {
        printf("Memory allocation failed!\n");
        return NULL;
    }

    MemoryNode* newNode = (MemoryNode*)malloc(sizeof(MemoryNode));
    if (newNode == NULL) {
        printf("Memory node allocation failed!\n");
        free(ptr);
        return NULL;
    }
    newNode->address = ptr;
    newNode->next = head;
    head = newNode;

    return ptr;
}


void freeMemory(void* ptr) {
    MemoryNode** current = &head;
    while (*current != NULL) {
        if ((*current)->address == ptr) {
            MemoryNode* temp = *current;
            *current = (*current)->next;
            free(temp);
            break;
        }
        current = &((*current)->next);
    }
    free(ptr);
}


void checkMemoryLeaks() {
    MemoryNode* current = head;
    if (current != NULL) {
        printf("Warning: Memory leaks detected!\n");
        while (current != NULL) {
            printf("Leaked memory address: %p\n", current->address);
            MemoryNode* temp = current;
            current = current->next;
            free(temp);
        }
    } else {
        printf("No memory leaks detected.\n");
    }
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
    printf("Enter student name: ");
    scanf("%s", s->name);
    printf("Enter student ID: ");
    scanf("%d", &s->id);
    for (int i = 0; i < 3; i++) {
        printf("Enter grade for subject %d: ", i + 1);
        scanf("%f", &s->grades[i]);
    }
}



float calculateAverage(struct Student* s) {
    float sum = 0.0;
    for (int i = 0; i < 3; i++) {
        sum += s->grades[i];
    }
    return sum / 3;
}



void printStudentInfo(struct Student* s) {
    printf("\nStudent Name: %s\n", s->name);
    printf("Student ID: %d\n", s->id);
    printf("Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
    printf("Average Grade: %.2f\n", calculateAverage(s));
}


// Part 7: File I/O



void writeStudentToFile(struct Student* s, const char* filename) {
    FILE* fp = fopen(filename, "w");
    if (fp == NULL) {
        perror("Error opening file for writing");
        return;
    }

    fprintf(fp, "Name: %s\n", s->name);
    fprintf(fp, "ID: %d\n", s->id);
    fprintf(fp, "Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);

    fclose(fp);
}


void readStudentFromFile(struct Student* s, const char* filename) {
    FILE* fp = fopen(filename, "r");
    if (fp == NULL) {
        perror("Error opening file for reading");
        return;
    }

    fscanf(fp, "Name: %s\n", s->name);
    fscanf(fp, "ID: %d\n", &s->id);
    fscanf(fp, "Grades: %f, %f, %f\n", &s->grades[0], &s->grades[1], &s->grades[2]);

    fclose(fp);
}


void writeStudentToBinaryFile(struct Student* s, const char* filename) {
     FILE* fp = fopen(filename, "wb");
    if (fp == NULL) {
        perror("Error opening file for writing");
        return;
    }

    fwrite(s, sizeof(struct Student), 1, fp);

    fclose(fp);

}



void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    FILE* fp = fopen(filename, "rb");
    if (fp == NULL) {
        perror("Error opening file for reading");
        return;
    }

    fread(s, sizeof(struct Student), 1, fp);

    fclose(fp);

}



void logMessage(const char* message, const char* logfile) {
    FILE* fp = fopen(logfile, "a");
    if (fp == NULL) {
        perror("Error opening log file");
        return;
    }

    time_t now;
    struct tm* timeinfo;
    char timestamp[26];

    time(&now);
    timeinfo = localtime(&now);
    strftime(timestamp, sizeof(timestamp), "%Y-%m-%d %H:%M:%S", timeinfo);

    fprintf(fp, "[%s] %s\n", timestamp, message);

    fclose(fp);
}



void displayLog(const char* logfile) {
    FILE* fp = fopen(logfile, "r");
    if (fp == NULL) {
        perror("Error opening log file");
        return;
    }

    printf("Log file '%s' contents:\n", logfile);
    char buffer[256];
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        printf("%s", buffer);
    }

    fclose(fp);
}

void printArray(int *arr, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", *(arr + i));
    }
    printf("\n");
}

int sumArray(int *arr, int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += *(arr + i);
    }
    return sum;
}


int main() {

    srand(time(NULL));
    // Part 1: Pointer Basics and Arithmetic

    printf("Part 1: Pointer Basics and Arithmetic\n");
    
    // TODO: Implement exercises 1.1, 1.2, and 1.3

    // Task 1.1: Basic Pointer Usage

    // Step 1
    int num = 10;
    int *ptr = &num;

    // Step 2
    printf("Value of num (direct access): %d\n", num);
    printf("Value of num (via pointer): %d\n", *ptr);

    // Step 3
    *ptr = 20;
    printf("New value of num (direct access): %d\n", num);

    // Task 1.2: Swap Two Integers Using Pointers

    // Step 1
    int num1 = 5;
    int num2 = 10;

    // Print original values
    printf("Before swap: num1 = %d, num2 = %d\n", num1, num2);

    // Step 2
    swap(&num1, &num2);

    // Print swapped values
    printf("After swap: num1 = %d, num2 = %d\n", num1, num2);

    // Task 1.3: Reverse an Array

    int arr[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int size = sizeof(arr) / sizeof(arr[0]);

    printf("Original array: ");
    printArray(arr, size);


    int sum = sumArray(arr, size);
    printf("Sum of array elements: %d\n", sum);

    // Reverse the array in-place using pointers
    reverseArray(arr, size);
    printf("Reversed array: ");
    printArray(arr, size);


    // Part 2: Pointers and Arrays

    printf("\nPart 2: Pointers and Arrays\n");

    // TODO: Implement exercises 2.1 and 2.2

    int rows = 3;
    int cols = 4;
    int matrix[rows][cols];
    int max;
    // Initialize the matrix with random values
    initializeMatrix(rows, cols, matrix);

    // Print the matrix
    printf("Matrix:\n");
    printMatrix(rows, cols, matrix);
    
    // Maximum element of the array
    max = findMaxInMatrix(rows, cols, matrix);
    printf("Maximum element in the matrix is: %d\n", max);
    // Part 2.2
    // Calculate and print the sum of each row
    sumOfRows(rows, cols, matrix);



    // Part 3: Function Pointers

    printf("\nPart 3: Function Pointers\n");

    // TODO: Implement exercises 3.1, 3.2, and 3.3

    // Task 3.1: Sorting Algorithms
    int arr1[] = {5, 2, 9, 1, 5, 6};
    int size1 = sizeof(arr1) / sizeof(arr1[0]);
    printf("Original array: ");
    printArray(arr1, size1);

    // Using bubble sort
    bubbleSort(arr1, size1);
    printf("Sorted array with Bubble Sort: ");
    printArray(arr1, size1);

    int arr2[] = {3, 0, 8, 7, 5, 2};
    int size2 = sizeof(arr2) / sizeof(arr2[0]);
    printf("Original array: ");
    printArray(arr2, size2);

    // Using selection sort
    selectionSort(arr2, size2);
    printf("Sorted array with Selection Sort: ");
    printArray(arr2, size2);

    // Task 3.2: Using Function Pointer for Sorting
    int arr3[] = {10, -2, 3, 7, 9};
    int size3 = sizeof(arr3) / sizeof(arr3[0]);
    SortFunction sortFunc = bubbleSort; // Pointer to sorting function
    printf("Original array: ");
    printArray(arr3, size3);

    // Using function pointer to sort
    sortFunc(arr3, size3);
    printf("Sorted array with Function Pointer (Bubble Sort): ");
    printArray(arr3, size3);

    // Task 3.3: Calculator with Function Pointers
    int a = 10, b = 2;
    printf("Simple Calculator\n");
    printf("Addition: ");
    performCalculation(add, a, b);

    printf("Subtraction: ");
    performCalculation(subtract, a, b);

    printf("Multiplication: ");
    performCalculation(multiply, a, b);

    printf("Division: ");
    performCalculation(divide, a, b);



    // Part 4: Advanced Challenge

    printf("\nPart 4: Advanced Challenge\n");

    // TODO: Implement exercises 4.1 and 4.2

    // Initialize head to NULL
    struct Node* head = NULL;

    // Insert nodes
    insertAtBeginning(&head, 10);
    insertAtBeginning(&head, 20);
    insertAtBeginning(&head, 30);

    // Print the list
    printf("Linked List: ");
    printList(head);

    // Delete a node
    deleteByValue(&head, 20);
    
    // Print the list again
    printf("Linked List after deletion: ");
    printList(head);


    // Part 5: Dynamic Memory Allocation

    printf("Part 5: Dynamic Memory Allocation\n");

    // TODO: Implement exercises 5.1, 5.2, and 5.3

    printf("Enter the size of the array: ");
    scanf("%d", &size);

    int* array = createDynamicArray(size); // Dynamically allocate the array

    printArray(array, size);

    if (array == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    printf("Enter %d elements:\n", size);
    for (int i = 0; i < size; i++) {
        scanf("%d", &array[i]); // Input array elements
    }

    sum = 0;
    for (int i = 0; i < size; i++) {
        sum += array[i]; // Calculate sum
    }

    double average = (double)sum / size; // Calculate average

    printf("Sum: %d\n", sum);
    printf("Average: %.2f\n", average);

    // Task 5.2: Extend array using realloc
    printf("Enter the new size of the array: ");
    int newSize;
    scanf("%d", &newSize);

    extendArray(&array, &size, newSize); // Extend the array


    if (newSize > size) {
        printf("Enter %d new elements:\n", newSize - size);
        for (int i = size; i < newSize; i++) {
            scanf("%d", &array[i]);
        }
    }

    printf("Extended Array Elements:\n");
    printArray(array, newSize);
    printf("\n");

    // Memory management using custom functions
    int* dynamicArray = (int*)allocateMemory(5 * sizeof(int));

    if (dynamicArray == NULL) {
        return 1;
    }

    for (int i = 0; i < 5; i++) {
        dynamicArray[i] = i + 1;
    }

    printf("Dynamic Array elements: ");
    for (int i = 0; i < 5; i++) {
        printf("%d ", dynamicArray[i]);
    }
    printf("\n");

    freeMemory(dynamicArray); // Free the allocated dynamic array

    checkMemoryLeaks(); // Check for memory leaks

    free(array); // Free the extended array



    // Part 6: Structures and Unions

    printf("\nPart 6: Structures and Unions\n");

    // Part 6.1: Create a structure for a student
    struct Student student;

    // Part 6.2: Implement functions for student data input, average calculation, and printing info
    inputStudentData(&student);
    printStudentInfo(&student);

    // Part 6.3: Create a nested structure for university with departments and students
    struct Department department = {"Computer Science", NULL, 0};
    struct University university = {"Tech University", &department, 1};
    department.students = (struct Student*)malloc(1 * sizeof(struct Student));
    department.numStudents = 1;
    department.students[0] = student;

    printf("\nUniversity: %s\n", university.name);
    printf("Department: %s\n", department.name);
    printf("Number of Students in Department: %d\n", department.numStudents);
    for (int i = 0; i < department.numStudents; i++) {
        printStudentInfo(&department.students[i]);
    }

    // Free allocated memory
    free(department.students);

    // Part 6.4: Implement and demonstrate a union
    union Data data;

    data.i = 10;
    printf("\nUnion storing int: %d\n", data.i);

    data.f = 220.5;
    printf("Union storing float: %.2f\n", data.f);

    data.c = 'A';
    printf("Union storing char: %c\n", data.c);



    // Part 7: File I/O

    printf("\nPart 7: File I/O\n");

    const char* filename = "student_data.txt";

    // Write student data to a text file
    writeStudentToFile(&student, filename);
    printf("Student data written to file '%s'\n", filename);

    // Read student data from the text file and print it
    readStudentFromFile(&student, filename);

    printf("\nStudent data read from file:\n");
    printf("Name: %s\n", student.name);
    printf("ID: %d\n", student.id);
    printf("Grades: %.2f, %.2f, %.2f\n", student.grades[0], student.grades[1], student.grades[2]);


    const char* binaryFilename = "student_data.bin";

    // Write student data to a binary file
    writeStudentToBinaryFile(&student, binaryFilename);
    printf("Student data written to binary file '%s'\n", binaryFilename);

    // Read student data from the binary file and print it
    readStudentFromBinaryFile(&student, binaryFilename);

    printf("\nStudent data read from binary file:\n");
    printf("Name: %s\n", student.name);
    printf("ID: %d\n", student.id);
    printf("Grades: %.2f, %.2f, %.2f\n", student.grades[0], student.grades[1], student.grades[2]);


    const char* logFilename = "logfile.txt";

    // Logging messages
    logMessage("Application started", logFilename);
    logMessage("Processing data...", logFilename);
    logMessage("Data processed successfully", logFilename);

    // Displaying the log
    displayLog(logFilename);

    checkMemoryLeaks();



    return 0;

}