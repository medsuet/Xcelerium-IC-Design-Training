#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    //swapping the function using temp variable
    int temp;
    temp = *a;
    *a   = *b;
    *b   =  temp;
    
}
void reverseArray(int *arr, int size) {
    //reversing the array using two pointers,one at first and one at last element of array.
    //and using my own swap functon for swapping
    int *second_pointer = arr + size-1;
    while ( second_pointer > arr){
        swap(arr,second_pointer);
        arr++;
        second_pointer--;
    }

}

    // Part 2: Pointers and Arrays
    //initialising the matrix, using two for loops and then using rand function for random elements.
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    for(int i=0; i<rows;i++){
        for(int j=0; j<cols;j++){
            *(*(matrix+i)+j) = rand() % 100;
        }
    }
    
}
    //printing the matrix.
void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    for(int i = 0;i<rows;i++){
        for(int j =0;j<cols;j++){
            printf(" %d ",*(*(matrix+i)+j));
        }
        printf("\n");
    }
    
}
    // definig a variable name largest and initialising it to 0,the check if any element of matrix is greater
    //than the largest if yes then updating largest.
int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    int largest = 0;
     for(int i = 0;i<rows;i++){
        for(int j =0;j<cols;j++){
            if(*(*(matrix+i)+j) > largest)
            largest = *(*(matrix+i)+j);
        }
}
    return largest;
}
    // making an array name rows_sum and initialising its element to zero,then summing the rows.
void SumofRows(int matrix[3][4],int rows_sum[3]){
    for(int i =0; i<3;i++){
        rows_sum[i] = 0;
        for(int j=0;j<4;j++){
            rows_sum[i]= rows_sum[i] + matrix[i][j];
}
    }
    //now printing
    printf("rows sum is:\n");
    for(int i = 0;i<3;i++){
            printf(" %d ",rows_sum[i]);
        }
    printf("\n");
    }
    

   // Part 3: Function Pointers
   //
void bubbleSort(int *arr, int size) {
    int temp;
    for(int i=0; i<size-1;i++){
        for(int j=0;j<(size -i -1);j++){
            if(*(arr+j)> *(arr+j+1))
               {
                temp = *(arr+j);
                *(arr+j)= *(arr+j+1);
                *(arr+j+1)= temp;
               }
         }
    }
    for(int i = 0;i<size;i++){
            printf(" %d ",*(arr + i));
        }
    printf("\n");

}

void selectionSort(int *arr, int size) {
    int min_index;
    int temp;
    for(int i =0;(i<size-1);i++){
        min_index = i;
        for(int j=i+1;j<size;j++){
            if (*(arr+j)> *(arr + min_index))
               min_index = j;
             if (min_index != i) {
            temp = *(arr + min_index);
            *(arr + min_index) = *(arr + j);
            *(arr + j) = temp;
           }
        }
    }
    for(int i = 0;i<size;i++){
            printf(" %d ",*(arr + i));
        }
    printf("\n");
    

}


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
    //we will first allocate memory for new node
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
     // Set the data and next pointer of the new node
    newNode->data = value;
    newNode->next = *head;
    
    // Update the head pointer to point to the new node
    *head = newNode;
}

void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
    // Store head node
    struct Node* temp = *head;
    struct Node* prev = NULL;
    
    // If the head node itself holds the value to be deleted
    if (temp != NULL && temp->data == value) {
        *head = temp->next; // Change head
        free(temp);         // Free old head
        return;
    }
    
    // Search for the value to be deleted
    while (temp != NULL && temp->data != value) {
        prev = temp;
        temp = temp->next;
    }
    
    // If value was not present in the list
    if (temp == NULL) return;
    
    // Unlink the node from the list
    prev->next = temp->next;
    
    free(temp);
     // Free memory
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

   // Part 5: Dynamic Memory Allocation
   // Allocate memory for an array of integers
int* createDynamicArray(int size) {
    int *array = (int *)malloc(size * sizeof(int));
    if (array == NULL) {
        printf("Memory allocation failed!\n");
        exit(1);
    }
    return array;
}

    //array extend
int* arrayExtend(int* array,int size,int new_size){
    int* new_array = (int*)realloc(array,new_size*sizeof(int));
    if ( new_array == NULL)
       { printf("reallocation failed\n");
        exit(1);
    }
    return new_array;
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
    
    //struct for student
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
    printf("\nENter name:");
    scanf("%s",s->name);
    printf("ENter id:");
    scanf("%d",&s->id);
    printf("Enter grade in sub1 :");
    scanf("%f",&s->grades[0]);
    printf("Enter grade in sub2:");
    scanf("%f",&s->grades[1]);
    printf("Enter grade in sub3 :");
    scanf("%f",&s->grades[2]); 
}

float calculateAverage(struct Student* s) {
    float sum = 0;
    for (int i = 0; i < 3; i++) {
        sum += s->grades[i];
    }
    return sum / 3;  // Return the average of the three grades
}

void printStudentInfo(struct Student* s) {
    printf("Student Name: %s\n", s->name);
    printf("Student ID: %d\n", s->id);
    printf("Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
    printf("Average Grade: %.2f\n", calculateAverage(s));
}

// Part 7: File I/O
// using foden to open the file in "write mode" and using fprintf to writing in file
void writeStudentToFile(struct Student* s, const char* filename) {
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
//opening file in read mode and using fscanf to read from file
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
      FILE *file = fopen(filename, "wb");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }
    fwrite(s, sizeof(struct Student), 1, file);
    fclose(file);
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
     FILE *file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Error opening file!\n");
        exit(1);
    }
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

    // Task 1.1
    int x     = 10;
    int *ptr  = &x;
    printf("the value of variable using direct access is %d\n",x);
    printf("the value of variable using pointer is %d\n",*ptr);
    //modyfying value now
    *ptr      = 20;
    printf("modified value is %d\n",x);
  

    //task 1.2: swapping using pointer
    int num1  = 10;
    int num2  = 20;
    int *ptr1 = &num1;
    int *ptr2 = &num2;
    swap(ptr1,ptr2);
    printf("the value of num1 is %d and value of num2 is %d\n",num1,num2);


    //task 1.3: creating array of integers
    int array[9] = {0,1,2,3,4,5,6,7,8};
    int *ptr_array = array;
    for(int i = 0;i< sizeof(array)/sizeof(array[0]);i++){
        printf("%d",*(ptr_array + i));
 }
     printf("\n");
 

    // sum of all element
    int sum_array = 0;
    for(int i = 0;i< sizeof(array)/sizeof(array[0]);i++){
        sum_array = sum_array + *(ptr_array + i);
    }
    printf("sum of array is %d\n", sum_array);


    // reversin array
    printf("reversed array is:\n");
    reverseArray(ptr_array,sizeof(array)/sizeof(array[0]));
     for(int i = 0;i< sizeof(array)/sizeof(array[0]);i++){
        printf("%d",*(ptr_array + i));
 }
    printf("\n");


    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    //2.1 Initializing matrix

    int rows = 2;
    int cols =  3;
    int matrix[rows][cols];

    int (*prt_mat)[cols] = matrix;

    int matrix_2[3][4] = {
        {1, 2, 3, 4},
        {5, 6, 7, 8},
        {9, 10, 11, 12}
    };
    int rows_sum[3];
   
    initializeMatrix(rows, cols, prt_mat);

    //printing matrix
    printMatrix(rows,cols,prt_mat);

    //finding largest element in matrix
    printf("the largest element is %d\n",findMaxInMatrix(rows,cols,prt_mat));

    // sum of rows
    SumofRows(matrix_2,rows_sum);
    
    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");

    //bubble sort
    int arr_b[11]= {2,3,9,1,13,18,15,21,28,1,19};
    int *ptr_arr = arr_b;
    int size_b   = 11;
    printf("array sorted with bubble sort is:\n");
    bubbleSort(ptr_arr,size_b);
   

    //selection sort
    printf("array sorted with selection sort is:\n");
    selectionSort(ptr_arr,size_b);
 

    //function pointer for sorting algorithm
    printf("using function pointer\n");
    void (*SortFunction1)(int*, int) = bubbleSort;
    SortFunction1(ptr_arr,size_b);
    void (*SortFunction2)(int*, int) = selectionSort;
    SortFunction2(ptr_arr,size_b);


    //Calculator using function pointer
    int (*p_add)(int,int) = add;
    int (*p_sub)(int,int) = subtract;
    int (*p_mul)(int,int) = multiply;
    int (*p_div)(int,int) = divide;
    printf("%d\n",p_add(2,3));
    printf("%d\n",p_sub(8,3));
    printf("%d\n",p_mul(2,3));
    printf("%d\n",p_div(16,8));
    

    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2
    struct Node* head = NULL; // Initialize the list as empty
    
    // Insert nodes at the beginning
    insertAtBeginning(&head, 10);
    insertAtBeginning(&head, 20);
    insertAtBeginning(&head, 30);
    
    // Print the list
    printf("Linked list: ");
    printList(head);
    
    // Delete a node by value
    deleteByValue(&head, 20);
    
    // Print the list after deletion
    printf("Linked list after deletion: ");
    printList(head);








    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    int size_of_array;
    int new_sizee;
    int *array_part_5;
    int sum =0;
    float average;
    scanf("%d",&size_of_array);
    array_part_5 = createDynamicArray(size_of_array);
    printf("Enter %d elements:\n", size_of_array);
    for(int i = 0; i< size_of_array;i++){
        printf("Element %d:",i+1);
        scanf("%d",&array_part_5[i]);
        sum += array_part_5[i];
    }


     // Calculate the average
    average = (float)sum / size_of_array;

    // Print the sum and average of the elements
    printf("Sum of elements: %d\n", sum);
    printf("Average of elements: %.2f\n", average);

    //asking for new size
    printf("tell the new size\n");
    scanf("%d",&new_sizee);
    array_part_5 = arrayExtend(array_part_5,size_of_array,new_sizee);
    printf("Enter new elements\n");
    for(int i= size_of_array;i < new_sizee;i++){
        printf("Element %d: ", i + 1);
        scanf("%d", &array_part_5[i]);
        sum += array_part_5[i];
    }
    average = (float)sum / new_sizee;
    // Print the new sum and average of the elements
    printf("New sum of elements: %d\n", sum);
    printf("New average of elements: %.2f\n", average);

    // Free the allocated memory
    free(array_part_5);


    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // making a struct name student
    struct Student student;
    // Input data for the student
    inputStudentData(&student);

    // Print the student's information
    printStudentInfo(&student);

    //task 6.3
    //first making 3 variables of students
    struct Student student1;
    struct Student student2;
    struct Student student3;

    //now taking information about these students using the function we made
    inputStudentData(&student1);
    inputStudentData(&student2);
    inputStudentData(&student3);

    int number_of_students = 3;

    //now initialzing a variable for department data type
    struct Department* EE = (struct Department*)malloc(number_of_students*(sizeof(struct Department)));
    EE[0] = (struct Department){"EE",&student1,1};
    EE[1] = (struct Department){"me",&student2,2};
    EE[2] = (struct Department){"EE",&student3,3};
    for(int i =0; i < 3; i++){
        printf("Department name:%s, name of students: %s, number of student: %d",EE[i].name, EE[i].students->name, EE[i].numStudents);

    }  
    // now declaring univeristy
    struct University UET = {"UET",EE,1};
    printf("\nname of university %s\n",UET.name);
    printf("number of department %d\n",UET.numDepartments);
    printf("depatment name %s \n", UET.departments->name);

    //using union now, in union different variable shares same memory location, but cant access them at the same time
    // Create a union variable
    union Data data;

    // Store an integer
    data.i = 10;
    printf("data.i = %d\n", data.i);

    // Store a float
    data.f = 220.5;
    printf("data.f = %f\n", data.f);

    // Store a character
    data.c = 'A';
    printf("data.c = %c\n", data.c);

    // Note: Only the last stored value is valid. 
    // Accessing other values will result in unexpected behavior.
    printf("After storing char 'A':\n");
    printf("data.i = %d\n", data.i); // This may not be valid
    printf("data.f = %f\n", data.f); // This may not be valid


    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    const char* filename = "student.txt";
    writeStudentToFile(&student, filename);
    //now for binary format
    const char* filename_bin = "student.bin";
    writeStudentToBinaryFile(&student, filename_bin);

    //making a struct student and initialziing all of it to zero to read into it
    struct Student empty_student ;
    //making a struct student for bin
    struct Student empty_student_bin;
    readStudentFromFile(&empty_student,filename);
    printf("\nprinting data read from the file\n");
    printf("Name: %s\n", empty_student.name);
    printf("id: %d\n", empty_student.id);
    printf("grade: %.2f\n", empty_student.grades[0]);
    printf("grade: %.2f\n", empty_student.grades[1]);
    printf("grade./: %.2f\n", empty_student.grades[2]);

    readStudentFromBinaryFile(&empty_student_bin,filename_bin);
    printf("\nprinting data read from the bin_file\n");
    printf("Name: %s\n", empty_student_bin.name);
    printf("id: %d\n", empty_student_bin.id);
    printf("grade: %.2f\n", empty_student_bin.grades[0]);
    printf("grade: %.2f\n", empty_student_bin.grades[1]);
    printf("grade: %.2f\n", empty_student_bin.grades[2]);
    

    return 0;
}
