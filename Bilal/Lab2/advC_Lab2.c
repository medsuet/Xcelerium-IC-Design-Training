#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>


// Part 1: Pointer Basics and Arithmetic

//swap function is basic function to swap two integers using pointers
void swap(int *a, int *b) {
    int temp;

    temp = *a;
    *a = *b;
    *b = temp;
}

//function to reverse an array

//reverseArray is the function which takes the initial pointer and size of an array and reverse the array
void reverseArray(int *arr, int size) {
    
    int *start = arr;
    int *end = arr + (size - 1);
    
    while (start < end) {
        int tem = *start;
        *start = *end;
        *end = tem;
        start++;
        end--;
    }  
}

//function to print an array
//This function also returns the sum of array 
int printArray(int *arr, int size) {
    int len = size / sizeof(*arr);
    int sum = 0;
    for (int i = 0; i < len; i++) {
        printf("%d; ",*(arr+i));
        sum = sum + *(arr+i);
    }
    printf("\n");
    return sum;
}

//function to initialize a random 2D-array (matrix) with random values between 0 - 99
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    srand(time(NULL));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            *(*(matrix + i) + j) = rand() % 100;
        }
    }
}

//function to print 2D-array
void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("Entry(%d, %d) = %d; ",i,j,*(*(matrix + i) + j));
        }
        printf("\n");
    }
}

//The function is iterating through the each element of a matrix to find maximum element
int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    
    int max = 0;
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (max < *(*(matrix + i) + j)) {
                max =  *(*(matrix + i) + j);
            }
        }
    }
    return max;
}

//The function displays the sum of each row of a matrix/2D-array
void sumOfEachRow(int rows, int cols, int (*matrix)[cols])  {
    int temp_val = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            temp_val = temp_val + *(*(matrix + i) + j);
        }
        printf("\nThe sum of elements of row no. %d = %d\n", i, temp_val);
        temp_val = 0;

    }
}
//bubble sort algorithm implementation
void bubbleSort(int *arr, int size) {
    int len = size / sizeof(*arr);
    int i, j;
    for (i = 0; i < (len - 1); i++) {
        for (j = 0; j < (len - i - 1); j++){
            if (*(arr + j) > *(arr + j + 1)){
                int temp = *(arr + j);
                *(arr + j) = *(arr + j + 1);
                *(arr + j + 1) = temp;

            }
        }

    }
}

//Selection sort algorithm
void selectionSort(int *arr, int size) {
    int len = size / sizeof(*arr);
    int min = 0;
    for (int i = 0; i < len - 1; i++){
        min = i;
        for (int j = i; j < len; j++) {
            if (*(arr+j) < *(arr + min)) {
                min = j;
                
            }
        }
        int temp = *(arr+i);
        *(arr + i) = *(arr + min);
        *(arr + min) = temp;
    }
}

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }


// Part 4: Linked List
union Data {
    int i;
    float f;
    char c;
};

// Define a structure for the linked list node
struct Node {
    union Data data;
    struct Node *next;
};

//Generic Linked list function which insert a node at begining 
void insertAtBeginning(struct Node** head, union Data value) {
    // TODO: Implement insert at beginning
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    //Check whther the memory allocated succesfully or not
    if (newNode == NULL) {
        printf("Memory allocation failed");
        return;
    }
    // Set data and next pointer of new node
    if (value.i) {
        newNode->data.i = value.i;
    } else if (value.f) {
        newNode->data.f = value.f;
    } else if (value.c) {
        newNode->data.c = value.c;
    }
    
    newNode->next = *head;
    
    // Move the head to point to the new node
    *head = newNode;
}

//Generic linked list function which delete a node having a certain value
void deleteByValue(struct Node **head, union Data value) {
    struct Node *current = *head;
    struct Node *prev = NULL;

    // Traverse the list to find the node with the given value
    while (current != NULL) {
        // Check if the current node's data matches the value
        if ((current->data.i && value.i == current->data.i) ||
            (current->data.f && value.f == current->data.f) ||
            (current->data.c && value.c == current->data.c)) {
            // If found, break the loop and delete the node
            break;
        }
        // Move to the next node
        prev = current;
        current = current->next;
    }

    // If current is NULL, the value was not found in the list
    if (current == NULL) {
        printf("Value not found in the linked list.\n");
        return;
    }

    // Remove the node from the linked list
    if (prev == NULL) {
        // If the node to be deleted is the head node
        *head = current->next;
    } else {
        // If the node to be deleted is not the head node
        prev->next = current->next;
    }

    // Free memory allocated for the deleted node
    free(current);
}

//generic linked list function to print the list
void printList(struct Node* head) {
    // TODO: Implement print list
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

//Function to free memory allocated for the linked list
void freeList(struct Node *head) {
    struct Node *temp;
    while (head != NULL) {
        temp = head;
        head = head->next;
        free(temp);
    }
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


//This is part 01 of the LAB2
void part1(void) {
    
    int v = 23; //initializing a variable
    int *pv = &v;  //pv is the pointer to v
    printf("Value of variable using direct access = %d\n",v);
    printf("Value of variable using pointer = %d\n",*pv);
    *pv = 34;  //changing the value of variable using its pointer
    printf("Modified value of variable = %d\n",*pv);
    
    //initializing two variables and swap them 
    int a = 2;
    int b = 3;
    swap(&a,&b);
    
    //initializing an array and its pointer
    int arr[5] = {1,2,3,4,5};
    int *prt_arr = arr;
    
    int sum = printArray(prt_arr, sizeof(arr));

    printf("The sum of array is %d\n",sum);
    
    int len = sizeof(arr) / sizeof(arr[0]);

    reverseArray(prt_arr, len);

}

//This is the part 02 of the LAB2
void part2(void) {
    srand(time(NULL));
        
    int rows = 3;
    int cols = 4;
    int matrix[rows][cols];

    int (*prt_mat)[cols] = matrix;
    
    initializeMatrix(rows, cols, prt_mat);
    
    printMatrix(rows, cols, prt_mat);
    
    printf("Maximum value in matrix is %d\n",findMaxInMatrix(rows, cols, prt_mat));
    
    sumOfEachRow(rows, cols, prt_mat);

}

//This is the part 03 of the LAB2
void part3(void) {
    
    //array and pointer to the array
    int array[7] = {43,543,64,2,134,44,5};
    int *prt_array = array;
    printf("Array before sorting\n");
    printArray(prt_array, sizeof(array));

    //function pointer for bubble sort
    void (*func_ptr_Bsort)(int*, int);
    func_ptr_Bsort = bubbleSort;

    //function pointer for selection sort
    void (*func_ptr_Ssort)(int*, int);
    func_ptr_Ssort = selectionSort;


    func_ptr_Ssort(prt_array, sizeof(array));
    printf("Array after sorting\n");
    printArray(prt_array, sizeof(array));

    // Calculator functions pointer
    int (*fp_add)(int, int);
    fp_add = add;
    int (*fp_subtract)(int, int);
    fp_subtract = subtract;
    int (*fp_multiply)(int, int);
    fp_multiply = multiply;
    int (*fp_divide)(int, int);
    fp_divide = divide;

    //calling functions using function pointers
    printf("%d\n", fp_add(54,2));
    printf("%d\n", fp_subtract(3,2));
    printf("%d\n", fp_multiply(6,2));
    printf("%d\n", fp_divide(6,2));

}

//This is the part04 of LAB2
void part4(void) {

    struct Node* head = NULL;

    // Insert nodes at the beginning

    union Data data01, data02, data03, deleteValue;

    data01.i = 23;
    data02.f = 3.32;
    data03.c = 'A';

    insertAtBeginning(&head, data01);
    insertAtBeginning(&head, data02);
    insertAtBeginning(&head, data03);

    // Print the initial list
    printf("Initial List: ");
    printList(head);

    // Delete nodes by value
    deleteValue.f = 3.32;
    deleteByValue(&head, deleteValue);
    

    // Print the modified list
    printf("Modified List: ");
    printList(head);
 
    // Free memory used by the list
    freeList(head);
}

//This is the part05 of LAB2
void part5(void) {

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

}


int main() {
    srand(time(NULL));
///////////////////////////////PART01////////////////////////////////////////////////////////////////////////////////
    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3

    part1();
///////////////////////////////PART02////////////////////////////////////////////////////////////////////////////////
    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2

    part2();
///////////////////////////////PART03////////////////////////////////////////////////////////////////////////////////
    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3

    part3();
///////////////////////////////PART04////////////////////////////////////////////////////////////////////////////////
    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2

    part4();
///////////////////////////////PART05////////////////////////////////////////////////////////////////////////////////
    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3

    part5();
///////////////////////////////PART06////////////////////////////////////////////////////////////////////////////////
    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4
    printf("\nPart 6: Structures and Unions\n");

    struct University uni;
    createUniversity(&uni);
    printUniversityHierarchy(&uni);
    struct Student s = uni.departments[0].students[0];

///////////////////////////////PART07////////////////////////////////////////////////////////////////////////////////
    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3
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
    checkMemoryLeaks();

    return 0;
}


