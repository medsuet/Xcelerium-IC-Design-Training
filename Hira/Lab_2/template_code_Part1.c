============================================================================
 * Filename:    template_code_Part1.c
 * Description: File consists of codes based on advanced concepts of C language
 * Author:      Hira Firdous
 * Date:        7/2024
 * ===========================================================================
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdbool.h>
int memory_allocated=0;                                                 //A variable for keeping track of memory allocation

//Part 1.1 Basic Pointer:
void basic(){
    /*variables will be integer and pointer.*/
	int x=13;
	int *ptr=&x;
	printf("direct access value: %d \nThrough pointer value: %d\n",x, *ptr);
	*ptr=1;
	printf("assigning new value to it:%d \n",*ptr);
}


// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    /*  arguments: two integer arguments
        We have to swap the value with help of pointer
        Swapping technique will be same but with integers.
        output: swap those integers values.
        */
	int temp = *a; 
    	*a = *b;
    	*b = temp;
	
}

int sum(int *arr, int size) {
    /*arguments: an array and size of array 
      Logic:
            Sum of all the elements:
            loop will be same but with the addition of a sum variable
      Output:

        */
    int *temp_ptr = arr;
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += *(temp_ptr + i);
    }
    return sum;
}

void print_array(int *arr, int size){
    /*argumments: array and its size 
        Printing all the elements of the array.
        printf("This is the array\n");
    */
    for (int i=0; i<size;i++){
        printf("%d ",*(arr+i));
    }
    printf("\n");

}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    /*  Arguments reverse the array
        LOGIC:
            - Swapping until i(loop_variable) becomes equal to Size
            - Declaring an intermediate variable.
            - *arr+i= value from left
            - *arr+size-1= value from right
        array is reversed
        */             
        int temp_size=size;
        for (int i=0; i<temp_size;i++){
            swap(arr+i,arr+temp_size-1);
        temp_size--;
        }
        printf("\nThis is the reversed array \n");
        print_array(arr,size);
}

int max_in_array(int *arr,int size){
	/*Takes an array as an argumment and gives
	  maximum number from it.*/
	int max_num=arr[0];
	for (int i=0;i<size;i++){
		if(arr[i]>max_num){
			max_num=arr[i];
		    }
	    }
	return max_num;
	}


// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    /*
    //Arguments: no. of rows,columns and matrix pointer
    // outer loop will be responsible for columns
    // inner loop will be responsible for filling the columns
    */
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 101; // Random value between 0 and 100
        }
    } 
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    //: Print the matrix
    for (int i = 0; i < rows; i++) {
        print_array(matrix[i],cols);
        printf("\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    /* Find and return the maximum element in the matrix
        -iterate whole matrix row by row
         -Change the value 
    */
    int max_element=0;
    int temp=0;
    for (int i=0;i<rows;i++){
	    temp=max_in_array(matrix[i],rows);
	    if (max_element<temp){
	    	max_element=temp;
	    }
    
    }
    return max_element;
}

int* sumOfEachRow(int rows, int cols, int (*matrix)[cols]){
	//arguments: numbers of rows, number of columns, matrix
	//Find the sum of each row in 2D array
	//returns array of sum of each row.
       int array_sum=0;
       int* row_sum=(int*)malloc( (rows)*sizeof(int));
       memory_allocated++;
       if (row_sum==NULL){
       		printf("Memory allocation failed/n");
       		}
       else{
       	  for (int i=0;i<rows;i++){
		array_sum=sum(matrix[i],rows);
		row_sum[i]=array_sum;
       }
	  return row_sum;
       }

}


// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    /*arguments: array which needs to be sorted, size of array
      LOGIC: repeatative adjacent swapping until array is sorted
      returns inplace sorted array
     */
     bool swap_flag=true;
     while(swap_flag){
	     swap_flag=false;
	     for (int i=0; i<size-1; i++){
            if(arr[i]>arr[i+1]){
                swap( &arr[i], &arr[i+1]);
                swap_flag=true;
            }
	     }
     }
}

void selectionSort(int *arr, int size) {
    /*arguments: an array and size of that array
    LOGIC: iterate and swap the element(either 
    largest smallest) to sorted array
    return: in-place sorted array
    */
    if (size==1){
	printf("Already Sorted\n");    
    }
    else{    
        while(size!=1){
    	    int *max_num_ptr=arr;
            for (int i=0;i<size;i++){                         //loop find the address of max value
                if(arr[i]>*max_num_ptr){
                        max_num_ptr=&arr[i];
                    }
            }
	    size--;
	    swap(&arr[size],max_num_ptr);
        }
    }

}

typedef void (*SortFunction)(int*, int);

void applySort(int *arr,int size, SortFunction sortfunc){
	sortfunc(arr,size);
}


// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

typedef int (*operation)(int,int);

int Calculator(int first_operand,int second_operand,operation operator){
	int answer= operator(first_operand,second_operand);
    return answer;
}

// Part 4: Linked List
struct Node {
    /*Data_Type of data is restricted to int*/
    int data;
    struct Node* next;
};


struct generic_node {
    /*Data_Type of data is not only restricted to int
        it id generic*/
    union data;
    struct Node* next;
};

/*Function pointer initializing either 
    we are adding generic data of int*/
//typedef Node* (*NodeInitializer)(Node*, void);

//void generic_link_list(struct Node** head,void value, NodeInitializer link_list_type){
//	struck link_list_type* Node;
//}


struct Node nodes[100];                                  // Array to hold nodes (static allocation)
int nodeCount = 0;                                      // kepping track of nodes


void insertAtBeginning(struct Node** head, int value) {
    /*argument: starting index(head), value wanna add
     Add the value in the linklist of it have space.
    */
    if (nodeCount >= sizeof(nodes) / sizeof(nodes[0])) {
        printf("List is full, cannot insert more nodes\n");
        return;
    }
    // Assign data to the new node
    nodes[nodeCount].data = value;
    nodes[nodeCount].next = *head;
    // Update head to point to the new node
    *head = &nodes[nodeCount];
    // Increment node count
    nodeCount++;
}

/*
void insertAtBeginning(struct Node** head, int value) {
    //------------------Segmentation_fault-------------------
    //argument: starting index(head), value wanna add
    // Add the value in the linklist of it have space.
    

    struct Node temp;
   // Assign data to the new node
    temp. = value;
    temp.next = *head;
    // Update head to point to the new node
    *head = &temp;
    // Increment node count
    nodeCount++;
}

*/


void deleteByValue(struct Node** head, int value) {
    struct Node* temp = *head;
    while (temp != NULL && temp->next->data != value && temp->next != NULL) {  // Traversing the list for finding the value
        temp = temp->next;
    }
    if (temp->next == NULL) {                                                  // If element we want to remove is last.
        temp->next=NULL;
        nodeCount--;
    }  else if (temp != NULL){
            temp->next=temp->next->next;                                       // if the element we want to remove is in middle
            nodeCount--;
            }
    else {
        printf("Value not found in the list\n");
    }
}

void printList(struct Node* head) {
    /* arguments: takes head pointer
     * and print the values*/
    while (head != NULL) {
        printf("%d ", head->data);
        head = head->next;
    }
    printf("\n");
}

// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    /*arguments: takes size of array
      LOGIC:allocate the memory of specific array
      return array of that size
    */
    int* memory_alocated=(int*)malloc((size)*sizeof(int));
    if (memory_alocated==NULL){
        printf("Memory allocation failed");
        return 1;
    }
    else{
        return memory_alocated;
    }

}

void extendArray(int** arr, int* size, int newSize) {
    /* arguments: takes pointer to array, 
                  size of array that array,
                  new size: how much more we want to extend.
        returns: return type is void. But this function 
                 extends array to value
    */ 
    int* temp=(int*)realloc(*arr,newSize * sizeof(int));
    if (temp==NULL){
        printf("Memory allocation failed");
    }
    *arr = temp;
    memory_allocated++;
    *size = *size+newSize;
    
}

// Memory leak detector
void* allocateMemory(size_t size) {
    /*argument: size of memory you want to allocate
     LOGIC: Allocate memory using malloc
     return: pointer to the allocatd memory*/

    void* ptr = malloc(size);
    if (!ptr) {
        printf("Memory allocation failed\n");
        return ptr;
    }
    memory_allocated++;
    return ptr;

}


void freeMemory(void* ptr) {
    /*argument: memeory you want tp free
      free the allocated memory.
    */
    memory_allocated--;
    free(ptr);
}

void checkMemoryLeaks() {
    if (memory_allocated!=0){
        printf("There is still unfreed memory left.");
    }
    else{
        printf("No memory leak found");
    }
}

// Part 6: Structures and Unions
//6.1
struct Student {
    char name[50];
    int id;
    float grades[3];
};

struct Department {
    char name[50];
    struct Student* students;                           //Pointer it will point to the list of students
    int numStudents;
};

/*
A Datatype which
Holds the data of University
 -name or uni
 -name of departments
 -name of Strudents
 */
struct University {
    char name[100];
    struct Department* departments;                     // Pointer will point to the list of departments
    int numDepartments;
    struct Student* Students;                           // will point to the list of students
};


union data {
    int i;
    float f;
    char c;
};




void inputStudentData(struct Student* s) {
    /* arguments:takes student data_type.
        initiate the student type.
    */

    printf("Enter name of the student: ");
    scanf("%s",s->name);
    printf("\n");

    printf("Enter name of the id of the student: ");
    scanf("%d",&s->id);
    printf("\n");

    printf("Enter first garde of the student: ");
    scanf("%f",&s->grades[0]);
    printf("\n");

    printf("Enter second garde of the student: ");
    scanf("%f",&s->grades[1]);
    printf("\n");

    printf("Enter third garde of the student: ");
    scanf("%f",&s->grades[2]);
    printf("\n");

}

float calculateAverage(struct Student* s) {
    /*arguments: a pointer of class student. 
      return: float type, average of  gardes of student
    */
    float average=0.0;
    for (int i=0;i<sizeof(s->grades);i++){
        average= average+s->grades[i]; 
    }
    average=average/sizeof(s->grades);
    return average;
}

void printStudentInfo(struct Student* s) {
    // prints the data of student
    printf("Student Name: %s\n", s->name);
    printf("Student ID: %d\n", s->id);
    printf("Student Grades: %.2lf, %.2lf, %.2lf\n", s->grades[0], s->grades[1], s->grades[2]);
}

// Part 7: File I/O

void writeStudentToFile(struct Student* s, const char* filename) {
    /*Arguments: student, and file to which want to write
        LOGIC: Opens the file and write the student attributes in it
        output: student written in the file
    */

    FILE *file= fopen(filename,"w");
    if (file==NULL){
        printf("unable to access the file");
    }
    else{
        fprintf(file, "Student ID: %d\n", s->id);
        fprintf(file, "Name: %s\n", s->name);
        fprintf(file, "grade1 : %.2f\n", s->grades[0]);
        fprintf(file, "grade1 : %.2f\n", s->grades[1]);
        fprintf(file, "grade1 : %.2f\n", s->grades[2]);
        fclose(file);  
        printf("file written successfully");
    }
}

void readStudentFromFile(struct Student* s, const char* filename) {
    /* Arguments: student to hold the data read from file, and file from which to read
       LOGIC: Opens the file and reads the student attributes from it
       Output: student read from the file
    */
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Unable to access the file\n");
    } else {
        fscanf(file, "Student ID: %d\n", &s->id);
        fscanf(file, "Name: %s\n", s->name);
        fscanf(file, "Grade 1: %f\n", &s->grades[0]);
        fscanf(file, "Grade 2: %f\n", &s->grades[1]);
        fscanf(file, "Grade 3: %f\n", &s->grades[2]);
        fclose(file);
        printf("File read successfully\n");
    }
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    /* Arguments: student, and file to which want to write
       LOGIC: Opens the file and writes the student attributes in binary format
       Output: student written in the binary file
    */
    FILE *file = fopen(filename, "wb");
    if (file == NULL) {
        printf("Unable to access the file\n");
    } else {
        fwrite(s, sizeof(struct Student), 1, file);
        fclose(file);
        printf("Binary file written successfully\n");
    }
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    /* Arguments: student to hold the data read from file, and file from which to read
       LOGIC: Opens the file and reads the student attributes from it in binary format
       Output: student read from the binary file
    */
    FILE *file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Unable to access the file\n");
    } else {
        fread(s, sizeof(struct Student), 1, file);
        fclose(file);
        printf("Binary file read successfully\n");
    }
}

void logMessage(const char* message, const char* logfile) {
    /* Arguments: message to log, and log file to which to append the message
       LOGIC: Opens the log file and appends a timestamped message to it
       Output: message appended to the log file
    */
    FILE *file = fopen(logfile, "a");
    if (file == NULL) {
        printf("Unable to access the log file\n");
    } else {
        time_t now = time(NULL);
        char *timestamp = ctime(&now);
        timestamp[strlen(timestamp) - 1] = '\0'; // Remove the newline character
        fprintf(file, "[%s] %s\n", timestamp, message);
        fclose(file);
        printf("Message logged successfully\n");
    }
}

void displayLog(const char* logfile) {
    /* Arguments: log file from which to read the log messages
       LOGIC: Opens the log file and reads the contents, then prints them
       Output: log messages displayed on the console
    */
    FILE *file = fopen(logfile, "r");
    if (file == NULL) {
        printf("Unable to access the log file\n");
    } else {
        char buffer[100];
        while (fgets(buffer, sizeof(buffer), file) != NULL) {
            printf("%s", buffer);
        }
        fclose(file);
    }
}

//3.2
void testSortFunction() {

    printf("Test for 3.2: \n");
    int arr1[] = {64, 25, 12, 22, 11};
    int size = 5;

    int arr2[] = {5, 3, 8, 4, 2};

    int arr3[] = {64, 25, 12, 22, 11};

    int arr4[] = {5, 3, 8, 4, 2};

    printf("Original array 1:\n");
    print_array(arr1, size);

    printf("Sorting array 1 using selection sort:\n");
    applySort(arr1, size, selectionSort);
    print_array(arr1, size);

    printf("Original array 2:\n");
    print_array(arr2, size);

    printf("Sorting array 2 using selection sort:\n");
    applySort(arr2, size, selectionSort);
    print_array(arr2, size);

    printf("Original array 3:\n");
    print_array(arr3, size);

    printf("Sorting array 3 using bubble sort:\n");
    applySort(arr3, size, bubbleSort);
    print_array(arr3, size);

    printf("Original array 4:\n");
    print_array(arr4, size);

    printf("Sorting array 4 using bubble sort:\n");
    applySort(arr4, size, bubbleSort);
    print_array(arr4, size);
}



//3.3
void testCalculator() {
    int result;

    // Test addition
    result = Calculator(10, 5, add);
    printf("Addition test: %d + %d = %d\n", 10, 5, result); // Expected: 15

    // Test subtraction
    result = Calculator(10, 5, subtract);
    printf("Subtraction test: %d - %d = %d\n", 10, 5, result); // Expected: 5

    // Test multiplication
    result = Calculator(10, 5, multiply);
    printf("Multiplication test: %d * %d = %d\n", 10, 5, result); // Expected: 50

    // Test division
    result = Calculator(10, 5, divide);
    printf("Division test: %d / %d = %d\n", 10, 5, result); // Expected: 2

}

void test_Link_list(){
struct Node* head = NULL;

    // Inserting elements at the beginning of the list
    insertAtBeginning(&head, 5);
    insertAtBeginning(&head, 10);
    insertAtBeginning(&head, 15);

    printf("List after insertions: ");
    printList(head);

    // Deleting an element from the list
    printf("List before: ");
    printList(head);
    deleteByValue(&head, 10);

    printf("List after deletion: ");
    printList(head);

}



//5
void test_Dynamic_allocation(){
      /*test the working of function*/

      //Testing unit for malloc
      printf("Please enter the size of array:");
      int input_array_size;
      scanf("%d",&input_array_size);
      int *arr=createDynamicArray(input_array_size);
      for (int i = 0; i < input_array_size; i++) {
            printf("Enter element at index:%d  ",i);
            scanf("%d",(arr+i));
        }
      printf("\nAllocated array\n");
      print_array(arr,input_array_size);
      printf("Sum of array is %d \n",sum(arr,input_array_size));

      printf("Average of array is %d \n",
            (sum(arr,input_array_size)/input_array_size));



      //Testing unit for realloc
      printf("Please enter the size to which you want to extent array right now the size of %d: ", input_array_size);
      int extended_size;
      scanf("%d",&extended_size);


      /* Main purpose of writing is that i an making 
         changings in the address so it will change the value.
      */
      int size=input_array_size;  

      extendArray(&arr,&input_array_size,extended_size);

      //declaring the values
      for (int i = size; i < size+extended_size; i++) {
            printf("Enter element at index:%d  ",i);
            scanf("%d",(arr+i));
        }
      print_array(arr,input_array_size);
      free(arr);                                                        //since memory is allocated with malloc
      memory_allocated--;
      printf("5.3:");




}




void test_structures(){
    /*Testing for the structures part*/
    struct Student student;
    inputStudentData(&student);
    printf("Average of grades= %.2lf\n",calculateAverage(&student));
    printf("Following student info\n");
    printStudentInfo(&student);

    // First, a list of students in the department
    struct Student test_student_CE1 = {"Hira", 15, {20.0, 2.0, 45.0}};
    struct Student test_student_CE2 = {"Ammara", 20, {20.0, 5.0, 50.0}};
    struct Student test_student_CE3 = {"Khansa", 30, {20.0, 8.0, 51.0}};
    struct Student students_CE[] = {test_student_CE1, test_student_CE2, test_student_CE3};

    struct Student test_student_EE1 = {"Aisha", 15, {20.0, 2.0, 45.0}};
    struct Student test_student_EE2 = {"Ali", 25, {20.0, 5.0, 50.0}};
    struct Student test_student_EE3 = {"Ahsan", 30, {20.0, 8.0, 51.0}};
    struct Student students_EE[] = {test_student_EE1, test_student_EE2, test_student_EE3};

    // Defining the departments
    struct Department department_CE = {"CE", students_CE, 3};
    struct Department department_EE = {"EE", students_EE, 3};
    struct Department departments[] = {department_CE, department_EE};

    // Now defining the university
    struct Student all_students[] = {test_student_CE1,
                                     test_student_CE2,
                                     test_student_CE3,
                                     test_student_EE1,
                                     test_student_EE2,
                                     test_student_EE3};
    struct University university = {"UET", departments, 2, all_students};

    // Print the university hierarchy
    printf("University: %s\n", university.name);
    for (int i = 0; i < university.numDepartments; i++) {
        struct Department dept = university.departments[i];
        printf("  Department: %s\n", dept.name);
        for (int j = 0; j < dept.numStudents; j++) {
            struct Student stud = dept.students[j];
            printf("Student: %s, ID: %d, Grades: %.1f, %.1f, %.1f\n",
                    stud.name, stud.id, stud.grades[0], stud.grades[1], stud.grades[2]);
        }
 


}
}


//part7

void test_file_handling(){
    /*This function is of file handling*/
    const char *filename = "file_handling_test.txt";
    const char *binary_filename = "file_handling_test.bin";
    const char *log_filename = "logfile.txt";


    struct Student student = {"Hira", 15, {20.0, 2.0, 45.0}};


    //write to file
    writeStudentToFile(&student, filename);
    struct Student student_read;

    //read from file
    readStudentFromFile(&student_read, filename);
    printf("Read from text file: %d %s %.2f %.2f %.2f\n", 
                      student_read.id, student_read.name,
                      student_read.grades[0], 
                      student_read.grades[1], 
                      student_read.grades[2]);


    // Test binary file handling
    writeStudentToBinaryFile(&student, binary_filename);
    readStudentFromBinaryFile(&student_read, binary_filename);
    printf("Read from binary file: %d %s %.2f %.2f %.2f\n", 
                                    student_read.id,
                                    student_read.name,
                                    student_read.grades[0],
                                    student_read.grades[1],
                                    student_read.grades[2]);


    // Test logging
    logMessage("This is a test log message.", log_filename);
    displayLog(log_filename);
}



int main() {
    srand(time(NULL));
    //1.1:
    basic();
    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n");
    //1.2:
    /*-First we have to decalres the variables
      -We will initiate the pointers with there adresses,
      -pass those pointers as arguments of the function */
	int input_a=2;
	int input_b=3;
	printf("The numbers before swapping are %d %d \n",input_a,input_b);
    	swap(&input_a,&input_b);
	printf("The numbers after swapping are %d %d \n",input_a,input_b);



    printf("1.3: Using pointers to print an array.");
    //initaling a sample array of integers.
    int size=5;
    int arr[]={1,2,3,4,5};

    //Preapring the arguments.
    int *temp_ptr=arr; //As the argument should be a pointer. I can also pass the value temp_arr direct.

    print_array(temp_ptr,size);

    //sum of list
    int sum_array=sum(temp_ptr,size);
    printf("Sum of this array is: %d",sum_array);

    /*Reverse of array*/
    reverseArray(temp_ptr, size);


    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    //Implement exercises 2.1
    /*Printing a matrix of 2x2
        each element will be in the range of 0-100*/
    printf("Printing a matrix of 2x2 each element will be in the range of 0-100\n");
    int rows = 2, cols = 2;
    int matrix[rows][cols];
    initializeMatrix(rows, cols, matrix);     //Initializing the matrix of: 
    printMatrix(rows, cols, matrix);          //printing the matrix
					      
    printf("Part 2.2:");
    printf("Here is the max in matrix %d\n",findMaxInMatrix(rows, cols, matrix));

    /*This is The code which i used for 
      unit testing of max_in_array*/
    //int array_list[]={65,25,22,200};
    //printf("This is the code for max element in array 200: %d", max_in_array(array_list,4));
    int* row_Sums=sumOfEachRow(rows, cols,matrix);
    print_array(row_Sums,rows);
    free(row_Sums);
    memory_allocated--;




    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // Implement exercises 3.1, 3.2, and 3.3
    //
    // 3.1,
    // 3.1.1: Bubble_sort
    printf("Part 3.1\n");
    printf("Bubble_sort on that reversed array:\n");
    bubbleSort(arr,size);
    print_array(arr,size);

    
    //3.1.2: Selection_sort.
    int test_array[]={15,4,60,85,29};
    printf("Original array: ");
    print_array(test_array,size);
    selectionSort(test_array,size);
    printf("After applying Selection Sort: ");
    print_array(test_array,size);


    //3.2
    testSortFunction();
    printf("Part3.2:\n");
    printf("\n");


    //3.3;	
    printf("Part3.3:\n");
    testCalculator();

    printf("\n");


    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    //4.1
    printf("Linklist:\n");
    test_Link_list();

    // Part 5: Dynamic Memory Allocation
    printf("Part 5: Dynamic Memory Allocation\n");
    printf("5.1\n");
    test_Dynamic_allocation();


    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4
    printf("6.2\n");
    test_structures();

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    test_file_handling();
    checkMemoryLeaks();

    return 0;
}
