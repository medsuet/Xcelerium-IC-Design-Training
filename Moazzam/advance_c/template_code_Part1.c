#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int *mem_ptr;

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
   int temp = *a;
   *a = *b;
   *b = temp;
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
   int *start = arr ;
   int *end = arr + size -1;
   while ( start < end){
       swap(start , end);
       start++;
       end--;
   }
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            *(*(matrix + i) + j) = ((rand() % (99 - 10 + 1)) + 10); 
            //rand() % (upper_bound - lower_bound + 1) + lower_bound; 
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
    printf("The matrix of %dx%d of random number is given as:\n",rows, cols);
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            printf("%d ",*(*(matrix + i) + j)); 
        }
        printf("\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    int max = 0;
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            if(max<*(*(matrix + i) + j)){
                max = *(*(matrix + i) + j);
            }
        }
    }
    //printf("the max number in the given matrix is %d.\n", max);
}

void addrows(int rows, int cols, int (*matrix)[cols]){
    int max = 0;
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            max += *(*(matrix + i) + j);
        }
    printf("the addition of %d row in the given matrix is %d.\n", i+1, max);
    max = 0;
    }
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    for(int i=0; i<size-1 ; i++ ){
        for(int j=0; j<size-i-1; j++){
            if (*(arr+j) > *(arr+j+1)){
                swap(arr+j,arr+j+1);
            }
            
        }
    }
}

void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
    for(int i=0; i<size-1 ; i++ ){
        int min_index = i;
        for(int j=i+1; j<size; j++){
            if (*(arr+min_index) > *(arr+j)){
                min_index = j;
            }    
        }
        swap(arr+i,arr+min_index);
    }
}

void SelectionSort(int *arr, int size) {
    // TODO: Implement bubble sort
    for(int i=0; i<size-1 ; i++ ){
        int min_index = i;
        for(int j=i+1; j<size; j++){
            if (*(arr+min_index) > *(arr+j)){
                min_index = j;
            }    
        }
        swap(arr+i,arr+min_index);
    }
}

void (*SortFunction)(int*, int);

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
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    if (newNode == NULL) {
        printf("Memory allocation failed\n");
        return ;
    }

    // Assign value to the new node
    newNode->data = value;
    // Point the new node's next to the current head
    newNode->next = *head;
    // Update the head to the new node
    *head = newNode;
}

void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
    struct Node* temp = *head, *prev = NULL;

    // If head node itself holds the value to be deleted
    if (temp != NULL && temp->data == value) {
        *head = temp->next; // Change head
        free(temp); // Free old head
        return;
    }

    // Search for the value to be deleted
    while (temp != NULL && temp->data != value) {
        prev = temp;
        temp = temp->next;
    }

    // If value was not present in the list
    if (temp == NULL) return;

    // Unlink the node from the linked list
    prev->next = temp->next;

    free(temp); // Free memory
}

void printList(struct Node* head) {
    // TODO: Implement print list
    struct Node* temp = head;
    while (temp != NULL) {
        printf("%d -> ", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}

struct GenericNode {
    void *data; // void can store variable of any type
    size_t size;
    struct GenericNode* next;
};

void genericinsertAtBeginning(struct GenericNode** head, void *new_data, size_t data_size) {
    // TODO: Implement insert at beginning
    int i;

    struct GenericNode *newnode;

    newnode = (struct GenericNode *)malloc(sizeof(struct GenericNode));

    newnode->data = malloc(data_size); // creating a memory through datasize since we don't know type of data

    newnode->size = data_size;

    newnode->next = *head; // head becomes the next node

    *head = newnode;

    // since the new data is of void type, we will conver it into char and store it
    // since new_data is a pointer, we will use (char *) for type conversion

    for (i=0; i<data_size; i++)
    {
        * (char *)(newnode->data+i) = *(char *)(new_data+i); // storing character by character
    }
}


void genericprintList(struct GenericNode *head, void (*fptr)(void *))
{
    while (head != NULL)
    {
        (*fptr)(head->data);
        head = head->next;
    }
}

// Function to print an integer
void printInt(void *n)
{
   printf(" %d", *(int *)n);
}

// Function to print a float
void printFloat(void *f)
{
   printf(" %f", *(float *)f);
}


// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
    int* memory = (int*)malloc(size * sizeof(int));
    return memory;
}

void extendArray(int** arr, int newSize) {
    // TODO: Extend the array using realloc()
    int* temp = (int*)realloc(*arr, newSize * sizeof(int));
    if (temp == NULL) {
        printf("Memory reallocation failed\n");
        exit(1);
    }
    *arr = temp;
}

// Memory leak detector
void* allocateMemory(size_t size) {
    // TODO: Allocate memory and keep track of it

    void *memory = (void*) malloc(size);
	printf("\nAllocated Memory Succesfully!\n");


	return memory;
}

void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
//    printf("%p",*mem_ptr);
	free(ptr);
}

void checkMemoryLeaks() {
    // TODO: Check for memory leaks
//    printf("%p",*mem_ptr);
    if (mem_ptr != NULL)
    {
        printf("There is a memory leak");
    }
    else
    {
        printf("No memory leaks!");
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
    int i;

    printf("\nEnter Student's Name: ");
    scanf("%s",s->name);
    printf("\nEnter Student ID: ");
    scanf("%d",&(s->id));
    for (i=0; i<3; i++)
    {
        printf("Enter Grade for Subject %d: ",i);
        scanf("%f",&(s->grades[i]));
    }
}



float calculateAverage(struct Student* s) {
    // TODO: Implement this function
    int i;
    float sum = 0;

    for (i=0; i<3; i++)
    {
        sum += s->grades[i];
    }

    return (sum/3);
}

void printStudentInfo(struct Student* s) {
    // TODO: Implement this function
    int i;

    printf("\nStudent's name: %s",s->name);
    printf("\nStudent's ID: %d",s->id);

    for (i=0; i<3; i++)
    {
        printf("\nGrade in Subject %d: %f",i,s->grades[i]);
    }
    printf("\n");
}


// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
    FILE *file = fopen(filename, "w");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }
    fprintf(file, "Name: %s\n", s->name);
    fprintf(file, "id: %d\n", s->id);
    fprintf(file, "grade1: %.2f\n", s->grades[0]);
    fprintf(file, "grade2: %.2f\n", s->grades[1]);
    fprintf(file, "grade3: %.2f\n", s->grades[2]);
    fclose(file);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    FILE *file = fopen(filename, "r");
     if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }
    fscanf(file, "Name: %s\n", s->name);
    fscanf(file, "id: %d\n", &s->id);
    fscanf(file, "grade1: %f\n", &s->grades[0]);
    fscanf(file, "grade2: %f\n", &s->grades[1]);
    fscanf(file, "grade3: %f\n", &s->grades[2]);
    fclose(file);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {

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

int (*OperationFunction)(int,int);

int main() {
    srand(time(NULL));

    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3
    printf("Task1.1 demonstrates basic pointer usage: \n");
    int num1 = 5;
    int num2 = 9;
    int sum;
    int *ptr = &num1;
    int arr[5] = {1, 2, 3, 4, 5};
    int *parr = arr;
    int len_arr = sizeof(arr)/ sizeof(arr[0]);

    printf("the value of num1 is %d.\n",num1);
    printf("the value of ptr is %d.\n", *ptr);
    *ptr = 7;
    printf("the update value of num1 is %d.\n",num1);


    printf("\nTask1.2 function that swaps two integers using pointers: \n");
    printf("the value of num1 and num2 before swap is %d and %d.\n",num1,num2);
    swap(ptr , &num2);
    printf("the value of num1 and num2 before swap is %d and %d.\n",num1,num2);



    printf("\nTask1.3 Array of integers and use pointer arithmetic: \n");
    printf("Original array: {");
    for (int i = 0; i < len_arr; i++) {
        printf("%d ", arr[i]);
        sum = sum + arr[i];
    }
    printf("}\n");
    printf("sum of array is %d.\n", sum);

    reverseArray(arr, len_arr);

   printf("Reverse array:  {");
   for (int i = 0; i < len_arr; i++) {
       printf("%d ", arr[i]);
   }
   printf("}\n");

    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2
    printf("\nTask 2.1 Create a 2D array (matrix) of integers: \n");

    int rows  = 3;
    int cols = 4;
    int matrix[rows][cols];
    
    initializeMatrix(rows, cols, matrix);
    printMatrix(rows, cols, matrix);
    printf("the max number in the given matrix is %d.\n", findMaxInMatrix(rows, cols, matrix));

    printf("\nTask 2.2 calculates the sum of each row of matrix: \n");
    addrows(rows, cols, matrix);

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3
    int arr1[] = {8,1, 6, 10, 4, 5};
    int arr2[] = {8,1, 6, 10, 4, 5};
    int arr3[] = {8,1, 6, 10, 4, 5};
    int len = sizeof(arr1)/ sizeof(arr[0]);

    printf("Original array: {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr1[i]);
    }
    printf("}\n");

    bubbleSort(arr1, len);

    printf("BubbleSort array:  {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr1[i]);
    }
    printf("}\n");

    SelectionSort(arr2, len);

    printf("SelectionSort array:  {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr2[i]);
    }
    printf("}\n");

    
    SortFunction = bubbleSort;
    SortFunction(arr3,len);
    printf("function pointer array:  {");
    for (int i = 0; i < len; i++) {
        printf("%d ", arr3[i]);
    }
    printf("}\n");

    int x,y;
    char operation;

    //inputs
    printf("which Operation do you want to do: ");
    scanf("%c", &operation);
    printf("Enter 1st Number: ");
    scanf("%d", &x);
    printf("Enter 2nd Number: ");
    scanf("%d", &y);

    //part2
    switch (operation)
    {
    case '+':
        OperationFunction = add;
        printf("Addition of number is: %d\n", OperationFunction(x,y));
        break;

    case '-':
        OperationFunction = subtract;
        printf("Subtraction of number is: %d\n", OperationFunction(x,y));
        break;

    case '*':
        OperationFunction = multiply;
        printf("Multiplication of number is: %d\n", OperationFunction(x,y));
        break;// Part 6: Structures and Unions

    case '/':
        OperationFunction = divide;
        printf("Division of number is: %d\n", OperationFunction(x,y));
        break;
    
    default:
        printf("input operation is invalide.\n");
        break;
    }


    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2


    printf("\nTask 4.2: Generic Linked List\n");

    struct GenericNode* new_head = NULL;

    int test_array[] = {10,20,30};

    genericinsertAtBeginning(&new_head,&test_array[0],sizeof(test_array[0]));
    genericinsertAtBeginning(&new_head,&test_array[1],sizeof(test_array[0]));
    genericinsertAtBeginning(&new_head,&test_array[2],sizeof(test_array[0]));


    printf("Integer Linked list after inserting nodes: ");
    genericprintList(new_head,printInt);
    printf("\n");
    free(new_head);

    struct GenericNode* float_head = NULL;

    float test_array2[] = {10.5,20.3,30.1};

    genericinsertAtBeginning(&float_head,&test_array2[0],sizeof(test_array2[0]));
    genericinsertAtBeginning(&float_head,&test_array2[1],sizeof(test_array2[1]));
    genericinsertAtBeginning(&float_head,&test_array2[2],sizeof(test_array2[2]));


    printf("Float Linked list after inserting nodes: ");
    genericprintList(float_head,printFloat);
    printf("\n");
    free(float_head);
    

    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3
        int size = 5;
    int *memory = createDynamicArray(size); 
    int *starting_address = memory;
    
    for(int i=0; i<size; i++){
        *memory = i;
        memory += 1;
    }

    memory = starting_address;
    printf("before realloc array: ");
    for(int i=0; i<size; i++){
        printf("%d ", *memory);
        memory += 1;
    }
    printf("\n");

    // Extend the array
    int newSize = 10;
    extendArray(&starting_address, newSize);

    // Initialize the new elements
    memory = starting_address+size;
    for (int i = 5; i < newSize; i++) {
        *memory = i;
        memory += 1;
    }

    memory = starting_address;
    // Print the extended array
    printf("Extended array: ");
    for (int i = 0; i < newSize; i++) {
        printf("%d ", *memory);
        memory += 1;
    }
    printf("\n");

    memory = starting_address;
    free(memory);

    void *mem_address = allocateMemory(10);

    mem_ptr = mem_address;

    freeMemory(mem_address);
    mem_ptr = NULL;

    checkMemoryLeaks();

    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4

    struct Student student;

    inputStudentData(&student);

    printf("The average grade is: %f",calculateAverage(&student));

    printStudentInfo(&student);
  
    checkMemoryLeaks();
    printf("\n");

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3
    const char* filename = "student_data.txt";
    printf("Write into Stusent_data.txt\n");
    writeStudentToFile(&student, filename);

    //making a struct student and initialziing all of it to zero to read into it
    struct Student empty_student ;
    readStudentFromFile(&empty_student,filename);
    printf("Printing data read from the file\n");
    printf("Name: %s\n", empty_student.name);
    printf("id: %d\n", empty_student.id);
    printf("grade1: %.2f\n", empty_student.grades[0]);
    printf("grade2: %.2f\n", empty_student.grades[1]);
    printf("grade3: %.2f\n", empty_student.grades[2]);



    return 0;
}
