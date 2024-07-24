#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic
void swap(int *leftVar, int *rightVar) {
    // TODO: Implement swap function
    int temporaryVar = *leftVar;
    *leftVar = *rightVar;
    *rightVar = temporaryVar;
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    for (int i = 0; i < ( size / 2 ); i++) {
        swap(&arr[i], &arr[(size - 1 ) - i]);
    }
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
    // TODO: Print the matrix
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 100;
        }
    }  
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

void findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    int max = matrix[0][0];
    for (int i = 0; i<rows; i++){
        for (int j = 0; j<cols; j++){
            if (max < matrix[i][j]){
                max =  matrix[i][j];
            }
        }
    }
    printf("Max is: %d\n",max);
}
 
void sumOfRows(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
    int sum = 0;
    for (int i = 0; i < rows; i++){
        for (int j = 0; j < cols; j++){
            sum = sum + (*(*(matrix + i) + j));
        }
        // printing sum of rows
        printf("The sum of row %d is: %d\n", (i + 1), sum);
        // make sum to zero
        sum = 0;
    }
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    int i, j;
    for (i = 0; i < (size - 1); i++) {
        for (j = 0; j < (size - i - 1); j++) {
            if (arr[j] > arr[j + 1]) {
                swap(&arr[j], &arr[j + 1]);
            }
        }
    }   
}

void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
    for (int i = 0; i < (size - 1); i++) {
        int minIdx = i;
        for (int j = i + 1; j < size; j++) {
            if (arr[j] < arr[minIdx]) {
                minIdx = j;
            }
        }
        swap(&arr[minIdx], &arr[i]);
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

void insertAtBeginning(struct Node** head, int new_data) {
    // TODO: Implement insert at beginning
    struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));

    // 2. Put in the data
    new_node->data = new_data;
    
    // 3. Make next of new node as head
    new_node->next = (*head);
    
    // 4. Move the head to point to the new node
    (*head) = new_node;
}

void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
    struct Node* current = *head; // initializes current to the beginning of the linked list
    struct Node* previous = NULL;

    // checks if the head node itself contains the value to be deleted then update the head 
    if (current != NULL && current->data == value) {
        *head = current->next; // Change head Updates *head to point to the next node after current This effectively removes the node current from the beginning of the list.
        free(current); // Free old head
        return;
    }

    // Traversing the linked list to find the node that contains the value to be deleted
    while (current != NULL && current->data != value) {
        previous = current;
        current = current->next;
    }

    // If value was not present in the list
    if (current == NULL) return;

    // Unlink the node from the linked list
    previous->next = current->next; //updates the next pointer of the previous node to point to the node that comes after the current node,

    free(current); // Free memory
    
}

void printList(struct Node* node) {
    // TODO: Implement print list
    while (node != NULL) {
        printf("%d ", node->data);
        node = node->next;
    }
    
}

// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
    int *arr;
    arr = (int *)malloc(size * sizeof(int));
    if (arr == NULL) {
        printf("Memory allocation failed\n");
        return NULL;
    }
    return arr;
}

void extendArray(int** arr, int* size, int newSize) {
    // TODO: Extend the array using realloc()
    *arr = (int *)realloc(*arr, newSize * sizeof(int));
    if (*arr == NULL) {
        printf("Memory reallocation failed\n");
        return;
    }
    *size = newSize;
}

struct memoryTrack {
    void* address;
    int size;
    struct memoryTrack* next;
};

struct memoryTrack* head = NULL;

// Memory leak detector
void* allocateMemory(size_t size) {
    // TODO: Allocate memory and keep track of it
    void *ptr = malloc(size);
    if (ptr == NULL) {
        printf("Memory allocation failed\n");
        return NULL;
    }
    return ptr;

    // track memory 
    struct memoryTrack* newBlockMemory = (struct memoryTrack*)malloc(sizeof(struct memoryTrack));
    newBlockMemory -> address = ptr;
    newBlockMemory -> size = size;
    newBlockMemory -> next = head;
    head = newBlockMemory;




}

void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
    // if (ptr != NULL)
    //     free(ptr);
    struct memoryTrack* currentNode = head;
    struct memoryTrack* prevoiusNode = NULL;


    // search the ptr in tracked memory
    while ((currentNode != NULL) && (currentNode -> address != ptr)){
        prevoiusNode = currentNode;
        currentNode = currentNode->next;
 
    }
    // if ptr no found
    if (currentNode == NULL) {
        printf("The required pointer not Found");
        return;
    }

    // if the head node has value
    if (prevoiusNode == NULL){
        head= currentNode->next;
    }
    else{
        prevoiusNode-> next = currentNode->next;
    }
    // free pointer and block of memory
    free(ptr);
    free(currentNode);

}

void checkMemoryLeaks() {
    // TODO: Check for memory leaks
    struct memoryTrack* currentNode = head;
    int leak =0;

    while ( currentNode != NULL){
        printf("memory leak detected: address %p, size %d bytes\n", currentNode->address, currentNode->size);
        leak=1;
        currentNode = currentNode ->next;
    }
    if (!leak){
        printf("No memory leak\n");
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
    int numStudents;
    struct Student* students;
};

struct University {
    char name[100];
    int numDepartments;
    struct Department* departments;
};

union Data {
    int i;
    float f;
    char c;
};


void inputStudentData(struct Student* s) {
    // TODO: Implement this function
    printf("Enter student name: ");
    scanf("%s", s->name);
    printf("Enter student ID: ");
    scanf("%d", &s->id);
    printf("Enter grades for three subjects: ");
    for (int i = 0; i < 3; i++) {
        scanf("%f", &s->grades[i]);
    }
}

float calculateAverage(struct Student* s) {
    // TODO: Implement this function
    float sum = 0;
    for (int i = 0; i < 3; i++) {
        sum += s->grades[i];
    }
    return (sum / 3);
}

void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
    printf("Name: %s\n", s->name);
    printf("ID: %d\n", s->id);
    printf("Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
    printf("Average: %.2f\n", calculateAverage(s));
}

void printUnionData(union Data data, char type) {
    switch (type) {
        case 'i':
            printf("Integer: %d\n", data.i);
            break;
        case 'f':
            printf("Float: %.2f\n", data.f);
            break;
        case 'c':
            printf("Char: %c\n", data.c);
            break;
        default:
            printf("Unknown type\n");
    }
}
// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
    FILE* file;
    file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error opening file for writing");
    }
    fprintf(file, "Name: %s\n", s->name);
    fprintf(file, "Id: %d\n", s->id);
    fprintf(file, "Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
    
    fclose(file);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
    FILE* file;
    file = fopen(filename,"r");
    if (file == NULL) {
        printf("Error opening file for writing");
    }
    char myString[100];
    while(fgets(myString,100,file)){
        printf("%s", myString);
    };
    fclose(file);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
    FILE* file;
    file = fopen(filename, "wb"); // Open file for writing in binary mode
    if (file == NULL) {
        printf("Error opening file for writing\n");
        return;
    }

    fwrite(s, sizeof(struct Student), 1, file); // Write student data to file

    fclose(file);
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
     FILE* file;
    file = fopen(filename, "rb"); // Open file for reading in binary mode
    if (file == NULL) {
        printf("Error opening file for reading\n");
        return;
    }

    fread(s, sizeof(struct Student), 1, file); // Read student data from file
    fclose(file);
}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    FILE* file = fopen(logfile, "a"); // Open file in append mode
    if (file == NULL) {
        printf("Error opening file %s for writing\n", logfile);
        return;
    }

    // Get current time
    time_t rawtime;
    struct tm* timeinfo;
    char timestamp[20];
    
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    strftime(timestamp, sizeof(timestamp), "%Y-%m-%d %H:%M:%S", timeinfo);

    // Append timestamped message to log file
    fprintf(file, "[%s] %s\n", timestamp, message);

    fclose(file); // Close the file
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
    FILE* file = fopen(logfile, "r"); // Open file in read mode
    if (file == NULL) {
        printf("Error opening file %s for reading\n", logfile);
        return;
    }

    char line[256];
    printf("Contents of %s:\n", logfile);
    while (fgets(line, sizeof(line), file)) {
        printf("%s", line);
    }

    fclose(file); // Close the file
}


int main() {
    srand(time(NULL));

    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3
    // Task 1.1 write the program which print and update the value of variable using pointer
    int var = 10;
    int *ptr = &var;
    printf("Value of var: %d\n", var);
    printf("Value of var using pointer: %d\n", *ptr);
    *ptr = 20;
    printf("New value of var: %d\n", var);

    // Task 1.2  Implement a function that swaps two integers using pointers
    int x = 5, y = 10;
    printf("Before swap: x = %d, y = %d\n", x, y);
    swap(&x, &y);
    printf("After swap: x = %d, y = %d\n", x, y);
    
    // Task 1.3 create an array of integers print the elements of array calculate sum of elements and reverse the array
    int arr[] = {1, 2, 3, 4, 5};
    int length = sizeof(arr) / sizeof(arr[0]);
    int sum = 0;

    // Print all elements of the array using pointer arithmetic
    printf("Array elements: ");
    for (int i = 0; i < length; i++) {
        printf("%d ", *(arr + i));
    }
    printf("\n");

    //Calculate the sum of all elements
    for (int i = 0; i < length; i++){
        sum += *(arr + i);
    }
    printf("The sum of all elements is %d\n",sum);

    // Reverse the array in-place using pointer arithmetic
    reverseArray(arr, length);

    // Print the reversed array
    printf("Reversed array elements: ");
    for (int i = 0; i < length; i++) {
        printf("%d ", *(arr + i));
    }
    printf("\n");

    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2
    // Task 2.1 create a 2D array initailze, print the 2D array and find maximum in the matrix
    int matrix[3][4];
    initializeMatrix(3,4,matrix);
    printMatrix(3,4,matrix);
    findMaxInMatrix(3,4,matrix);
    // Task 2.2 claculate the sum of rows of matrix and print them
    sumOfRows(3,4,matrix);

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3
    // Task 3.1 implement the Bubble Sort and Selection Sort
    int arr1[] = {5,4,3,2,1};
    int length1 = sizeof(arr1) / sizeof(arr1[0]);
    printf("unsorted array : ");
    for (int i = 0; i< length1; i++){
        printf("%d ",arr1[i]);
    }
    bubbleSort(arr1,length1);
    printf("\nSorted array using bubble sort: ");
    for (int i = 0; i< length1; i++){
        printf("%d ",arr1[i]);
    }
    int arr2[] = {9,8,7,6,5};
    int length2 = sizeof(arr2) / sizeof(arr2[0]);
    printf("\nunsorted array : ");
    for (int i = 0; i< length2; i++){
        printf("%d ",arr2[i]);
    }
    selectionSort(arr2,length2);
    printf("\nSorted array using selection sort: ");
    for (int i = 0; i< length2; i++){
        printf("%d ",arr2[i]);
    }

    // Task 3.2 create a function pointer for the sorting algorithm and use it to sort the array
    SortFunction sortFunc = bubbleSort;
    int arr3[] = {64, 25, 12, 22, 11};  // Example array
    int length3 = sizeof(arr) / sizeof(arr[0]);
    // Print original array
    printf("\nOriginal array: ");
	// Printing elements of the array
    for (int i = 0; i < length3; i++){
        printf("%d ",arr3[i]);
    }
    sortFunc(arr3, length3);
    printf("\nArray after Bubble Sort using Function pointer: ");
    for (int i = 0; i < length3; i++){
        printf("%d ",arr3[i]);
    }
    printf("\n");

    // Task 3.3 Implement a simple calculator program that uses function pointers to perform basic arithmetic operations
    int (*addptr)(int, int) = add;
    int (*subtractptr)(int, int) = subtract;
    int (*multiplyptr)(int, int) = multiply;
    int (*divideptr)(int, int) = divide;
    int num1, num2;
    printf("Enter num1 and num2: ");
    scanf("%d %d",&num1, &num2);
    printf("The sum of %d and %d is %d.\n",num1,num2,addptr(num1,num2));
    printf("The difference of %d and %d is %d.\n",num1,num2,subtractptr(num1,num2));
    printf("The multiplication of %d and %d is %d.\n",num1,num2,multiplyptr(num1,num2));
    printf("The division of %d and %d is %d.\n",num1,num2,divideptr(num1,num2));


    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2
    // Task 4.1 Implement a simple linked list then insert a node at the beginning then delete a node by value and  Print the list
    struct Node* head  = NULL;
    insertAtBeginning(&head,2);
    insertAtBeginning(&head,4);
    insertAtBeginning(&head,6);
    insertAtBeginning(&head,8);
    insertAtBeginning(&head,10);
    // delete a node by value
    printf("Before the deletion: ");
    printList(head); // Print the list
    deleteByValue(&head,2);
    // Print the list
    printf("\nAfter the deletion. ");
    printList(head); // Print the list
    printf("\n");

    // Part 5: Dynamic Memory Allocation
    printf("\nPart 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3
    int *dynamicArray = createDynamicArray(5);
    if (dynamicArray != NULL) {
        printf("Enter 5 elements for dynamic array: ");
        for (int i = 0; i < 5; i++) {
            scanf("%d", &dynamicArray[i]);
        }
        int sum = 0;
        for (int i = 0; i < 5; i++) {
            sum += dynamicArray[i];
        }
        printf("Sum of elements: %d\n", sum);
        printf("Average of the elements: %d\n",sum/5);
        int size;
        extendArray(&dynamicArray, &size, 10);
        printf("Extended dynamic array elements: ");
        for (int i = 0; i < 10; i++) {
            printf("%d ", dynamicArray[i]);
        }
        printf("\n");
        free(dynamicArray);
    }

    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4
    // Task 6.1 // Create a structure to represent a student with fields for name, ID, and grades in three subjects
    struct Student s;

    // Task 6.2 Implement functions to Input student data Calculate the average grade and Print student information
    inputStudentData(&s);
    printStudentInfo(&s);

    // Task 6.3 Create a nested structure to represent a university with departments and students
    struct Department dep = {"EE",40,&s};
    printf("Id number of student access using student structure : %d\n",dep.students->id);   
    struct University uni = {"UET",200,&dep};
     printf("id number access using department uisng student structure : %d\n",uni.departments->students->id);
    printf("department name access using department structure : %s\n",uni.departments->name);

    // Task 6.4 Implement a union to store different types of data (int, float, char) and demonstrate its usage
    printf("\nUnion\n");
    union Data data;
    data.i = 10;
    printUnionData(data, 'i');
    data.f = 22.5;
    printUnionData(data, 'f');
    data.c = 'A';
    printUnionData(data, 'c');
    

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3
    // Task 7.1 Create a program that writes and read the student data (from Part 6) to a text file and prints it
    const char* fileName = "student.txt";
    const char* binaryFile = "student.dat";
    writeStudentToFile(&s, fileName); 
    readStudentFromFile(&s, fileName);
    printf("\n");

    // Task 7.2 write the student data into binary file
    writeStudentToBinaryFile(&s, binaryFile);
    readStudentFromBinaryFile(&s, binaryFile);

    // Task 7.3 // Create functions to log messages with timestamps allow appending to an existing log file 
    // Implement a function to read and display the log
    // Logging messages
    const char* logfile = "logfile.txt";
    logMessage("Application started", logfile);
    logMessage("User logged in", logfile);
    logMessage("Data processed", logfile);

    // Displaying log
    displayLog(logfile);

    checkMemoryLeaks();

    return 0;
}
