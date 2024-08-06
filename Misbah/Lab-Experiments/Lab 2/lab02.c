#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#define MAX_ALLOCATIONS 100
#define MAX_LOG 1024

//Print Array
void printarr(int sizeofarr,int *ptr){
    for(int i = 0; i < sizeofarr; i++){
        printf("%d ", *(ptr + i));
    }
    printf("\n");
}
// Part 1: Pointer Basics and Arithmetic
void basics(){
    int basic = 4;
    int *ptr = &basic;
    printf("Direct Method Value: %d \n", basic);
    printf("Pointer Method Value: %d \n", *ptr);
    *ptr = 5;
    printf("Modified Direct Method Value: %d \n", basic);
    printf("Modified Pointer Method Value: %d  \n", *ptr);
}

void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp = *a;
    *a = *b;
    *b = temp;
}
    

void reverseArray(int *arr, int size, int Array[]) {
    // TODO: Implement array reversal using pointers
    for(int i = 0; i < size/2; i++){
        swap(&arr[i], &arr[size - i -1]);
    }
    printarr(size, arr);
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
    for(int i = 0; i<rows; i++){
        for(int j = 0;  j<cols; j++){
            matrix[i][j] = rand() % 100 + 1;
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
    for(int i = 0; i<rows; i++){
        for(int j = 0;  j<cols; j++){
            printf("%d ", *(*(matrix + i)+j));
        }
        printf("\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    int maxnumber = matrix[0][0];
    for(int i = 0; i < rows; i++){
        for(int j = 0; j<cols; j++){
            if(maxnumber<matrix[i][j]){
                maxnumber = matrix[i][j];
            }
        }
    }
    return maxnumber;
}

void RowsSum(int rows, int cols, int array[rows][cols]){
    for(int i = 0;  i  < rows; i++){
        int sum  = 0;
        for(int j = 0; j < cols; j++){
            sum = sum + array[i][j];
        }
        printf("Sum of Row %d = %d",i, sum);
        printf("\n");
    }
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    for(int j = 0; j<size; j++){
        for(int i  = 0; i < (size-j-1); i++){
            if(*(arr+i) > *(arr + i + 1)){
                swap((arr+i), (arr + i + 1));
            }
        }
    }
    printf("Bubble Sort Algorithm Result: ");
    printarr(size, arr);
}

void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
    int temp = *arr;
    int j = 0, i = j;
    for(j; j < size; j++){
        for(i; i < size; i++){
            if(temp > *(arr+i)){
                temp = *(arr+i);
            }
        }
        *(arr+i+1) = temp;
    }
    printf("Selection Sort Algorithm Result: ");
    printarr(size, arr);
}

typedef void (*SortFunction)(int*, int);

// Function Pointer Type
typedef int (*ArithmeticOperation)(int, int);
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


struct Node {
    int data;
    struct Node* next;
};
struct NodeNew {
    union Data data;
    struct NodeNew* next;
};
void insertAtBeginning(struct Node** head, int value) {
    // TODO: Implement insert at beginning
    struct Node* new_node  = (struct Node*)malloc(sizeof(struct Node));
    new_node->data = value;
    new_node->next = (*head);
    (*head) = new_node;
}
void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
    struct Node* temp = *head, *prev;

    if(temp != NULL && temp->data == value){
        *head = temp->next; 
        free(temp);
        return;  
    }
    while(temp != NULL && temp->data != value){
        prev = temp;
        temp = temp->next;
    }
    if(temp  ==  NULL) return;
    prev->next = temp->next;

    free(temp);
}

void printList(struct Node* head) {
    // TODO: Implement print list
    while(head != NULL){
        printf("%d -> ", head->data);
        head = head->next;
    }
    printf("NULL\n");
}

//4.2 Pointer Functions to create Linked List
typedef void (*DataType)(struct NodeNew* node);

// Function definitions
void integer_value(struct NodeNew* node){
    int num_int;
    printf("Enter integer value:");
    scanf("%d",&num_int);
    node->data.i=num_int;
}
void float_value(struct NodeNew* node){
    float num_float;
    printf("Enter float value:");
    while(getchar()!='\n'); // Clear input buffer
    scanf("%f",&num_float);
    node->data.f=num_float;
}
void char_value(struct NodeNew* node){
    char character;
    printf("Enter character value:");
    while (getchar()!='\n'); // Clear input buffer
    scanf("%c",&character);
    node->data.c=character;
}
void my_list(DataType dataType, struct NodeNew* node){
    dataType(node);
}
void initialize_list(char flag){
    struct NodeNew* node=(struct NodeNew*)malloc(sizeof(struct NodeNew));
    node->next=NULL;
    if (flag=='i'){
        my_list(integer_value,node);
    }
    else if (flag=='f'){
        my_list(float_value,node);
    }
    else if (flag=='c'){
        my_list(char_value,node);
    }
    else {
        printf("Invalid data type entered.\n");
    }
     printf("Data initialized: ");
    switch (flag) {
        case 'i':
            printf("%d\n", node->data.i);
            break;
        case 'f':
            printf("%f\n", node->data.f);
            break;
        case 'c':
            printf("%c\n", node->data.c);
            break;
        default:
            break;
    }
}


int* createDynamicArray(int size) {
    int *arr_dmu = (int *)malloc(size * sizeof(int));
    if (arr_dmu == NULL) {
        printf("Memory Allocation Failed\n");
        return NULL;
    }

    int sum = 0;
    float average;
    for (int i = 0; i < size; i++) {
        printf("Enter element no. %d: ", i);
        scanf("%d", &arr_dmu[i]);
        sum += arr_dmu[i];
    }

    average = (float)sum / size;
    printf("\n");
    printf("The sum of all the elements is: %d\n", sum);
    printf("The average of all the elements is: %f\n", average);
    return arr_dmu;
}

int* extendArray(int* arr, int size, int newSize) {
    int* ext_array = (int *)realloc(arr, newSize * sizeof(int));
    if (ext_array == NULL) {
        printf("Memory Reallocation Failed\n");
        return arr; // Return the original array if reallocation fails
    }

    // Initialize the newly allocated memory
    for (int i = size; i < newSize; i++) {
        ext_array[i] = rand() % 100 + 1;
    }

    return ext_array;
}

typedef struct {
    void *addresses[MAX_ALLOCATIONS];
    size_t sizes[MAX_ALLOCATIONS];
} MemoryTracker;

MemoryTracker tracker = { 0 };
int allocationCount = 0;

void* allocateMemory(size_t size) {
    void *ptr = malloc(size);
    if (ptr == NULL) {
        printf("Memory allocation failed.\n");
        return NULL;
    }

    if (allocationCount < MAX_ALLOCATIONS) {
        tracker.addresses[allocationCount] = ptr;
        tracker.sizes[allocationCount] = size;
    }
    allocationCount++;

    return ptr;
}

// Custom free function
void freeMemory(void *ptr) {
    for (int i = 0; i < MAX_ALLOCATIONS; ++i) {
        if (tracker.addresses[i] == ptr) {
            free(ptr);
            tracker.addresses[i] = NULL;
            tracker.sizes[i] = 0;
            allocationCount--;
            return;
        }
    }

    printf("Attempt to free unallocated memory.\n");
}

// Function to check for memory leaks
void checkMemoryLeaks() {
    int leaks = 0;
    for (int i = 0; i < MAX_ALLOCATIONS; ++i) {
        if (tracker.addresses[i] != NULL) {
            if (leaks == 0) {
                printf("Memory leaks detected:\n");
            }
            printf("Leaked address: %p, size: %zu bytes\n", tracker.addresses[i], tracker.sizes[i]);
            leaks++;
        }
    }
    if (leaks == 0) {
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

void inputStudentData(struct Student* s) {
    // TODO: Implement this function
    struct Student temp = {"Misbah", 5, {5, 6, 7}};
    *s = temp;
}
float calculateAverage(struct Student* s) {
    // TODO: Implement this function
    float *arr;
    float sum = 0;
    float avr;
    arr = s->grades;
    int size = sizeof(arr)/sizeof arr[0];
    for(int i = 0; i < size; i++){
        sum = sum + arr[i];
    }
    avr =  sum  / size;
    return avr;
}
void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
    printf("Name: %s\n", s->name);
    printf("ID: %d\n", s->id);
    float *printarr = s->grades;
    printf("Grades: ");
    for(int i = 0; i < 3;  i++){
        printf("%f ",*(printarr+i));
    }
    printf("\n");
}


void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
    FILE* file = fopen(filename, "w");
    if(file == NULL){
        printf("Error opening the file. \n");
        return;
    }
    fprintf(file, "%s %d %.1f %.1f %.1f\n", s->name, s->id, s->grades[0], s->grades[1], s->grades[2]);
    fclose(file);

    } 



void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
    FILE* file = fopen(filename, "r");
    if(file == NULL){
        printf("Error opening the file to read.\n");
        return;
    }
    fscanf(file, "%s %d %f %f %f", s->name, &s->id, &s->grades[0], &s->grades[1], &s->grades[2]);

    fclose(file);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
    FILE* file = fopen(filename, "wb");
    if(file == NULL){
        printf("Error opening the file to write. \n");
        return;
    }
    fwrite(s, sizeof(struct Student), 1, file);

    fclose(file);
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
    FILE* file = fopen(filename, "rb");
    if(file == NULL){
        printf("Error opening the file to read.\n");
        return;
    }
    fread(s, sizeof(struct Student), 1, file);

    fclose(file);
}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    FILE* file = fopen(logfile, "a");
    if(file == NULL){
        printf("Error to open the file.\n");
        return;
    }
    time_t current;
    struct tm* time_st;
    char timestamp[80];

    time(&current);
    time_st = localtime(&current);
    strftime(timestamp, sizeof(timestamp), "[%Y-%m_%d %H:%M:%S] ", time_st);
    fprintf(file, "%s %s\n", timestamp, message);

    fclose(file);
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
    FILE* file =  fopen(logfile, "r");
    if(file == NULL){
        printf("Error opening the file to read.\n");
        return;
    }
    char line[MAX_LOG];
    printf("Log File Data %s:\n", logfile);
    while (fgets(line, sizeof(line), file)){
        printf("%s", line);
    }
    fclose(file);
}

int main() {
    srand(time(NULL));
    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3
    printf("\n1.1. Basic Pointers\n");
    basics();
    int var1 = 3, var2 = 6;
    int *ptr1 = &var1, *ptr2 = &var2;
    printf("\n1.2. Swapping Pointers\n");
    printf("Before Swapping: var1 = %d,  var2 = %d \n", *ptr1, *ptr2);
    swap(ptr1, ptr2);
    printf("After Swapping: var1 = %d,  var2 = %d \n", *ptr1, *ptr2);
    printf("\n1.3. Arrays\n");
    int array[5] = {1,2,3,4,5};
    int size = sizeof(array) / sizeof(array[0]);
    int *arr_ptr = array;
    printarr(size, arr_ptr);
    reverseArray(arr_ptr, size, array);

    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2
    printf("\n2.1. 2D Arrays\n");
    int matrixarray[3][4];
    int (*matrix)[4] = matrixarray;
    initializeMatrix(3, 4, matrix);

    printMatrix(3, 4, matrix);

    findMaxInMatrix(3, 4, matrix);
    printf("%d\n", findMaxInMatrix(3, 4,  matrix));
    printf("\n2.2. Sum of Row\n");
    RowsSum(3, 4, matrixarray);

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3

    //BubbleSort
    int array_to_sort[7] = {3,7,8,2,345,12,0};
    int *arr_s_ptr  = array_to_sort;
    size = sizeof(array_to_sort) / sizeof(array_to_sort[0]);
    printf("Original Array: ");
    printarr(size, arr_s_ptr);
    printf("\n3.1. Bubble and Selection Sort\n");
    bubbleSort(arr_s_ptr,  size);
    selectionSort(arr_s_ptr, size);

    printf("\n3.2. Sorting by function pointers\n");
    //Function Pointer
    int arr_fn_ptr[6] = {3,7,89,4,1,2};
    int *fn_ptr = arr_fn_ptr;
    size = sizeof(arr_fn_ptr) / sizeof(arr_fn_ptr[0]);
    SortFunction sort_function = bubbleSort;
    printf("Original Array: ");
    printarr(size, fn_ptr);
    sort_function(fn_ptr, size);
    
    printf("\n3.3. Simple Calculator with Function Pointer\n");
    // Calculator using function pointers
    ArithmeticOperation operation;
    int a, b;
    char op;
    printf("Enter 1st number: ");
    scanf("%d" , &a);
    printf("\nEnter 2nd number: ");
    scanf("%d", &b);
    printf("\nEnter the sign for the operation to perform: ");
    scanf(" %c", &op);
    switch(op){
    case '+':
        printf("The above numbers are added to give: ");
        operation = add;
        break;
    case '-':
        printf("The above numbers are subtracted to give: ");
        operation = subtract;
        break;
    case '*':
        printf("The above numbers are multiplied to give: ");
        operation = multiply;
        break;
    case '/':
        printf("The above numbers have the quotient: ");
        operation = divide;
        break;
    default:
        printf("Invalid operator!\n");
        return 1; // Exit program with error code
    }

    int result =  operation(a,b);
    printf("%d \n", result);

    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2

    printf("\n4.1. Linked Lists\n");
    //Linked Lists
    struct Node* head = NULL;

    //Insert Node
    insertAtBeginning(&head, 5);
    insertAtBeginning(&head, 34);
    insertAtBeginning(&head, 6);
    insertAtBeginning(&head, 8);
    insertAtBeginning(&head, 7);

    //Printing the Linked List
    printf("Linked List: ");
    printList(head);

    //Deleting the Node by VALUE
    deleteByValue(&head, 7);
    printf("Linked List after deleting 7: ");
    printList(head);

    printf("\n4.2. Generic Linked List\n");
    char flag;
    printf("Enter data type for linkedlist(i for integer, f for float, c for character):");
    while(getchar()!='\n');
    scanf("%c",&flag);
    initialize_list(flag);
   
    // Part 5: Dynamic Memory Allocation
    printf("\nPart 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3

    printf("\n5.1. Dynamic Memory Allocation\n");
    //Dynamic Memroy Allocation for array
    int num;
    printf("Enter the number of elements for the array: ");
    scanf("%d", &num);

    int *arr_dmu = createDynamicArray(num);
    if (arr_dmu == NULL) {
        return 1; // Exit if memory allocation failed
    }

    printf("Array Elements: ");
    printarr(num, arr_dmu); // Print original array elements

    int num_ext;
    printf("Enter the number of elements to extend the array: ");
    scanf("%d", &num_ext);

    printf("\n5.2. Reallocation\n");
    arr_dmu = extendArray(arr_dmu, num, num + num_ext);
    if (arr_dmu == NULL) {
        return 1; // Exit if memory reallocation failed
    }

    printf("Extended Array Elements: ");
    printarr(num + num_ext, arr_dmu); // Print extended array elements
    free(arr_dmu); // Free the extended array

    printf("\n5.3. Memroy Leaks Checker\n");
    int *array1 = (int*)allocateMemory(5 * sizeof(int));
    char *str = (char*)allocateMemory(20 * sizeof(char));

    if (str) {
        strcpy(str, "Hello, world!");
    }
    freeMemory(array1);
    freeMemory(str);
    checkMemoryLeaks();


    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4
    struct Student student;
    inputStudentData(&student);
    printf("Average of the Grades: %2f\n", calculateAverage(&student));
    printStudentInfo(&student);


    //Union Usage
    printf("\n6.4. Unions\n");
    union Data data_var;
    data_var.i = 5;
    printf("Integer printed through union: %d\n", data_var.i); 
    data_var.f = 5.643;
    printf("Integer printed through union: %f\n", data_var.f); 
    data_var.c = 'M';
    printf("Integer printed through union: %c\n", data_var.c); 
    data_var.i = 3;
    printf("Integer printed through union: %d\n", data_var.i); 

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.
    printf("\n7.1. Write Data to File\n");
    const char* filename = "datafile.txt";
    writeStudentToFile(&student, filename);
    printf("Data written to the file %s.\n", filename);
    
    printf("\n7.2. Read Data from File\n");
    readStudentFromFile(&student,filename);
    printf("Data read form the file: \n");
    printStudentInfo(&student);

    printf("\n7.3. Write Data to Binary File\n");
    const char* binfilename = "datafile.bin";
    writeStudentToBinaryFile(&student, binfilename);
    printf("Data written to the binary file %s.\n", filename);
    

    printf("\n7.4. Read Data from BInary File\n");
    readStudentFromBinaryFile(&student,binfilename);
    printf("Data read form the binary file: \n");
    printStudentInfo(&student);

    const char*  log_file =  "logfile.txt";

    logMessage("Application started.", log_file);
    logMessage("User logged in.", log_file);
    logMessage("Data processing successful.", log_file);

    displayLog(log_file);


    return 0;
}
