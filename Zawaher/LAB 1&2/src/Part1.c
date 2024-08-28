#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>


// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    int temp;
    printf("The value of first input is: %d\n", *a);
    printf("The value of second input is: %d\n", *b);
    temp = *a;
    *a = *b;
    *b = temp;
    printf("The swapped value of first input is: %d\n", *a);
    printf("The swapped value of second input is: %d\n", *b);
}

void reverseArray(int *arr, int size) {
    int *start = arr; // Start pointer is assigned to the first element address of the array
    int *end = arr + size - 1; // End pointer is assigned to the last element address of the array
    int temp;
    while (end > start) {
        // Assigning the temp variable the value of the start
        temp = *start;
        *start = *end;
        *end = temp;
        start++;
        end--;
    }
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    for (int i = 0 ; i < rows ; i++){
        for (int y = 0 ; y < cols ; y++){
            *(*(matrix + i) + y) = rand() % 100;
        }
    }

}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    
    for (int i = 0 ; i < rows ; i++){
        for (int y = 0 ; y < cols ; y++){
            printf("%d ",*(*(matrix + i) + y));

        }
        printf("\n");
    }


}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    
    int max_number = *(*(matrix + 0) + 0) ;
    
    for (int i = 0 ; i < rows ; i++){
        for (int j = 0 ; j < cols ; j++){
            if ( (*(*(matrix + i ) + j)) > max_number){
                max_number = (*(*(matrix + i ) + j));
            }
        }
    }
    return max_number;
}

void sumOfMatrixRow(int rows , int cols , int (*matrix)[cols]){
    int  sum = 0;
    for (int i = 0 ; i < rows ; i++){
        for (int j = 0 ; j < cols ; j++){
            sum +=  *(*(matrix + i) + j);
        }
    printf("The sum of %d row is : %d\n", i , sum);
    sum = 0;    
    }
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    //In Bubble Sort algorithm, 

    //traverse from left and compare adjacent elements and the higher one is placed at right side. 
    //In this way, the largest element is moved to the rightmost end at first. 
    //This process is then continued to find the second largest and place it and so on until the data is sorted.

    for (int i = 0 ; i < (size -1) ; i++ ){ 
        for (int j = 0 ; j < (size-i-1) ; j++ ){
            if (*(arr + j) > *(arr + j+1 )){
                swap((arr+j),(arr+j+1)); //calling the swap function to  swap two if first element is greater than secod element
            }
        }
    }
    //Printing the sorted array 
    printf("The sorted array by  Bubble sort is given below\n");
    for (int x = 0 ; x < size ; x++ ){
        printf("%d ",*(arr + x));
    }
    printf("\n");
}
void selectionSort(int *arr, int size) {
    // Selection sort is a simple and efficient sorting algorithm that works by repeatedly selecting the smallest (or largest)
    // element from the unsorted portion of the list and moving it to the sorted portion of the list. 

    
    for (int i = 0; i < (size - 1); i++) {
        int *min = arr + i; // Initialize min to the first element of the unsorted part
        for (int j = (i + 1); j < size; j++) {
            if (*(arr + j) < *min) { // Find the minimum element in the unsorted part
                min = arr + j;
            }
        }
        swap((arr + i), min); // Swap the found minimum element with the first element
    }
    //Printing the sorted array 
    printf("The sorted array by  Selection  sort is given below\n");
    for (int x = 0 ; x < size ; x++ ){
        printf("%d ",*(arr + x));
    }
    printf("\n");


}

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

// Part 4: Linked List
// Part 4: Linked List
union Data {
    int i;
    float f;
    char c;
}; 

struct Node {
    union Data data;
    struct Node* next;
};


void insertAtBeginning(struct Node** head, union Data value) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    if (newNode == NULL){
        printf("Memory allocation Failed\n");
        return;
    } 
    
    // Set the data for the new node
    if (value.i) {
        newNode->data.i = value.i;
    } else if (value.f) {
        newNode->data.f = value.f;
    } else if (value.c) {
        newNode->data.c = value.c;
    } 
    // Point the next of new node to the current head
    newNode->next = *head;
    // Move the head to point to the new node
    *head = newNode;

}

void deleteByValue(struct Node** head, union Data value) {
    struct Node* current = *head;
    struct Node* previous = NULL;
     // Traverse the list to find the node with the given value
    while (current != NULL) {
        // Check if the current node's data matches the value
        if ((current->data.i && value.i == current->data.i) ||
            (current->data.f && value.f == current->data.f) ||
            (current->data.c && value.c == current->data.c)) {
            // If found, break the loop and delete the node
            break;
        }
        previous = current;
        current = current->next;           
    }

    if ( current == NULL){
         printf("Value  not found in the linked list.\n");
        return;
    }
    
    if (previous == NULL) {
        *head = current->next; // The head node is to be deleted
    } 
    
    else {
        previous->next = current->next; // Bypass the current node
    }

    free(current);
    
}




void printList(struct Node* head) {
    struct Node* current = head;
    while (current != NULL) {
        
        if (current->data.i) {
            printf("%d -> ", current->data.i);
        } else if (current->data.f) {
            printf("%f -> ", current->data.f);
        } else if (current->data.c) {
            printf("%c -> ", current->data.c);
        }

        current = current->next;
    }
    printf("NULL\n");
}


// Part 5: Dynamic Memory Allocation

// Part 5.1: Dynamic Allocation, Sum, and Average

// Function to create a dynamic array
int* createDynamicArray(int size) {
    int* array = (int*)malloc(size * sizeof(int));
    if (array == NULL) {
        printf("Memory allocation failed\n");
        exit(1);
    }
    return array;
}

// Function to calculate the sum and average of array elements
void calculateSumAndAverage(int* arr, int size, int* sum, float* average) {
    *sum = 0;
    for (int i = 0; i < size; i++) {
        *sum += arr[i];
    }
    *average = (float)(*sum) / size;
}

// Part 5.2: Extend Array with realloc

void extendArray(int** arr, int* size, int newSize) {
    int* temp = (int*)realloc(*arr, newSize * sizeof(int));
    if (temp == NULL) {
        printf("Memory reallocation failed\n");
        return;
    }
    *arr = temp;
    *size = newSize;
}

// Part 5.3: Memory Leak Detector

// Linked list to keep track of allocated memory
struct MemoryNode {
    void* address;
    struct MemoryNode* next;
};

struct MemoryNode* head = NULL;

// Allocate memory and keep track of it
void* allocateMemory(size_t size) {
    void* ptr = malloc(size);
    if (ptr == NULL) {
        printf("Memory allocation failed\n");
        exit(1);
    }

    struct MemoryNode* newNode = (struct MemoryNode*)malloc(sizeof(struct MemoryNode));
    newNode->address = ptr;
    newNode->next = head;
    head = newNode;

    return ptr;
}

// Free memory and update tracking
void freeMemory(void* ptr) {
    struct MemoryNode* current = head;
    struct MemoryNode* previous = NULL;

    while (current != NULL) {
        if (current->address == ptr) {
            if (previous == NULL) {
                head = current->next;
            } else {
                previous->next = current->next;
            }
            free(current);
            break;
        }
        previous = current;
        current = current->next;
    }

    free(ptr);
}

// Check for memory leaks
void checkMemoryLeaks() {
    struct MemoryNode* current = head;
    while (current != NULL) {
        printf("Memory leak detected: %p\n", current->address);
        
        current = current->next;
        
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




void freeUniversity(struct University* uni) {
    for (int i = 0; i < uni->numDepartments; i++) {
        freeMemory(uni->departments[i].students);
    }
    freeMemory(uni->departments);
}


void inputStudentData(struct Student* s) {
    printf("Enter the name of the student: ");
    getchar(); // Clear the newline left by previous input
    fgets(s->name, sizeof(s->name), stdin);
    s->name[strcspn(s->name, "\n")] = '\0';  // Removes newline character added by fgets.

    printf("Enter student ID: ");
    scanf("%d", &s->id);

    printf("Enter grades for three subjects (separated by space): ");
    scanf("%f %f %f", &s->grades[0], &s->grades[1], &s->grades[2]);
}

float calculateAverage(struct Student* s) {
    float sum = 0.0;
    for (int i = 0; i < 3; i++) {
        sum += s->grades[i];
    }
    return sum / 3.0;
}

void printStudentInfo(struct Student* s) {
    printf("Student Information\n");
    printf("Name: %s\n", s->name);
    printf("Student's ID: %d\n", s->id);
    printf("Student's Grades: %f %f %f\n", s->grades[0], s->grades[1], s->grades[2]);
    printf("Student's Average grade: %f\n", calculateAverage(s));
}

void createUniversity(struct University* uni) {
    printf("Enter the name of university: ");
    getchar(); // Clear the newline left by previous input
    fgets(uni->name, sizeof(uni->name), stdin);
    uni->name[strcspn(uni->name, "\n")] = '\0';  // Removes newline character added by fgets.

    printf("Enter the number of departments: ");
    scanf("%d", &uni->numDepartments);

    // Allocate memory for departments
    uni->departments = (struct Department*)allocateMemory(uni->numDepartments * sizeof(struct Department));
    if (uni->departments == NULL) {
        fprintf(stderr, "Memory allocation failed. Exiting...\n");
        exit(1);
    }

    // Enter details for each department
    for (int i = 0; i < uni->numDepartments; i++) {
        printf("Enter the name of department: ");
        getchar(); // Clear the newline left by previous input
        fgets(uni->departments[i].name, sizeof(uni->departments[i].name), stdin);
        uni->departments[i].name[strcspn(uni->departments[i].name, "\n")] = '\0';  // Removes newline character added by fgets.

        printf("Enter the number of students: ");
        scanf("%d", &uni->departments[i].numStudents);

        // Allocate memory for the students
        uni->departments[i].students = (struct Student*)allocateMemory(uni->departments[i].numStudents * sizeof(struct Student));
        if (uni->departments[i].students == NULL) {
            printf("Memory allocation failed for Students\n");
            exit(1);
        }

        // Enter details for each student in the department
        for (int j = 0; j < uni->departments[i].numStudents; j++) {
            printf("\nEnter details for student #%d in %s department:\n", j + 1, uni->departments[i].name);
            inputStudentData(&uni->departments[i].students[j]);
        }
    }
}

void printUniversityHierarchy(struct University* uni) {
    printf("\nUniversity Name: %s\n", uni->name);
    for (int i = 0; i < uni->numDepartments; i++) {
        printf("Department: %s\n", uni->departments[i].name);
        for (int j = 0; j < uni->departments[i].numStudents; j++) {
            printf("  Student #%d:\n", j + 1);
            printStudentInfo(&uni->departments[i].students[j]);
        }
    }
}

// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error opening file for writing.\n");
        return;
    }
    fprintf(file, "%s\n%d\n%f %f %f\n", s->name, s->id, s->grades[0], s->grades[1], s->grades[2]);
    fclose(file);
    printf("Student data written to file: %s\n", filename);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file for reading.\n");
        return;
    }
    fgets(s->name, sizeof(s->name), file);
    s->name[strcspn(s->name, "\n")] = '\0'; // Remove newline character
    fscanf(file, "%d", &s->id);
    fscanf(file, "%f %f %f", &s->grades[0], &s->grades[1], &s->grades[2]);
    fclose(file);
    printf("Student data read from file: %s\n", filename);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "wb");
    if (file == NULL) {
        printf("Error opening file for writing.\n");
        return;
    }
    fwrite(s, sizeof(struct Student), 1, file);
    fclose(file);
    printf("Student data written to binary file: %s\n", filename);
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Error opening file for reading.\n");
        return;
    }
    fread(s, sizeof(struct Student), 1, file);
    fclose(file);
    printf("Student data read from binary file: %s\n", filename);
}


void logMessage(const char* message, const char* logfile) {
    FILE* file = fopen(logfile, "a");
    if (file == NULL) {
        printf("Error opening log file.\n");
        return;
    }

    time_t now = time(NULL);
    char* timestamp = ctime(&now);
    timestamp[strcspn(timestamp, "\n")] = '\0'; // Remove newline character

    fprintf(file, "[%s] %s\n", timestamp, message);
    fclose(file);
}

void displayLog(const char* logfile) {
    FILE* file = fopen(logfile, "r");
    if (file == NULL) {
        printf("Error opening log file.\n");
        return;
    }

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        printf("%s", line);
    }
    fclose(file);
}


int main() {
    srand(time(NULL));
    int x = 10;
    int *prtx = &x;
    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");

    printf("The value of the integer variable x by direct method is: %d\n", x);
    printf("The value of the integer variable x by pointer method is: %d\n", *prtx);
    // Modifying the variable value using pointer
    *prtx = 20;
    printf("The new value of variable x using pointer is: %d\n", x);

    int first_swap_element = 5;
    int second_swap_element = 4;
    printf("First element is: %d\n", first_swap_element);
    printf("Second element is: %d\n", second_swap_element);

    swap(&first_swap_element, &second_swap_element);

    int sum = 0;
    int arr[5] = {0, 1, 2, 3, 4};
    int *prt_arr = arr;
    int length = sizeof(arr) / sizeof(arr[0]); // Determining the length of array
    for (int i = 0; i < length; i++) {
        printf("The %d element of array is: %d\n", i, *(prt_arr + i));
        sum = sum + *(prt_arr + i);
    }
    printf("The sum of the array is: %d\n", sum);

    reverseArray(arr, length);

    printf("Reversed array: ");
    for (int i = 0; i < length; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    
    int rows = 4;
    int cols = 5;
    int matrix[rows][cols];
    int (*prt_matrix)[cols] = matrix;

    // Initializing the matrix
    initializeMatrix(rows, cols, prt_matrix);

    // Printing the matrix
    printMatrix(rows, cols, prt_matrix);

    // Finding the max number out of a matrix
    printf("The maximum number in the matrix is : %d\n", findMaxInMatrix(rows, cols, prt_matrix));

    sumOfMatrixRow(rows, cols, prt_matrix);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // Initializing the array with random numbers
    int array[9];
    int length_arr = sizeof(array) / sizeof(array[0]);
    for (int i = 0; i < length_arr; i++) {
        array[i] = rand() % 100;
    }

    // Printing the original array
    printf("The original array is given below\n");
    for (int i = 0; i < length_arr; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    printf("Sorting Array Using the Function\n");
    // Sorting the array
    bubbleSort(array, length_arr);

    selectionSort(array, length_arr);
    
    printf("Sorting the Array using the Function Pointer\n");

    void (*SortFunction)(int*, int);
    // Calling the Bubble Sort by function pointer
    SortFunction = bubbleSort;
    printf("Bubble Sort by Function Pointer Method\n");
    SortFunction(array, length_arr);

    // Calling the Selection Sort by function pointer
    SortFunction = selectionSort;
    printf("Selection Sort by Function Pointer Method\n");
    SortFunction(array, length_arr);

    // Calculator by Function Pointer
    int operand_1, operand_2, choice;
    int result;
    int (*operation)(int, int); // Function Pointer

    printf("Enter two operands: ");
    scanf("%d %d", &operand_1, &operand_2);
    printf("Choose an operation:\n");
    printf("1. Add\n");
    printf("2. Subtract\n");
    printf("3. Multiply\n");
    printf("4. Divide\n");
    scanf("%d", &choice);

    switch (choice) {
        case 1:
            operation = add;
            break;
        case 2:
            operation = subtract;
            break;
        case 3:
            operation = multiply;
            break;
        case 4:
            operation = divide;
            break;
        default:
            printf("Invalid choice\n");
            return 1;
    }

    result = operation(operand_1, operand_2);
    printf("The result is: %d\n", result);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    struct Node* head = NULL;

    union Data n1, n2, n3, n4;

    n1.i = 3;
    n2.f = 3.76;
    n3.c = 'A';
    n4.i = 7;

    insertAtBeginning(&head, n1);
    insertAtBeginning(&head, n2);
    insertAtBeginning(&head, n3);
    insertAtBeginning(&head, n4);

    printList(head);     

    deleteByValue(&head, n4);

    printf("List after deleting n4\n");
    printList(head);

    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    int size;
    printf("Enter the size of the array: ");
    scanf("%d", &size);

    int* dynamicArray = (int*)allocateMemory(size * sizeof(int));

    printf("Enter %d elements: ", size);
    for (int i = 0; i < size; i++) {
        scanf("%d", &dynamicArray[i]);
    }

    int sumArray;
    float average;
    calculateSumAndAverage(dynamicArray, size, &sumArray, &average);

    printf("Sum: %d\n", sumArray);
    printf("Average: %.2f\n", average);

    // Extend the array
    int newSize;
    printf("Enter the new size of the array: ");
    scanf("%d", &newSize);
    int oldSize = size;
    extendArray(&dynamicArray, &size, newSize);

    printf("Enter additional %d elements: ", newSize - oldSize);
    for (int i = oldSize; i < newSize; i++) {
        scanf("%d", &dynamicArray[i]);
    }

    calculateSumAndAverage(dynamicArray, newSize, &sumArray, &average);

    printf("Sum after extending: %d\n", sumArray);
    printf("Average after extending: %.2f\n", average);

    // Free the array
    freeMemory(dynamicArray);

    // Check for memory leaks
    checkMemoryLeaks();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // Part 6: Structures and Unions && Part 7:
    printf("\nPart 6: Structures and Unions\n");

    struct University uni;
    createUniversity(&uni);
    printUniversityHierarchy(&uni);

    // Example: Writing and Reading student data to/from text and binary files
    struct Student s = uni.departments[0].students[0];

    // Write and read from text file
    writeStudentToFile(&s, "student.txt");
    struct Student s_read;
    readStudentFromFile(&s_read, "student.txt");
    printStudentInfo(&s_read);

    // Write and read from binary file
    writeStudentToBinaryFile(&s, "student.bin");
    readStudentFromBinaryFile(&s_read, "student.bin");
    printStudentInfo(&s_read);

    // Example: Logging messages
    logMessage("University data processed.", "logfile.txt");
    logMessage("Student data written to files.", "logfile.txt");

    // Display log file
    printf("\nLog file contents:\n");
    displayLog("logfile.txt");

    // Free allocated memory
    for (int i = 0; i < uni.numDepartments; i++) {
        freeMemory(uni.departments[i].students);
    }
    freeMemory(uni.departments);

    return 0;
}