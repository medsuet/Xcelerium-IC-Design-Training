#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp = *a;
    *a = *b;
    *b = temp;
}

//following function takes pointer of array and reverse that array
void reverseArray(int *arr, int size) {
    int *temp_ptr = (arr + size) - 1;
    int i = 0;
    while (arr < temp_ptr) {
        swap(arr,temp_ptr);
        temp_ptr--;
        arr++;
    }
}

// Part 2: Pointers and Arrays
//following function takes no. of rows and columns and matrix pointer and make matrix elements using random function 
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    srand(time(NULL));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            *(*(matrix + i) + j) = rand() % 10;
        }
    }
}

//following function takes no. of rows and columns and matrix pointer and prints the matrix
void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ",*(*(matrix + i) + j));
        }
        printf("\n");
    }
}

//following function takes no. of rows and columns and matrix pointer and finds the maximum value in matrix
int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    int max = 0;
    int max_value = **(matrix);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (max_value < (**((matrix+i)+j))) {
                max_value = **((matrix+i)+j);
            }
        }

    }
    printf("max of matrix is %d",max);
}

// Part 3: Function Pointers
//following function takes array pointer and size of array and sort the array using bubble sort algorithm
void bubbleSort(int *arr, int size) {
    for (int i = 0; i<(size-1); i++) {
        for (int j = 0; j<(size-i-1); j++) {
            if (*(arr+j) > *(arr + (j + 1))) {
                swap((arr + j),(arr + j + 1)); 
            }
        }
    }
}

//following function takes array pointer and size of array and sort the array using selection sort algorithm
void selectionSort(int *arr, int size) {
    int min = 0;
    for (int i = 0; i < size - 1; i++){
        min = i;
        for (int j = i; j < size; j++) {
            if (*(arr+j) < *(arr + min)) {
                min = j;
            }
        }
        swap((arr+i),(arr+min));
    }
}

void (*SortFunction_a)(int*, int) = bubbleSort;
void (*SortFunction_b)(int*, int) = selectionSort;

// Calculator functions 
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

int (*addition)(int a, int b) = add;
int (*subtraction)(int a, int b) = subtract;
int (*multiplication)(int a, int b) = multiply;
int (*division)(int a, int b) = divide;

// Part 4: Linked List
struct Node {
    int data;
    struct Node* next;
};

//following function insert node at beginning of linked list
void insertAtBeginning(struct Node** head, int value) {
    struct Node* new_node = (struct Node*)malloc(sizeof(struct Node));
    new_node->data = value;
    new_node->next = *head;
    *head = new_node;
}
//following function delete node by matching value in linked list
void deleteByValue(struct Node** head, int value) {

    struct Node* temp = *head;
    struct Node* prev = NULL;
    if(temp != NULL && temp->data == value) {
        *head = temp->next;
        free(temp);
        return ;
    }
    while (temp !=NULL && temp->data !=value) {
        prev = temp;
        temp = temp->next;
    }
    if(temp == NULL) return;
    prev->next = temp->next;
    free(temp);
}

//following function prints the linked list
void printList(struct Node* head) {
    struct Node* temp = head;
    while(temp != NULL) { 
        printf("%d -> ", temp->data);
        temp = temp->next;
    }
    printf("NULL\n");
}

// Part 5: Dynamic Memory Allocation

//following function creats the array using dunamic memory allocation
int* createDynamicArray(int size) {
    int *arr_ptr = (int *)malloc(size * sizeof(int));
    return(arr_ptr);
}
//following function extend the existing array
void extendArray(int** arr, int* size, int newSize) {
    int *arr_ptr = (int *)realloc(arr,newSize * sizeof(int));
    free(arr_ptr);
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

//following function take input from user and make the student data 
void inputStudentData(struct Student* s) {
    printf("\nEnter name : ");
    scanf("%s",s->name);
    printf("Enter id : ");
    scanf("%d",&s->id);
    printf("Enter grades in sub 1 : ");
    scanf("%f",&s->grades[0]);
    printf("Enter grades in sub 2 : ");
    scanf("%f",&s->grades[1]);
    printf("Enter grades in sub 3 : ");
    scanf("%f",&s->grades[2]); 
}

//following function calculates the average of grades of a student
float calculateAverage(struct Student* s) {
    return ((s->grades[0] + s->grades[1] + s->grades[2]) / 3);
}

//following function prints the student data
void printStudentInfo(struct Student* s) {
    printf("\nName : %s",s->name);
    printf("\nID : %d",s->id);
    printf("\ngrades in sub 1 : %.2lf",s->grades[0]);
    printf("\ngrades in sub 2 : %.2lf",s->grades[1]);
    printf("\ngrades in sub 3 : %.2lf",s->grades[2]);
}


// Part 7: File I/O

//following function write the student data to the file
void writeStudentToFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename,"w");
    if(file == NULL) {
        printf("Error in file opening");
        exit(1);
    }
    fprintf(file,"Name : %s\n",s->name);
    fprintf(file,"ID : %d\n",s->id);
    fprintf(file,"grades in sub 1 : %.3f\n",s->grades[0]);
    fprintf(file,"grades in sub 2 : %.3f\n",s->grades[1]);
    fprintf(file,"grades in sub 3 : %.3f\n",s->grades[2]);
    fclose(file);
}

//following function read the student data from the file and make structure from data
void readStudentFromFile(struct Student* s, const char* filename) {
    FILE *file = fopen(filename,"r");
    if(file == NULL) {
        printf("Error in file opening");
    }
    fscanf(file, "Name : %s\n",s->name);
    fscanf(file, "ID : %d\n",&s->id);
    fscanf(file, "grades in sub 1 : %f\n",&s->grades[0]);
    fscanf(file, "grades in sub 2 : %f\n",&s->grades[1]);
    fscanf(file, "grades in sub 3 : %f\n",&s->grades[2]);
    fclose(file);
}

//following function takes student data and make the binary file of it  
void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "wb");
    if (file == NULL) {
        printf("Could not open file for writing.\n");
        return ;
    }
    fwrite(s, sizeof(struct Student), 1, file);
    fclose(file);
}

//following code takes binary file and makes structure from the binary file
void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Could not open file for reading.\n");
        return;
    }
    struct University uni;
    fread(s, sizeof(struct Student), 1, file);
    fclose(file);
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
    
    //swaps the values using pointers
    int x = 10;
    int *ptr = &x;
    printf("value with direct access : %d\n",x);
    printf("value with pointer : %d\n",*ptr);

    //1.2
    int a = 10;
    int b = 20;
    int *ptr1 = &a;
    int *ptr2 = &b;

    printf("previous value of b : %d\n",*ptr1);
    printf("previous value of b : %d\n",*ptr2);

    //swaping two integers with swaping function using pointers
    swap(ptr1,ptr2);
    printf("new value of a : %d\n",*ptr1);
    printf("new value of b : %d\n",*ptr2);

    //1.3
    //printing_array
    int arr[10]={0,1,2,3,4,5,6,7,8,9};
    int *ptr_arr = arr;
    for (int i=0; i<(sizeof(arr)/sizeof(arr[0])); i++) {
        printf("%d ",*(ptr_arr + i));
    }
    printf("\n");

    //printing_sum_of_array
    int temp = 0;
    for (int i=0; i<(sizeof(arr)/sizeof(arr[0])); i++) {
        temp = *(ptr_arr + i) + temp;
    }
    printf("sum of array is : %d\n",temp);
    reverseArray(ptr_arr,(sizeof(arr)/sizeof(arr[0])));

    //printing_reverse_array
    for (int i=0; i<(sizeof(arr)/sizeof(arr[0])); i++) {
	    printf("%d ",*(ptr_arr + i));
    }
    printf("");

    // Part 2: Pointers and Arrays
    printf("\n \nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2

    int rows = 3;
    int cols = 3;
    int matrix[rows][cols];
    int (*matrix_ptr)[cols] = matrix;
    //calling function that 
    initializeMatrix(rows, cols, matrix_ptr);

    printMatrix(rows,cols,matrix);

    findMaxInMatrix(rows, cols, matrix);
    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3
    //3.1
    //sorting array
    int array[10] = {6,5,7,4,2,7,9,0,3,1};
    int *array_ptr = array;
    int size_of_array = sizeof(arr)/sizeof(arr[0]);
    //printing_unsorted_array
    printf("unsorted array : ");
    for (int i=0; i<(sizeof(array)/sizeof(array[0])); i++) {
        printf("%d ",*(array_ptr + i));
    }
    printf("\n");

    //sorting array with bubble sort
    bubbleSort(array_ptr,size_of_array);
    //printing sorted array sort with bubble sort 
    printf("sorted array by bubble sort: ");
    for (int i=0; i<(sizeof(array)/sizeof(array[0])); i++) {
        printf("%d ",*(array_ptr + i));
    }
    //sorting array with selection sort
    int a_array[10] = {9,6,4,8,6,4,5,1,0,1};
    int *a_array_ptr = a_array;
    int size_of_a_array = sizeof(a_array)/sizeof(a_array[0]);
    //sorting
    selectionSort(a_array_ptr,size_of_a_array);
    //printing_sorted_array
    printf("\nsorted array by selection sort: ");
    for (int i=0; i<(sizeof(a_array)/sizeof(a_array[0])); i++) {
        printf("%d ",*(a_array_ptr + i));
    }

    //3.2
    //selecting_sorting_algorithm
    int a_arr1[10] = {9,6,4,8,6,4,5,1,0,1};
    int *a_arr1_ptr = a_arr1;
    int size_of_a_arr1 = sizeof(a_arr1)/sizeof(a_arr1[0]);
    SortFunction_a (a_arr1_ptr,size_of_a_arr1);
    //printing sorted array using selection sort
    printf("\nsorted array by selection sort: ");
    for (int i=0; i<(size_of_a_arr1); i++) {
        printf("%d ",*(a_arr1_ptr + i));
    }

    //3.3

    //simple calculator
    int r = 10;
    int s = 20;
    printf("Addition using ptr : %d",addition(r,s));
    subtraction(a,b);
    multiplication(a,b);
    division(a,b);

    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    
    struct Node* head  = NULL;

    //inserting node at beginning of linked list
    insertAtBeginning(&head,32);
    insertAtBeginning(&head,69);
    printList(head);
    //deleting node by value
    deleteByValue(&head,32);
    printList(head);


    Part 5: Dynamic Memory Allocation
    printf("\nPart 5: Dynamic Memory Allocation\n");
// 
//    take inputs from user
    // int size = 3;
    // int newsize = 10;
    // int *pointer = createDynamicArray(size);
    // for (int i=0; i<size; i++) {
        // printf("Enter [%d] value : ",i);
        // scanf("%d",&(*(pointer+i)));
    // }
    //calculates and print sum and average of elements
    // int sum = 0;
    // for (int j=0; j<size; j++) {
        // sum = *(pointer+j) + sum;
    // }
// 
    // printf("Sum of array : %d",sum);
    // printf("\nsize : %d",size);
    // printf("\nAverage of array : %f",(float)sum / size);
// 
    //extending array
    // int *ptttr = createDynamicArray(newsize);
    // for (int i=0; i<(newsize-size); i++) {
        // printf("Enter [%d] value : ",i);
        // scanf("%d",&(*(pointer+i)));
    // }



    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");

    
    //following code is of make structure of students and put values by assinging 
    //struct Student student;
    //snprintf(student.name, sizeof(student.name), "John");
    //student.id = 12345;
    //student.grades[0] = 2.5;
    //student.grades[1] = 3.0;
    //student.grades[2] = 3.5;

    //following code is of make structure of students and put values by user input
    //printf("\ndata of student");
    //printf("\nname : %s",student.name);
    //printf("\nid : %d",student.id);
    //printf("\ngrades in sub1 : %f",student.grades[0]);
    //printf("\ngrades in sub2 : %f",student.grades[1]);
    //printf("\ngrades in sub3 : %f",student.grades[2]);

    //making student structure
    struct Student student1;
    struct Student student2;
    struct Student student3;

    //input student data
    inputStudentData(&student1);
    inputStudentData(&student2);
    inputStudentData(&student3);

    //printing average
    //printf("Average : %f\n",calculateAverage(&student12));
    //printing student info
    //printStudentInfo(&student1);
    //printStudentInfo(&student2);
    //printStudentInfo(&student3);
    int no_of_students = 3;
    struct Department* EE = (struct Department*)malloc(no_of_students*(sizeof(struct Department)));

    EE[0] = (struct Department){"EE", &student1, no_of_students};
    EE[1] = (struct Department){"EE", &student2, no_of_students};
    EE[2] = (struct Department){"EE", &student3, no_of_students};
    for (int i = 0; i < no_of_students; i++) {
        printf("\nDepartment: %s, Student Name: %s, Number of Students: %d\n", EE[i].name, EE[i].students->name, EE[i].numStudents);
    }
    struct University UET = {"UET LHR",EE,1};
    printf("\nUniversity name : %s", UET.name);
    printf("\nNo. of departments : %d",UET.numDepartments);  
    printf("\nDepartment name : %s",UET.departments->name);

    free(EE);

    //struct University UET = (struct UET)malloc(1*(sizeof(struct University)));

    union Data data_type;

    data_type.i=10;
    printf("\ninteger data type : %d",data_type.i);
    data_type.f=2.5;
    printf("\nfloat data type : %f",data_type.f);
    data_type.c='H';
    printf("\nCharacter data type : %c",data_type.c);

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3

    const char* filename = "student.txt";
    const char* binary_filename = "student_binary.bin";
    //writing student data to file
    writeStudentToFile(&student1,filename);

    //reading student data from file and make student data
    struct Student student_from_file;
    readStudentFromFile(&student_from_file,filename);
    printf("Name : %s\n",student_from_file.name);
    printf("ID : %d\n",student_from_file.id);
    printf("grades in sub 1 : %.2f\n",student_from_file.grades[0]);
    printf("grades in sub 2 : %.2f\n",student_from_file.grades[1]);
    printf("grades in sub 3 : %.2f\n",student_from_file.grades[2]);

    //writing student data to binary file
    writeStudentToBinaryFile(&student1,binary_filename);

    //reading binary file and make student data
    struct Student student_from_file_bin;
    readStudentFromBinaryFile(&student_from_file_bin,binary_filename);
    
    printStudentInfo(&student_from_file_bin);

    //checkMemoryLeaks(8);

    return 0;
}
