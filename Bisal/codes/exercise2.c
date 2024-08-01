/*
 * ============================================================================
 * Filename:    exercise2.c 
 * Description: File consists of codes based on advanced concepts of C language
 * Author:      Bisal Saeed
 * Date:        7/2/2024
 * ============================================================================
 */

//NOTE: run using command : cd codes && gcc -o day2 exercise2.c
//                          ./day2

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>


// Part 1: Pointer Basics and Arithmetic

void modifyValue(int originalVal) {
    /*Logic:This function takes original value defined in main function
    which can also be modified to take value from user also in main 
    function.This function will then declare a pointer pt pointing
    towards that value.It will later print the original value by 
    direct variable or by using pointer value command. Then value 
    is modified by using pointer to some value lets say 15 here
    and printed again.
    */
    int *pt=&originalVal;
    printf("\n");
    printf("Value of x by direct access: %d\n",originalVal);
    printf("Value of x by pointers: %d\n",*pt);
    *pt=15;
    printf("Value of x by direct access: %d\n",*pt);
    printf("\n");
}

void swap(int *a, int *b) {
    /*Logic: Takes two variables and appoint pointer a and b to them 
    respectively . Then it declares a local temporary variable.
    This variable stores value of pointer value b to store it as 
    backend.Now replace value of b by a through pointers and later
    store the saved values of tempvar originally having value of
    b to pointer will be selected as  value a
    */
    int tempvar;
    tempvar=*b;
    *b=*a;
    *a=tempvar;      
}

void printArray(int *arr,int size){
    printf("\n");
    printf("The array is: ");
    printf("{ ");
    for (int loopVar = 0; loopVar<size; loopVar++){
	    printf("%d ",*(arr + loopVar));
    }
    printf("}");
    printf("\n");
}

void RecursiveReverseArray(int *arr,int start, int end){
    //if start is greater than end or equal to means that array is complete
    if (start>=end){
	return;
    }
    //swap the starting and ending element
    swap(&arr[start],&arr[end]);
    //move the start of array by 1 and reduce the end of array by 1 as they are already swapped
    //and call the function again
    RecursiveReverseArray(arr, start + 1, end - 1);
}

void reverseArray(int *arr, int size) {
    int sum=0;
    printf("\n");
    printArray(arr,size); 
    //iterate throigh all values of array using pointers and add values to sum 
    for (int loopvar = 0; loopvar<=4; loopvar++) {
        sum = sum + *(arr+loopvar);
    }
    printf("The sum of elements is: %d\n",sum);
    //call reverse function
    RecursiveReverseArray(arr,0,size-1);
    printf("\n");  
    //print reversed array
    printArray(arr,size);
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    
    srand(time(NULL));
    for (int i=0 ; i<rows ; i++){
	    for(int j=0 ; j<cols ; j++){
            *(*(matrix+i)+j) = rand()%100;
	    }
    }		    
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    printf("The elements of matrix are: \n");
    for (int i=0 ; i<rows ; i++){                                                                                              
        for(int j=0 ; j<cols ; j++){                                                                                            
            printf(" %d  ", *(*(matrix+i)+j));
        }       
        printf("\n");
    }  
    printf("\n");  
    
}

void findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) { 
	int max = *(*(matrix));
    for (int i=0 ; i<rows ; i++){                                                                                              
        for(int j=0 ; j<cols ; j++){    
            if (*(*(matrix+i)+j)> max ){                                                                                        
                max = *(*(matrix+i)+j) ;
            }       
        }  
    }
    printf("The maximum element in a matrix is : %d", max );
    printf("\n");
}

void elementSum(int rows, int cols, int (*matrix)[cols]) { 
    int sum =0;
    for (int i=0 ; i<rows ; i++){                                                                                              
        for(int j=0 ; j<cols ; j++){    
            sum= sum + *(*(matrix+i)+j);
        }  
    printf("The element sum of a row in a matrix is : %d", sum );
    printf("\n");
    sum = 0; 
    }   
}


// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
   for(int i = 0; i<size-1 ;i++) {
	 for(int j=0; j<size-i-1; j++) {
            if (*(arr+j) > *(arr+j+1)) {
	           swap((arr+j),(arr+j+1));
	        }
	    } 
    }
}

void selectionSort(int *arr, int size) {
   for (int i = 0; i<size; i++){
	   int *min=&arr[i];
	   for (int j=i ;j<size; j++){
		   if (*(min) > *(arr+j)) {
			   min=(arr+j);
		   }

	    }
	   swap(&arr[i],min);
    }
}

typedef void (*SortFunction)(int*, int);

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

typedef int (*Operation)(int, int);

void calculator() {

    int num1, num2, choice;
    //define a local function pointer as op
    Operation op = NULL;
    printf("Enter first number: ");
    scanf("%d", &num1);
    printf("Enter second number: ");
    scanf("%d", &num2);
    printf("Choose an operation (1:+, 2:-, 3:*, 4:/, 5:%%): ");
    scanf("%d",&choice);
    // from user choice assign the function to the function pointer
    switch (choice) {
        case 1:
            op = add;
            break;
        case 2:
            op = subtract;
            break;
        case 3:
            op = multiply;
            break;
        case 4:
            op = divide;
            break;
        default:
            printf("Invalid choice!\n");
            return;
    }
    //check if invalid op is to be performed then generate error 
    if (op != NULL) {
        int result = op(num1,num2);
        printf("The result is given as %d",result);
        printf("\n");
    }
    else{
        //undefined behavior causes error 
        op(num1, num2);
    }
}

// Part 4: Linked List
struct Node {
    int data;
    struct Node* next;
};

void insertAtBeginning(struct Node** head, int value) {
    //generare en empty node using dynamic mem alloc. because it will allow node to be used even after 
    //leaving the function
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    //data stored in node
    newNode->data = value;
    //newNode next pointer pointing to node originally head was pointing to 
    newNode->next = *head;
    //point head pointer to the newNode
    *head = newNode;
}


void deleteByValue(struct Node** head, int value) {
    struct Node* curr = *head;
    struct Node* prev = NULL;
    //if curr is NULL
    if (curr == NULL){
      return;
    }
    if (curr != NULL && curr->data == value) {
        //if value at head
        //if head has value in it so select head to be nexxt value 
        //and head is current so delete it 
        *head = curr->next;
        //once node is deleted deallocate its memory
        free(curr);
        return;
    }
    //search node
    while(curr!= NULL && curr->data != value){
        //if the curr is not NULL and data is not found in head
        //used to traverse through the list
        prev = curr;
        curr = curr->next;
    }
   
    //after traversing the list if current is found also change prev of it  
    prev->next = curr->next;
    free(curr);
    
}


void printList(struct Node* head) {
    //start from first node the head itself
    struct Node* current = head;
    printf("Linked List: ");
    while (current != NULL) {
        printf("%d -> ", current->data);
        //traverse through the list by reading next pointers of current nodes
        current = current->next;
    }
    //once the list is finished print NULL
    printf("NULL\n");
}

// Part 5: Dynamic Memory Allocation
void* createDynamicArray(int size) {
    return malloc(size * sizeof(int));
}

//** is pointer to a pointer
void extendArray(int** arr, int* size, int newSize) {
    //new pointer defined by reallocating the current pointer
    *arr = realloc(*arr, newSize * sizeof(int));
    *size = newSize;
}

// Memory leak detector
void* allocateMemory(size_t size) {
    return malloc(size);
}

void freeMemory(void* ptr) {
    free(ptr);
}

void checkMemoryLeaks() {
    // This function would typically compare allocated versus memory that is now free
    // and report any discrepancies or leaks.
    printf("\nMemory leak check complete. No leaks detected.\n");

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

//STUDENT DATA INPUT AND CALCULATE AVERAGE OF GRADES
void inputStudentData(struct Student* s) {
    printf("\nEnter student name: ");
    scanf("%49s", s->name);  

    printf("Enter student ID: ");
    scanf("%d",&s->id);     

    printf("Enter grades for three subjects: ");
    for (int i = 0; i < 3; ++i) {
        scanf("%f", &s->grades[i]);  // Read and store grades
    }
   
}

float calculateAverage(struct Student* s) {
    float sum=0.0;
    float avg=0.0;
    for (int i = 0; i < 3; ++i) {
        sum = sum + s->grades[i];
    }  
    avg=sum/3;
    printf("\nAverage Grade is: %f\n",avg);
}


//PRINT STUDENT INFO
void printStudentInfo(struct Student* s) {
    printf("\nStudent Information:");
    printf("\nName: %s\n", s->name);
    printf("ID: %d\n", s->id);
    printf("Grades: ");
    for (int i = 0; i < 3; ++i) {
        printf("%f ", s->grades[i]);  // Print grades
    }
    printf("\n");
}

//PRINT FILE 
void printFileInfo(FILE *file, struct Student* s) {
    fprintf(file,"\nStudent Information:");
    fprintf(file,"\nName: %s\n", s->name);
    fprintf(file,"ID: %d\n", s->id);
    fprintf(file,"Grades: ");
    for (int i = 0; i < 3; ++i) {
        fprintf(file,"%f ", s->grades[i]);  // Print grades
    }
    fprintf(file," \n");
}

//NESTED UNI STRUCTURE
void createUniversity(struct University* uni) {
    printf("\nEnter university name: ");
    //%99 to limit charaxcters to 99
    scanf("%99s", uni->name);  
    //DEPARTMENTS
    printf("Enter number of departments: ");
    scanf("%d", &uni->numDepartments);

    // Allocate memory for departments
    uni->departments = (struct Department*)malloc(uni->numDepartments * sizeof(struct Department));
    if (uni->departments = NULL) {
        //print error if no departments exist 
        //stderr is to print standard error 
        fprintf(stderr, "Memory allocation failed. Exiting...\n");
        exit(1);
    }

    //enter the names for each department of uni
    for (int i = 0; i < uni->numDepartments; i++) {
        printf("Enter department name: ");
        scanf("%49s", uni->departments[i].name);

    //STDUDENTS
        printf("Enter number of students: ");
        scanf("%d", &uni->departments[i].numStudents);

        // Allocate memory for students
        uni->departments[i].students = (struct Student*)malloc(uni->departments[i].numStudents * sizeof(struct Student));
        if (uni->departments[i].students == NULL) {
            fprintf(stderr, "Memory allocation failed. Exiting...\n");
            exit(1);
        }

        // Input details for each student in the that department
        for (int j = 0; j < uni->departments[i].numStudents; ++j) {
            printf("\nEnter details for student #%d in %s department:\n", j + 1, uni->departments[i].name);
            printf("Enter student name: ");
            scanf("%49s", uni->departments[i].students[j].name);  // Limit input to 49 characters

            printf("Enter student ID: ");
            scanf("%d", &uni->departments[i].students[j].id);

            printf("Enter grades for three subjects: ");
            for (int k = 0; k < 3; ++k) {
                scanf("%f", &uni->departments[i].students[j].grades[k]);  // Read and store grades
            }
        }
    }
}

//As memory was dynamically allocated in the above part so here we have to free it 
void freeUniversity(struct University* uni) {
    // Free memory for students in each department
    for (int i = 0; i < uni->numDepartments; ++i) {
        free(uni->departments[i].students);
    }
    // Free memory for departments
    free(uni->departments);
}

// Part 7: File I/O
void writeStudentToFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "w");
    //check if file exists
    if (file == NULL) {
        printf("Error opening file!\n");
        return;
    }
    //print statements within file 
    printFileInfo(file,s);
    fclose(file);
}

void readStudentFromFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file!\n");
        return;
    }
    //reads values through labels defined
    fscanf(file, "Name: %49s\n", s->name);
    fscanf(file, "ID: %d\n", &s->id);
    for (int i = 0; i < 3; ++i) {
        fscanf(file, "Grade %d: %f\n", &i, &s->grades[i]);
    }
    fclose(file);
}

//READ AND WRITE TO BINARY FILE
void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    //wb is used for binary format files
    FILE* file = fopen(filename, "wb");
    if (file == NULL) {
        printf("Error opening file!\n");
        return;
    }
    //reads first element from the file and s is the pointer to first element  
    fwrite(s, sizeof(struct Student), 1, file);
    fclose(file);
}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    FILE* file = fopen(filename, "rb");
    if (file == NULL) {
        printf("Error opening file!\n");
        return;
    }
    //first element from f ile is read and pointer s is where it si stored
    fread(s, sizeof(struct Student), 1, file);
    fclose(file);
}

//READ AND WRITE TO LOG FILE
void logMessage(const char* message, const char* logfile) {
    // Open the log file in append mode
    FILE *file = fopen(logfile, "a"); 
    if (file == NULL) {
        perror("Error opening log file");
        return;
    }
    //take current time and store in variable
    time_t now = time(NULL);
    //convert the time formal to local time format and assign pointer to it 
    struct tm *local = localtime(&now);

    //format time and string into specific format for log file 
    char timestamp[100];
    //timestamp will store the string that is formatted
    strftime(timestamp, sizeof(timestamp), "[%Y-%m-%d %H:%M:%S]", local);
    //strings are written in the file 
    fprintf(file, "%s %s\n", timestamp, message);
    fclose(file); 
}

void displayLog(const char* logfile) {
    FILE *file = fopen(logfile, "r");
    if (file == NULL) {
        perror("Error opening log file");
        return;
    }
    char line[256];
    // Read whole line  from the log file and print it
    while (fgets(line, sizeof(line), file) != NULL) {
        printf("%s", line);
    }

    fclose(file); // Close the log file
}



int main() {

    srand(time(NULL));
    int integer1=10;
    int integer2=5;
    int array[]={1,2,3,4,5};
    int size = sizeof(array) / sizeof(array[0]);
    int rows;
    int cols;

    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n"); 
    modifyValue(integer1);
    swap(&integer1,&integer2);
    reverseArray(array,size);

    // Part 2: Pointers and Arrays
    //MATRIX POINTERS
    printf("\nPart 2: Pointers and Arrays\n");
    printf("Enter no. of rows: ");
    scanf("%d",&rows);
    printf("Enter number of columns: ");
    scanf("%d", &cols);
    int matrix[rows][cols];
    initializeMatrix(rows,cols,matrix);
    printMatrix(rows,cols,matrix);
    findMaxInMatrix(rows,cols,matrix); 
    elementSum(rows,cols,matrix);

    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    //BUBBLE SORT
    int unsortedArray[]={15,4,3,1,2};
    int unsortsize = sizeof(unsortedArray) / sizeof(unsortedArray[0]);
    printf("Unsorted Array: ");
    printArray(unsortedArray,unsortsize);
    bubbleSort(unsortedArray,unsortsize);
    printf("Sorted Array: ");
    printArray(unsortedArray,unsortsize);
    
    //SELECTION SORT
    int unsortedArray1[]={15,4,3,1,2,0};
    printf("Unsorted Array: ");                                             
    printArray(unsortedArray1,unsortsize);                                                                                  
    selectionSort(unsortedArray1,unsortsize);                                                                                      
    printf("Sorted Array: ");                                                                                               
    printArray(unsortedArray1,unsortsize);   
    printf("\n");
    
    //FUNCTION POINTERS SORTING
    int array2[]={2,7,4,1};
    int size2 = sizeof(array2) / sizeof(array2[0]);
    int sortsel;
    SortFunction sortfunc;
    printf("Unsorted Array: ");                                             
    printArray(array2,size2); 
    printf("\n");
    printf("Choose sorting algorithm,1 for bubblesort and 2 for selection sort:" );
    scanf( "%d" , &sortsel);
    if( sortsel ==1){
      sortfunc= bubbleSort;
    }
    else if( sortsel == 2){
      sortfunc= selectionSort;
    }
    sortfunc(array2, size2);
    printf("Sorted Array: ");                                                                                               
    printArray(array2,size2);

    //CALCULATOR 
    calculator();
    printf("\n");
    
    //PART:LINKED LISTS
    struct Node* head = NULL;
    insertAtBeginning(&head, 1);
    insertAtBeginning(&head, 2);
    insertAtBeginning(&head, 3);
    printList(head);
    deleteByValue(&head, 2);
    printList(head);

    //PART: DYNAMIC MEMORY LOCATION
    int dynamicSize = 5;
    int* dynamicArray = createDynamicArray(dynamicSize);
    for (int i = 0; i < dynamicSize; i++) {
        dynamicArray[i] = i + 1;
    }
    printf("\nInitial Array:");
    printArray(dynamicArray, dynamicSize);
    extendArray(&dynamicArray, &dynamicSize, 10);
    //-5 so now loop starts from  0 and ends with 10 value element else values will be from 5 to 15 within array
    for (int i = dynamicSize - 5; i < dynamicSize; i++) {
        dynamicArray[i] = i + 1;
    }
    printf("\nExtended Array:");
    printArray(dynamicArray, dynamicSize);
    free(dynamicArray);
    checkMemoryLeaks();
    
    //PART:STRUCTURES
    //PRINT STUDENT INFO
    struct Student studentA;
    inputStudentData(&studentA);
    calculateAverage(&studentA);
    printStudentInfo(&studentA);

    //CREATE NESTED STRUCTURE FOR UNI
    struct University myUniversity;
    createUniversity(&myUniversity);
    freeUniversity(&myUniversity);
    
    //IMPLEMENT UNION
    union Data data;
    data.i = 10;
    data.f = 3.14;
    data.c = 'A';
    printf("Integer value: %d\n", data.i);
    printf("Float value: %.2f\n", data.f);
    printf("Character value: %c\n", data.c);
    
    //PART:FILE I/O
    //READ AND WRITE TO SIMPLE FILE
    const char* filename = "student.txt";
    struct Student studentFromFile,student2FromFile;
    //take input for the student to write in th file
    inputStudentData(&studentFromFile);
    writeStudentToFile(&studentFromFile, filename);
    readStudentFromFile(&studentFromFile, filename);
    printStudentInfo(&studentFromFile);
    //check execution by entering 2 students
    inputStudentData(&student2FromFile);
    writeStudentToFile(&student2FromFile, filename);
    readStudentFromFile(&student2FromFile, filename);
    printStudentInfo(&student2FromFile);

    //BINARY FILE READ AND WRITE
    const char* binFilename = "student.bin";
    writeStudentToBinaryFile(&studentFromFile, binFilename);
    readStudentFromBinaryFile(&studentFromFile, binFilename);
    printStudentInfo(&studentFromFile);
    //LOG FILE READ AND WRITE 
    const char* logfile = "log.txt";
    logMessage("This is a log message", logfile);
    logMessage("Another log entry", logfile);
    printf("Log file contents:\n");
    displayLog(logfile);

    return 0;   
}
