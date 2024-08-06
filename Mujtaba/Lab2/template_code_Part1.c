#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
    int head;
    head = *a;
    *a = *b;
    *b = head;
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
    for (int i=0; i<rows; i++){
        for (int j=0; j<cols; j++){
            matrix[i][j] = rand() % 101;
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
    printf("[");
    for (int i=0; i<rows; i++){
        printf("[");
        for (int j=0; j<cols; j++){
            if (j == cols - 1)
                printf("%d", matrix[i][j]);
            else 
                printf("%d, ", matrix[i][j]);
        }
        if (i == rows - 1)
            printf("]");
        else
            printf("], \n");
    }
    printf("]");

}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    int max = matrix[0][0];
    for (int i=0; i<rows; i++){
        for (int j=0; j<cols-1; j++){
            if (max < matrix[i][j+1]){
                max = matrix[i][j+1];
            }
        }
    }
    return max;
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    for (int i=0; i<size; i++){
        for (int j=0; j<size-1; j++){
            if (arr[j] > arr[j+1]){
                swap(&arr[j], &arr[j+1]);
            }
        }
    }
}

void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
    int minindex;
    for (int i=0; i<size-1; i++){
        minindex = i;
        for (int j=i; j<size-1; j++){
            if (arr[minindex] > arr[j+1]){
                minindex = j+1;
            }
        }
        swap(&arr[i], &arr[minindex]);
    }
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
    struct Node* newNode = (struct Node *)malloc(sizeof(struct Node));
    newNode->data = value;
    newNode->next = *head;
    *head = newNode; 
}

void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
    struct Node* delNode = *head;
    struct Node* prevNode = NULL;
    if (*head == NULL) return;
    while (1){
        if (delNode == NULL) return;
        if (delNode->data != value){
            prevNode = delNode;
            delNode = delNode->next;
        } else {
            prevNode->next = delNode->next;
            free(delNode);
            break;
        }
    }
}

void printList(struct Node* head) {
    // TODO: Implement print list
    while (head != NULL){
        printf("%d -> ", head->data);
        head = head->next;
    }
    printf("NULL\n");
}

// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
    int * arr = (int *)malloc(size*sizeof(int));
    return arr;
}

void extendArray(int** arr, int newSize) {
    // TODO: Extend the array using realloc()
    *arr = (int *)realloc(*arr, newSize*sizeof(int));
}

volatile int track_mem_blocks = 0;

// Memory leak detector
void* allocateMemory(size_t size) {
    // TODO: Allocate memory and keep track of it
    track_mem_blocks += 1;
    void *ptr = (void *)malloc(size);
    return ptr;
}

void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
    track_mem_blocks -= 1;
    free(ptr);
}

void checkMemoryLeaks() {
    // TODO: Check for memory leaks
    if (track_mem_blocks == 0){
        printf("Memory is not leaked. \n");
    } else {
        printf("You didn't free %d memory blocks.\n", track_mem_blocks);
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
    // TODO: Implement this function
    printf("Enter the name of student: ");
    scanf("%s", s->name);
    printf("Enter the id of the student: ");
    scanf("%d", &s->id);

    for (int i=0; i<3; i++){
        printf("Enter the grade of subject %d: ", i+1);
        scanf("%f", (s->grades)+i);
    }
}

float calculateAverage(struct Student* s) {
    // TODO: Implement this function
    float avg;
    for (int i=0; i<3; i++){
        avg += s->grades[i];
    }
    return (float)(avg/3);
}

void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
    printf("Name of student: ");
    printf("%s", s->name);
    printf("\n");
    printf("Id of Student: %d\n", s->id);
    for (int i=0; i<3; i++){
        printf("The grade in subject %d is: %f\n", i+1, s->grades[i]);
    }
}

// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
    FILE *ptr = fopen(filename, "w");
    fprintf(ptr, "Student Name: %s\n", s->name);
    fprintf(ptr, "Student ID: %d\n", s->id);
    fprintf(ptr, "Student grade in subject 1: %f\n", s->grades[0]);
    fprintf(ptr, "Student grade in subject 2: %f\n", s->grades[1]);
    fprintf(ptr, "Student grade in subject 3: %f\n", s->grades[2]);
    fclose(ptr);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
    char file[200];
    FILE *ptr = fopen(filename, "r");
    fscanf(ptr, "Student Name: %s\n", s->name);
    fscanf(ptr, "Student ID: %d\n", &s->id);
    fscanf(ptr, "Student grade in subject 1: %f\n", &s->grades[0]);
    fscanf(ptr, "Student grade in subject 2: %f\n", &s->grades[1]);
    fscanf(ptr, "Student grade in subject 3: %f\n", &s->grades[2]);
    fclose(ptr);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
    FILE *ptr = fopen(filename, "wb");
    fwrite(s, sizeof(struct Student), 1, ptr);
    fclose(ptr);
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
    FILE *ptr = fopen(filename, "rb");
    fread(s, sizeof(struct Student), 1, ptr);
    fclose(ptr);
}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    // current time
    time_t current_time = time(NULL);
    // format it to the local time
    struct tm *local = localtime(&current_time);
    // Buffer to hold time
    char timebuff[100];
    // Format to the timestamped log
    strftime(timebuff, 100, "%Y-%m-%d %H:%M:%S", local);
    FILE *ptr = fopen(logfile, "a");
    fprintf(ptr, "%s: %s\n", timebuff, message);
    fclose(ptr);
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
    FILE *ptr = fopen(logfile, "r");
    char readLine[200];
    while (fgets(readLine, 150, ptr)){
        printf("%s", readLine);
    }
    fclose(ptr);
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
    int rows = 4;
    int cols = 5;
    int matrix[rows][cols];
    initializeMatrix(rows, cols, matrix);
    printMatrix(rows, cols, matrix);
    printf("\n%d", findMaxInMatrix(rows, cols, matrix));

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3
    printf("Bubble Sort: \n");
    int array[] = {5,6,3,7,2,9,1,0,5};
    bubbleSort(array, 9);
    for (int i=0; i<9; i++){
        printf("%d, ", array[i]);
    }

    printf("\nSelection Sort: \n");
    int array1[] = {5,6,3,7,2,9,1,0,5};
    selectionSort(array1, 9);
    for (int i=0; i<9; i++){
        printf("%d, ", array1[i]);
    }

    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2
    struct Node * head = NULL;
    printList(head);
    insertAtBeginning(&head, 4);
    insertAtBeginning(&head, 5);
    insertAtBeginning(&head, 6);
    printList(head);
    deleteByValue(&head, 5);
    deleteByValue(&head, 4);
    printList(head);
    free(head);

    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3
    int size;
    printf("Enter the number of element of array: ");
    scanf("%d", &size);
    int *arrayD = createDynamicArray(size);
    for (int i=0; i<size; i++){
        printf("Enter %d element: ", i+1);
        scanf("%d", arrayD+i);
    }
    // Sum and Average of numbers in dynamic array are:
    float sum=0;
    for (int i=0; i<size; i++){
        sum += arrayD[i];
    }
    printf("Sum of all numbers in array is: %f\n", sum);
    printf("Average of all numbers in array is: %f\n", (float)(sum/size));
    // Extend the arrayD
    int newSize;
    printf("Enter the number of element of array: ");
    scanf("%d", &newSize);
    extendArray(&arrayD, newSize);
    for (int i=size; i<newSize; i++){
        printf("Enter %d element: ", size+1);
        scanf("%d", arrayD+i);
    }
    printf("Extended Array Elements = ");
    for (int i=0; i<newSize; i++){
        printf("%d ", arrayD[i]);
    }
    printf("\n");
    free(arrayD);
    // Memory Leak Detector
    int * allocate = (int *) allocateMemory(10*sizeof(int));
    checkMemoryLeaks();
    freeMemory(allocate);
    checkMemoryLeaks();

    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4
    struct Student s;
    float avg = calculateAverage(&s);
    inputStudentData(&s);
    // printf("The average of grades of student is: %f\n", avg);
    // printStudentInfo(&s);

    // Nested struct 
    struct Student studentList1[3] = {
        {"John Doe", 1, {85.5, 90.0, 95.0}},
        {"Jane Smith", 2, {88.0, 92.5, 89.5}},
        {"Alice Johnson", 3, {78.5, 82.0, 80.0}}
    };
    
    struct Student studentList2[3] = {
        {"Bob Brown", 4, {70.0, 75.5, 80.0}},
        {"Carol White", 5, {85.0, 87.5, 90.0}},
        {"Dave Black", 6, {92.0, 93.5, 95.0}}
    };

    struct Student studentList3[3] = {
        {"Eve Green", 7, {60.0, 65.5, 70.0}},
        {"Frank Blue", 8, {88.0, 90.5, 92.0}},
        {"Grace Red", 9, {77.0, 78.5, 80.0}}
    };

    struct Student studentList4[3] = {
        {"Hank Yellow", 10, {82.0, 83.5, 85.0}},
        {"Ivy Pink", 11, {91.0, 92.5, 94.0}},
        {"Jack Purple", 12, {79.0, 81.5, 83.0}}
    };
 
    // Create and initialize a Department instance
    struct Department departments[4] = {
        {"Computer Science",studentList1, 3},
        {"Electrical Engineering",studentList2, 3},
        {"Computer Engineering",studentList3, 3},
        {"Information Technology",studentList4, 3},
    };

    // Create and initialize a University instance
    struct University university = {
        "University of Engineering and Technology, Lahore",departments,4
    };

    printf("University: %s\n", university.name);
    for (int i = 0; i < university.numDepartments; i++) {
        printf("Department: %s\n", university.departments[i].name);
        for (int j = 0; j < university.departments[i].numStudents; j++) {
            printf("  Student Name: %s\n", university.departments[i].students[j].name);
            printf("  Student ID: %d\n", university.departments[i].students[j].id);
            printf("  Grades: %.1f, %.1f, %.1f\n",
                   university.departments[i].students[j].grades[0],
                   university.departments[i].students[j].grades[1],
                   university.departments[i].students[j].grades[2]);
        }
        printf("\n");
    }
    // Union Usage
    union Data data;
    
    data.i = 10;
    printf("data.i: %d\n", data.i);
    
    data.f = 220.5;
    printf("data.f: %.1f\n", data.f);
    
    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3
    writeStudentToFile(&s, "student.txt");
    struct Student s1;
    readStudentFromFile(&s1, "student.txt");
    // Print to the terminal
    printf("Student Name: %s\n", s1.name);
    printf("Student ID: %d\n", s1.id);
    printf("Student grade in subject 1: %f\n", s1.grades[0]);
    printf("Student grade in subject 2: %f\n", s1.grades[1]);
    printf("Student grade in subject 3: %f\n", s1.grades[2]);

    // Binary write
    writeStudentToBinaryFile(&s, "student.bin");
    // Binary read
    struct Student s2;
    readStudentFromBinaryFile(&s2, "student.bin");
    printf("Student Name: %s\n", s2.name);
    printf("Student ID: %d\n", s2.id);
    printf("Student grade in subject 1: %f\n", s2.grades[0]);
    printf("Student grade in subject 2: %f\n", s2.grades[1]);
    printf("Student grade in subject 3: %f\n", s2.grades[2]);

    // Log File write
    logMessage("GitHub requires Authentication for remote access.", "logfile.log");
    // Log File read
    displayLog("logfile.log");
    return 0;
}
