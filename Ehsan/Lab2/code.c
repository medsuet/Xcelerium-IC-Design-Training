#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic

//following function swaps the values of variables by swaping their pointers
void swap(int *a, int *b) {
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
    int max_value = *(*matrix);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (max_value < (*(*(matrix+i)+j))) {
                max_value = *(*(matrix+i)+j);
            }
        }
    }
    return max_value;
}

//following function calculates the sum of each row of matrix
void sumOfEachRow(int rows, int cols, int arr[rows][cols], int result[]) {
    for(int i = 0; i < rows; i++) {
        result[i] = 0;
        for(int j = 0; j < cols; j++) {
            result[i] += arr[i][j];
        }
    }
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

union Data {
    int i;
    float f;
    char c;
}; 

struct Node {
    union Data data;
    struct Node* next;
};

//following function insert node at beginning of linked list
void insertAtBeginning(struct Node** head, union Data data) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    if (newNode == NULL){
        printf("Memory allocation Failed\n");
        return;
    } 
    if (data.i) {
        newNode->data.i = data.i;
    } else if (data.f) {
        newNode->data.f = data.f;
    } else if (data.c) {
        newNode->data.c = data.c;
    } 
    newNode->next = *head;
    *head = newNode;
}

//following function delete node by matching value in linked list
void deleteByValue(struct Node** head, union Data value) {
    struct Node* curr = *head;
    struct Node* prev = NULL;

    while (curr != NULL) {
        //checking if the current node's data matches the value
        if ((curr->data.i == value.i) || (curr->data.f == value.f) || (curr->data.c == value.c)) {
            //if the node to be deleted is the head node
            if (prev == NULL) {
                *head = curr->next;
            } else {
                prev->next = curr->next;
            }
            free(curr);
            return; 
        }
        prev = curr;
        curr = curr->next;
    }
}


//following function prints the linked list
void printList(struct Node* head) {
    struct Node* temp = head;
    while(temp != NULL) { 
        if (temp->data.i) {printf("%d -> ", temp->data.i);}
        else if(temp->data.f) {printf("%f -> ", temp->data.f);}
        else if (temp->data.c) {printf("%c -> ", temp->data.c);}
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
    int *arr_ptr = (int *)realloc(*arr,newSize * sizeof(int));
    *arr = arr_ptr;
}
//following function allocate memory of give size and make pointer which points any data type
void* allocateMemory(size_t size) {
    void* ptr = malloc(size);
    return ptr;   
}
//following function free memory by freeing pointer and make pointer equals null
void freeMemory(void* ptr) {
    if (ptr != NULL) {
        free(ptr);
        ptr = NULL;
    }
}

void checkMemoryLeaks(int *ptr, int allocated_size) {
    // TODO: Check for memory leaks
    for (int i = 0; i < allocated_size; i++) {
        
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
        return;
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
        return;
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
        return;
    }
    fwrite(s, sizeof(struct Student), 1, file);
    fclose(file);
}

//following code takes binary file and makes structure from the binary file
void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Could not open file for reading.\n");
        return;
    }
    fread(s, sizeof(struct Student), 1, file);
    fclose(file);
}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    FILE *line = fopen(logfile , "r");
    if (line == NULL) {
        printf("Could not open the log file");
        return;
    }

}

void displayLog(const char* logfile) {
    //open the log file for reading
    FILE *file = fopen(logfile, "r");
    if (file == NULL) {
        printf("Could not open the log file\n");
        return;
    }
    char buffer[256];  //buffer to hold each line
    //read and display each line from the log file
    while (fgets(buffer, sizeof(buffer), file) != NULL) {
        printf("%s", buffer);
    }
    fclose(file);
}


int main() {
    srand(time(NULL));

    // Part 1: Pointer Basics and Arithmetic
    printf("\nPart 1: Pointer Basics and Arithmetic\n\n");
    
    //swaps the values using pointers
    int x = 10;
    int *ptr = &x;
    printf("value with direct access : %d\n",x);
    printf("value with pointer : %d\n",*ptr);

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

    //printing_array using pointer
    int arr[10]={0,1,2,3,4,5,6,7,8,9};
    int *ptr_arr = arr;
    for (int i=0; i<(sizeof(arr)/sizeof(arr[0])); i++) {
        printf("%d ",*(ptr_arr + i));
    }
    printf("\n");

    //printing_sum_of_array
    int sum = 0;
    for (int i=0; i<(sizeof(arr)/sizeof(arr[0])); i++) {
        sum = *(ptr_arr + i) + sum;
    }
    printf("sum of array is : %d\n",sum);

    //reversing array using pointers
    reverseArray(ptr_arr,(sizeof(arr)/sizeof(arr[0])));
    //printing_reversed_array
    for (int i=0; i<(sizeof(arr)/sizeof(arr[0])); i++) {
	    printf("%d ",*(ptr_arr + i));
    }

    // Part 2: Pointers and Arrays
    printf("\n \nPart 2: Pointers and Arrays\n\n");

    int rows = 3;
    int cols = 3;
    int matrix[rows][cols];
    int (*matrix_ptr)[cols] = matrix;

    //initializing the matrix 
    initializeMatrix(rows, cols, matrix_ptr);

    //printing the matrix
    printMatrix(rows,cols,matrix_ptr);

    //finding the maximum value in the matrix using pointers 
    printf("Max value in matrix is %d",findMaxInMatrix(rows, cols, matrix_ptr));

    //calculating sum of each row of matrix
    int sumOfRows[rows];

    sumOfEachRow(rows, cols, matrix, sumOfRows);

    for(int i = 0; i < rows; i++) {
        printf("\nsum of row %d : %d", i, sumOfRows[i]);
    }

    // Part 3: Function Pointers
    printf("\n\nPart 3: Function Pointers\n\n");

    //sorting array with bubble sort
    int array[10] = {6,5,7,4,2,7,9,0,3,1};
    int *array_ptr = array;
    int size_of_array = sizeof(array)/sizeof(array[0]);
    //printing_unsorted_array
    printf("unsorted array : ");
    for (int i=0; i<size_of_array; i++) {
        printf("%d ",*(array_ptr + i));
    }
    printf("\n");

    //sorting array with bubble sort
    bubbleSort(array_ptr,size_of_array);

    //printing sorted array sorted with bubble sort 
    printf("sorted array by bubble sort: ");
    for (int i=0; i<size_of_array; i++) {
        printf("%d ",*(array_ptr + i));
    }

    //sorting array with selection sort
    int a_array[10] = {9,6,4,8,6,4,5,1,0,1};
    int *a_array_ptr = a_array;
    int size_of_a_array = sizeof(a_array)/sizeof(a_array[0]);
    
    //sorting array with selection sort
    selectionSort(a_array_ptr,size_of_a_array);

    //printing_sorted_array sorted with selection sort
    printf("\nsorted array by selection sort: ");
    for (int i=0; i<size_of_a_array; i++) {
        printf("%d ",*(a_array_ptr + i));
    }

    //selecting sorting using function pointer 
    int a_arr1[10] = {9,6,4,8,6,4,5,1,0,1};
    int *a_arr1_ptr = a_arr1;
    int size_of_a_arr1 = sizeof(a_arr1)/sizeof(a_arr1[0]);
    SortFunction_a (a_arr1_ptr,size_of_a_arr1);

    //printing sorted array using selection sort with function pointers
    printf("\nsorted array by selection sort using function pointer: ");
    for (int i=0; i<(size_of_a_arr1); i++) {
        printf("%d ",*(a_arr1_ptr + i));
    }

    //simple calculator using function pointer
    int r = 20;
    int s = 20;
    printf("\nAddition using function ptr of %d and %d : %d",r,s,addition(r,s));
    printf("\nSubtraction using function ptr of %d and %d : %d",r,s,subtraction(r,s));
    printf("\nMultiplition using function ptr of %d and %d : %d",r,s,multiplication(r,s));
    printf("\nDivision using function ptr of %d and %d : %d",r,s,division(r,s));

    // Part 4: Advanced Challenge
    printf("\n\nPart 4: Advanced Challenge\n\n");
    
    //linked list
    //making head node
    //struct Node* head  = NULL;
    //inserting node at beginning of linked list
    //insertAtBeginning(&head,32);
    //insertAtBeginning(&head,69);
    //printList(head);
    //deleting node by value
    //deleteByValue(&head,32);
    //printing linked list
    //printList(head);
    //free(head);

    //generic linked list
    struct Node* head = NULL;
    union Data n1, n2, n3,n4;
    n1.i = 3;
    n2.f = 3.76;
    n3.c = 'A';
    n4.i = 7 ;
    insertAtBeginning(&head,n1);
    insertAtBeginning(&head,n2);
    insertAtBeginning(&head,n3);
    insertAtBeginning(&head,n4);
    printList(head);     
    deleteByValue(&head,n2);
    printList(head);


    //Part 5: Dynamic Memory Allocation
    printf("\nPart 5: Dynamic Memory Allocation\n\n");
    
    int size;
    printf("Enter size of array : ");
    scanf("%d",&size);
    int *pointer = createDynamicArray(size);
    //initialing the array elements
    for (int i=0; i<size; i++) {
        printf("Enter [%d] value : ",i);
        scanf("%d",&(*(pointer+i)));
    }

    //calculates sum of elements
    int sum_array = 0;
    for (int j=0; j<size; j++) {
        sum_array = *(pointer+j) + sum_array;
    }
    //printing sum and average of array elements
    printf("Sum of array : %d",sum_array);
    printf("\nsize : %d",size);
    printf("\nAverage of array : %f",(float)sum_array / size);

    //printing allocated array
    printf("\nPrinting allocated array : "); 
    for (int q=0; q<size; q++) {
        printf("%d ",*(pointer+q));
    }

    //extending array
    int new_size;
    printf("\nEnter new size of array : ");
    scanf("%d",&new_size);
    extendArray(&pointer,&size,new_size);
    //initialing the extended array elements
    for (int i=size; i<new_size; i++) {
        printf("Enter [%d] value : ",i);
        scanf("%d",&(*(pointer+i)));
    }

    //printing extended array
    printf("Printing extended array : "); 
    for (int y=0; y<new_size; y++) {
        printf("%d ",*(pointer+y));
    }
    //freeing pointer
    freeMemory(pointer);

    // Part 6: Structures and Unions
    printf("\n\nPart 6: Structures and Unions\n");

    //making student structure
    struct Student student1;
    struct Student student2;
    struct Student student3;

    //making student data with user input
    inputStudentData(&student1);
    inputStudentData(&student2);
    inputStudentData(&student3);

    //making departments data
    //taking 2 departments in university, 2 students in department1 and 1 student in department 2
    struct Department department1;
    int noOfStudentsInDepartment1 = 2;
    strcpy (department1.name,"EE");
    department1.numStudents = noOfStudentsInDepartment1;
    department1.students = (struct Student*) malloc(noOfStudentsInDepartment1 * sizeof(struct Student));
    department1.students[0] = student1;
    department1.students[1] = student2;

    int noOfStudentsInDepartment2 = 1;
    struct Department department2;
    strcpy (department2.name,"ME");
    department2.numStudents = noOfStudentsInDepartment2;
    department2.students = (struct Student*) malloc(noOfStudentsInDepartment2 * sizeof(struct Student));
    department2.students[0] = student3;

    //making university data
    struct University university;
    int noOfDepartmentInUniversity = 2;
    strcpy(university.name,"UET, LHR");
    university.numDepartments = 2;
    university.departments = (struct Department*) malloc(noOfDepartmentInUniversity*sizeof(struct Department));
    university.departments[0] = department1;
    university.departments[1] = department2;

    //printing university data
    printf("\nname of university : %s", university.name);
    printf("\nno. of departments in %s : %d ",university.name,university.numDepartments);
    printf("\nno. of students in %s : %d ",university.departments[0].name,university.departments[0].numStudents);
    printf("\nno. of students in %s : %d ",university.departments[1].name,university.departments[1].numStudents);

    //freeing pointers
    freeMemory(university.departments);
    freeMemory(department1.students);
    freeMemory(department2.students);

    union Data data_type;
    data_type.i=10;
    printf("\n\ninteger data type : %d",data_type.i);
    data_type.f=2.5;
    printf("\nfloat data type : %f",data_type.f);
    data_type.c='H';
    printf("\nCharacter data type : %c",data_type.c);

    // Part 7: File I/O
    printf("\n\nPart 7: File I/O\n");

    const char* filename = "student.txt";
    const char* binary_filename = "student_binary.bin";

    //writing student data to file
    writeStudentToFile(&student1,filename);

    //reading student data from file and make student data
    struct Student student_from_file;
    readStudentFromFile(&student_from_file,filename);
    printStudentInfo(&student_from_file);
    //writing student data to binary file
    writeStudentToBinaryFile(&student1,binary_filename);

    //reading binary file and make student data
    struct Student student_from_file_bin;
    readStudentFromBinaryFile(&student_from_file_bin,binary_filename);
    
    //printing student info that is read by binary file
    printStudentInfo(&student_from_file_bin);

    //display log file
    const char* logfile = "logfile.log";
    displayLog(logfile);
    //checkMemoryLeaks(8);
    printf("\n");
    return 0;
}
