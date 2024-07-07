#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic
void swap(int *firstNumber, int *secondNumber) {
    // TODO: Implement swap function
    // Swapping values of *a and *b using a temporary variable
    int temporaryVariable = *firstNumber;
    *firstNumber = *secondNumber;
    *secondNumber = temporaryVariable;
}

// function for printing all elements of array
void printArr(int *arr, int size){
  printf("The array elements are:\n");
    for (int i = 0; i < size; i++){
        printf("%d\n", *(arr + i));
    }

}
// calculating sum of array elements
void sum(int *arr, int size){
  int sumArr = 0;
    for (int i = 0; i < size; i++){
      sumArr = sumArr + *(arr+i);
    }
    printf("The sum of all elements of array is %d\n", sumArr);
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    // variable for accesing last element of array
    int a;
    a = size - 1;
    int reversedArr[5];
    for (int i = 0; i < size; i++){
        *(reversedArr + i) = *(arr + a);
        a = a - 1;
    }
    // printing the reversed array
    printf("The revered array is:\n");
    for (int i = 0; i < size; i++){
        printf("%d\n", *(reversedArr + i));
    }
}

// Part 2: Pointers and Arrays

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
    int value = 1;
    for (int i = 0; i < rows; i++){
        for (int j = 0; j < cols; j++){
            *(*(matrix + i) + j) = value;
	    value++;
        } 
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
  printf("The 2D Matrix is:\n");
    for (int i = 0; i < rows; i++){
        for (int j = 0; j < cols; j++){
	  printf("%d ", *(*(matrix + i) + j));
        }
        printf("\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    // let suppose first element is maximum
    int max = *(*(matrix));
    for (int i = 0; i < rows; i++){
        for (int j = 0; j < cols; j++){
            if ( (*(*(matrix + i) + j)) > max ){
	      max = *(*(matrix + i) + j);
            }
        } 
    }
    return max;
}

void sumRows(int rows, int cols, int (*matrix)[cols]) {
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
  for(int j =0; j< size; j++){
        int swap = 0;
        
        for (int i = 0; i < size-1; i++){
            int leftElement = *(arr + i);
            int rightElement = *(arr + (i + 1));
            if(leftElement > rightElement ){
                int temporaryVariable;
                temporaryVariable = rightElement;
                *(arr + i + 1) = leftElement;
                *(arr + i) = temporaryVariable;
                swap = 1;
            }

        }
        if (!swap){
            break;
        }
    }
}

void selectionSort(int *array, int size){
   int i, j, imin;
   for(i = 0; i<size-1; i++) {
      imin = i; //get index of minimum data
      for(j = i+1; j<size; j++)
         if(*(array+j) < *(array+imin))
            imin = j;
      
      //placing in correct position
      int temp;
      temp = *(array+i);
      *(array+i) = *(array+imin);
      *(array+imin) = temp;
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


// Function to insert a new node at the beginning of the list
void insertAtBeginning(struct Node** head, int value) {
    // TODO: Implement insert at beginning
    // Allocate memory for the new node
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    
    // Assign the value to the new node
    newNode->data = value;
    
    // Make the new node point to the current head
    newNode->next = *head;
    
    // Update the head to point to the new node
    *head = newNode;
}

// Function to delete a node by its value
void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
    // Store the head node
    struct Node* currentNode = *head;
    struct Node* previousNode = NULL;

    // If the head node itself holds the value to be deleted
    if (currentNode != NULL && currentNode->data == value) {
        *head = currentNode->next; // Change head
        free(currentNode); // Free old head
        return;
    }

    // Search for the value to be deleted, keep track of the previous node
    // as we need to change 'prev->next'
    while (currentNode != NULL && currentNode->data != value) {
        previousNode = currentNode;
        currentNode = currentNode->next;
    }

    // If the value was not present in the list
    if (currentNode == NULL) return;

    // Unlink the node from the linked list
    previousNode->next = currentNode->next;

    // Free memory
    free(currentNode);
}

// Function to print the linked list
void printList(struct Node* head) {
    // TODO: Implement print list
    struct Node* current = head;

    while (current != NULL) {
        printf("%d -> ", current->data);
        current = current->next;
    }
    printf("NULL\n");
}


// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
    // using malloc to create Dynamic memory array
    int *ptr = (int *)malloc(size * sizeof(int));
    if (ptr == NULL){
        printf("Malloc failed");
        exit(1);
    }
    return ptr;
}

void extendArray(int** arr, int* size, int newSize) {
    // TODO: Extend the array using realloc()
    int *newArray= (int *)realloc(*arr, (newSize * sizeof(int)));
    if (newArray == NULL){
        printf("realloc failed");
        exit(1);
    }
    // declaring previous array with extended array
    *arr = newArray;
    // declaring size to newsize
    *size = newSize;
}

// Memory leak detector

// Struct to track allocated memory blocks
struct MemoryBlock {
    void* address; // Pointer to the allocated memory block - pointer to any data type 
    size_t size; // Size of the memory block
    struct MemoryBlock* next; // Pointer to the next memory block in the list
};

// Head of the linked list to keep track of memory blocks
struct MemoryBlock* head = NULL;

// Function to allocate memory and track it
void* allocateMemory(size_t size) {
    // TODO: Allocate memory and keep track of it
    // Allocate memory of given size
    void* ptr = malloc(size);
    // Check if the allocation was successful
    if (ptr == NULL) {
        printf("Malloc failed\n");
        exit(1);
    }

    // Allocate memory for a new memory block to track the allocation
    struct MemoryBlock* newBlock = (struct MemoryBlock*)malloc(sizeof(struct MemoryBlock));
    // Set the fields of the new memory block
    // store allocated memory address 
    newBlock->address = ptr;
    // store size of allocated memory size in bytes
    newBlock->size = size;
    // updated the pointer to next node
    newBlock->next = head;
    // Update the head of the linked list
    head = newBlock;

    return ptr;
}

// Function to free memory and update tracking
void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
    struct MemoryBlock* currentNode = head;
    struct MemoryBlock* previousNode = NULL;

    // Traverse the list to find the memory block to be freed
    // traverse until pointer to free not found or end of linked list
    while (currentNode != NULL && currentNode->address != ptr) {
        previousNode = currentNode;
        currentNode = currentNode->next;
    }

    // If the pointer was not found in the list, print a message and return
    if (currentNode == NULL) {
        printf("Pointer not found in allocated list\n");
        return;
    }

    // Unlink the memory block from the list
    // if 1st node has that pointer
    if (previousNode == NULL) {
        // update head
        head = currentNode->next;
    } 
    else {
        previousNode->next = currentNode->next;
    }

    // Free the memory block and the pointer
    free(currentNode);
    free(ptr);
}

// Function to check for memory leaks
void checkMemoryLeaks() {
    // TODO: Check for memory leaks
    struct MemoryBlock* currentNode = head;
    int leaks = 0;

    // Traverse the list to find any memory blocks that have not been freed
    while (currentNode != NULL) {
        printf("Memory leak detected: Address %p, Size %zu bytes\n", currentNode->address, currentNode->size);
        leaks = leaks + 1;
        currentNode = currentNode->next;
    }

    // Print a message if no memory leaks were found
    if (!leaks) {
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

// Function to initialize a student

void inputStudentData(struct Student* s) {
    // TODO: Implement this function
    printf("Enter your Name:\n");
    // No need for '&' when scanning a string into an array
    scanf("%s", s->name);
    printf("Enter your ID:\n");
    scanf("%d", &(s->id));
    printf("Enter your Grades:\n"); 
    for (int i = 0; i < 3; i++){
        scanf("%f", &(s->grades[i]));
    }
    printf("\n");
}

// Function to initialize a department
void initializeDepartment(struct Department* department, const char* name, struct Student* students, int numStudents) {
    strcpy(department->name, name);
    department->students = students;
    department->numStudents = numStudents;
}

// Function to initialize a university
void initializeUniversity(struct University* university, const char* name, struct Department* departments, int numDepartments) {
    strcpy(university->name, name);
    university->departments = departments;
    university->numDepartments = numDepartments;
}


float calculateAverage(struct Student* s) {
    // TODO: Implement this function
    float average;
    float sum = 0;
    for (int i = 0; i < 3;i++){
        sum = sum + (s->grades[i]);
    }
    average = sum / 3;
    return average;
}

void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
    printf("Student Name: %s\n", s->name);
    printf("Student ID: %d\n", s->id);
    printf("Student Grades:");
    for (int i = 0; i < 3;i++){
        printf(" %f ",s->grades[i]);
    }

}

// Function to print department information
void printDepartmentInfo(struct Department* department) {
    printf("Department Name: %s\n", department->name);
    printf("Number of Students: %d\n", department->numStudents);
    for (int i = 0; i < department->numStudents; i++) {
        printf("Student Information\n");
        printStudentInfo(&(department->students[i]));
    }
}

// Function to print university information
void printUniversityInfo(struct University* university) {
    printf("University Name: %s\n", university->name);
    printf("Number of Departments: %d\n", university->numDepartments);
    for (int i = 0; i < university->numDepartments; i++) {
        printf("Student Information\n");
        printDepartmentInfo(&(university->departments[i]));
    }
}

// 
void printUnionData(union Data* data, char type) {
    switch (type) {
        case 'i':
            printf("Integer: %d\n", data->i);
            break;
        case 'f':
            printf("Float: %.2f\n", data->f);
            break;
        case 'c':
            printf("Character: %c\n", data->c);
            break;
        default:
            printf("Unknown type\n");
    }
}

// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
    FILE *file = fopen(filename, "w");
    if(file == NULL){
        printf("File not opened");
        exit(1);
    }
    else {
        fprintf(file, "Student Name: %s\n", s->name);
        fprintf(file, "Student ID: %d\n", s->id);
        for (int i = 0; i < 3; i++) {
            fprintf(file, "Grade %d: %.2f\n", i + 1, s->grades[i]);
        }
    }
    fclose(file);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
    FILE *file = fopen(filename, "r");
    char chracter;
    if(file == NULL){
        printf("File not opened");
        exit(1);
    }
    else {
        while(1){
            chracter = fgetc(file);
            if (chracter == EOF){
                break;
            }
            printf("%c", chracter);
        }
        printf("\n");

    }
    fclose(file);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
    FILE *file = fopen(filename, "wb");
    if (file == NULL) {
        printf("File could not be opened for writing\n");
        exit(1);
    } else {
        size_t written = fwrite(s, sizeof(struct Student), 1, file);
        if (written != 1) {
            printf("Error writing to file\n");
        } else {
            printf("Student data written successfully\n");
            printf("write Data: %zu bytes\n", written);
        }
        fclose(file);
    }
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
    FILE *file = fopen(filename, "rb");
    if (file == NULL) {
        printf("File could not be opened for reading\n");
        exit(1);
    } else {
        size_t read = fread(s, sizeof(struct Student), 1, file);
        if (read != 1)
        {
            printf("Error reading from file\n");
            
        }
        else
        {
            printf("Student data read successfully\n");
            printf("Read Data: %zu bytes\n", read);
        }
        fclose(file);
    }
}

// Function to get current timestamp as a string
void getTimestamp(char* buffer, size_t bufferSize) {
    time_t now = time(NULL);
    struct tm* localTime = localtime(&now);
    strftime(buffer, bufferSize, "%Y-%m-%d %H:%M:%S", localTime);
}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    FILE *file = fopen(logfile, "a");
    if (file == NULL) {
        printf("Log file could not be opened\n");
        exit(1);
    } else {
        char timestamp[20];
        getTimestamp(timestamp, sizeof(timestamp));
        fprintf(file, "[%s] %s\n", timestamp, message);
        fclose(file);
    }
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
    FILE *file = fopen(logfile, "r");
    if (file == NULL) {
        printf("Log file could not be opened\n");
        exit(1);
    } else {
        char line[256];
        while (fgets(line, sizeof(line), file)) {
            printf("%s", line);
        }
        fclose(file);
    }
}


int main() {
    srand(time(NULL));

    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3
    printf("Part 1 task 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3
    // declaring variable and a pointer that points to it
    int a = 10;
    int *ptr = &a;
    // printing a on terminal
    printf("The value of a is: %d\n", a);
    printf("The value of a accesed by pointer is: %d\n", *ptr);
    // changing value of a using pointer
    *ptr = 20;
    printf("The changed value of a using pointer is: %d\n", a);

    // Declare two integers and initialize them with random values
    int integer1 = rand() % 100;  // Random value between 0 and 99
    int integer2 = rand() % 100;  // Random value between 0 and 99

    // Print unswapped values
    printf("The unswapped value of integer1 is: %d\n", integer1);
    printf("The unswapped value of integer2 is: %d\n", integer2);

    // Call swap function
    swap(&integer1, &integer2);

    // Print swapped values
    printf("The swapped value of integer1 is: %d\n", integer1);
    printf("The swapped value of integer2 is: %d\n", integer2);
    
    // initialize array
    int arr[5] = {1, 2, 3, 4, 5};
    int sizeArray;
    sizeArray = sizeof(arr)/sizeof(arr[0]);
    // print array
    printArr(arr, sizeArray);
    // calculate sum of array
    sum(arr,sizeArray);
    // reversing array and printing reversed array
    reverseArray(arr, sizeArray);


    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2
    // part 2.1
    int matrixA[3][4];
    initializeMatrix(3, 4, matrixA);
    printMatrix(3, 4, matrixA);
    int maxNum = findMaxInMatrix(3, 4, matrixA);
    printf("The maximum number is: %d", maxNum);
    // part 2.2
    // calculating sum of rows of matrix
    sumRows(3,4,matrixA);

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3

    // 3.1 
    // size of array
    int n;
    n = 5;
    int array[5] = {15, 33, 49, 10, 20}; //initialize an array 
    printf("Array before Sorting: ");
    // printing array
    for(int i = 0; i<n; i++) {
        printf("%d ",array[i]);
    }
    printf("\n");
    bubbleSort(array, n);
    printf("Array after Sorting by Bubble Sort Algorithm: ");
    // printing array
    for(int i = 0; i<n; i++){
        printf("%d ", array[i]);
    }
    printf("\n");

    int array2[5] = {12, 19, 55, 2, 16}; // initialize the array
    printf("Array before Sorting: ");
    // printing array
    for(int i = 0; i<n; i++)
        printf("%d ",array2[i]);
    printf("\n");
    selectionSort(array2, n);
    printf("Array after Sorting by Selection Sort Algorithm: ");
    // printing array
    for(int i = 0; i<n; i++)
        printf("%d ", array2[i]);
    printf("\n");

    // 3.2
    // Declaring Pointers Functions
    // Pointer function for BubbleSort
    void (*bubbleSortPtr)(int *, int) = &bubbleSort;
    // pointer function for selectionSort
    void (*selectionSortPtr)(int *, int) = &selectionSort;

    // 3.3
    // Array of function pointers initialization
    // int (*p[4])(int, int) = {sum, subtract, mul, div};
    // function pointers initialization
    int (*addPtr)(int, int) = add;
    int (*subtractPtr)(int, int) = subtract;
    int (*multiplyPtr)(int, int) = multiply;
    int (*dividePtr)(int, int) = divide;

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3
    int number1 = 2;
    int number2 = 3;
    // Pointer Functions calling
    printf("The addition of number1 and number2 is: %d\n", addPtr(number1,number2));
    printf("The subtraction of number1 and number2 is: %d\n", subtractPtr(number1,number2));
    printf("The multiplication of number1 and number2 is: %d\n", multiplyPtr(number1,number2));
    printf("The division of num1 and number2 is: %d\n", dividePtr(number1,number2));

    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2

    struct Node* head = NULL; // Initialize an empty list

    // Insert elements at the beginning
    insertAtBeginning(&head, 10);
    insertAtBeginning(&head, 20);
    insertAtBeginning(&head, 30);

    // Print the list
    printf("Linked list after inserting 30, 20, 10 at the beginning:\n");
    printList(head);

    // Delete an element by value
    deleteByValue(&head, 20);
    printf("Linked list after deleting value 20:\n");
    printList(head);

    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3

    // 5.1

    int size;
    printf("Enter size of Array: ");
    scanf("%d", &size);
    // calling function for creating dynamic memory array
    int *array1;
    array1 = createDynamicArray(size);
    // creating variable for taking user inputs of elements of array
    int arr_element;
    // for loop for getting elements of array from user
    for (int i = 0; i < size;i++){
        scanf("%d", &arr_element);
        *(array1 + i) = arr_element;
        }
    // printing array
    printf("Enter %d Elements of Array\n", size);
    for (int i = 0; i < size; i++){
            printf("%d ", array1[i]);
        }
    printf("\n");
    // free(array1);

    // 5.2 
    int newSize;
    printf("Enter New size of Array: ");
    scanf("%d", &newSize);
    extendArray(&array1, &size, newSize);
    

    // creating variable for taking user inputs of elements of array
    // int arr_element;
    // for loop for getting elements of array from user
    printf("Enter %d Elements of Array\n", size);
    for (int i = 0; i < size;i++){
        scanf("%d", &arr_element);
        *(array1 + i) = arr_element;
        }
    // printing array
   
    for (int i = 0; i < size; i++){
            printf("%d ", array1[i]);
        }
    printf("\n");

    // free dynamic array
    free(array1);

    // 5.3

    // Allocate and free memory with tracking
    int* trackedArray = (int*)allocateMemory(5 * sizeof(int));
    freeMemory(trackedArray);


    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4
    struct Student student1;
    printf("Input Student Data\n");
    inputStudentData(&student1);
    printf("Calculate Average\n");
    float averageGrade;
    averageGrade = calculateAverage(&student1);
    printf("The Average Grade is: %f\n", averageGrade);
    printf("Students Details\n");
    printStudentInfo(&student1);

    // Initialize a department
    struct Department departments[1];
    initializeDepartment(&departments[0], "Computer Science", &student1, 2);

    // Initialize a university
    struct University university;
    initializeUniversity(&university, "Tech University", departments, 1);

    // Print university information
    printf("University information\n");
    printUniversityInfo(&university);

    // Print Department information
    printf("Department information\n");
    printDepartmentInfo(departments);

    union Data data;

    // Store an integer in the union
    data.i = 42;
    printf("After storing an integer:\n");
    printUnionData(&data, 'i');

    // Store a float in the union
    data.f = 3.14;
    printf("After storing a float:\n");
    printUnionData(&data, 'f');

    // Store a character in the union
    data.c = 'A';
    printf("After storing a character:\n");
    printUnionData(&data, 'c');

    // Demonstrate the overlapping storage
    printf("\nDemonstrating overlapping storage:\n");
    data.i = 97; // ASCII value for 'a'
    printf("As integer: %d\n", data.i);
    printf("As float: %.2f\n", data.f);
    printf("As character: %c\n", data.c);


    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3
    const char* filename = "student.txt";
    writeStudentToFile(&student1, filename);

    // read data
    readStudentFromFile(&student1, filename);

    const char* filename1 = "student1.dat"; // Use .dat extension for binary files
    writeStudentToBinaryFile(&student1, filename1);

    // Read and print data
    struct Student student2;
    readStudentFromBinaryFile(&student2, filename1);
    printf("Read Student Data from Binary File\n");

    // Example log file name
    const char* logfile = "logfile.txt";
    
    // Logging some messages
    logMessage("This is the first log message.", logfile);
    logMessage("This is the second log message.", logfile);
    logMessage("This is the third log message.", logfile);

    // Display the log file
    printf("Displaying log file contents:\n");
    displayLog(logfile);
    
    // Check for memory leaks
    checkMemoryLeaks();

    return 0;
}
