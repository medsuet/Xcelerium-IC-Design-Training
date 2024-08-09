#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <assert.h>

#define UPPER 99
#define LOWER 1


int *mem_ptr;

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
    int n = *a;                                                                 // temp variable
    *a = *b;
    *b = n;
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    int i;
    int *arr_end = arr + size - 1;                                              // array ending pointer, arr is array starting pointer
    for (i=0; i<((int) (size/2)); i++ )
    {
        swap(arr,arr_end);
        arr++;                                                                  // incrementing from beginning
        arr_end--;                                                              // decrementing from end
    }
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
    int i,j;

    for (i=0; i<rows; i++)
    {
        for (j=0; j<cols; j++)
        {
            *((*(matrix+i) + j)) = ( rand() % (UPPER-LOWER+1)) + LOWER;         // outer pointer - column traversal
        }                                                                       // inner pointer - row traversal
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix

    int i,j;                                                                    // i for rows, j for columns

    printf("The Initialized Matrix is: \n");

    for (i=0; i<rows; i++)
    {
        printf("[");
        for (j=0; j<cols; j++)
        {
            printf("%d ", *((*(matrix+i) + j)));
        }
        printf("]\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    int i,j,max,temp;
    max = 0;

    for (i=0; i<rows; i++)
    {
        for (j=0; j<cols; j++)
        {
            temp = *((*(matrix+i)) +j);
            if ( temp > max ) // the quantity is the matrix element
            {
                max = temp;
            }
        }
    }
    return max;
}

void findSumOfEachRowInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    int i,j;
    int sum = 0;

    printf("Sum of each row is:");
    for (i=0; i<rows; i++)
    {
        printf("\nRow %d: ",i+1);
        for (j=0; j<cols; j++)
        {
            sum += *((*(matrix+i)) +j);
        }
        printf("%d",sum);
        sum = 0;
    }
    printf("\n");
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    int *reset_ptr = arr; // to get back to start of array
    int *arr_next = arr+1; // next element of arr pointer
    int i,num,num_next;
    int flag = 0; // this flag will check if the array is sorted or not, if sorted then it will turn 1 and end it.

    while (1)
    {
        flag = 1; // initialize flag as 1
        for (i=0; i<size; i++)
        {
            num = *arr;
            num_next = *arr_next;
            if ( num > num_next)
            {
                flag = 0; // if unsorted, flag = 0
                swap(arr,arr_next);
            }
            arr++;
            arr_next++;
        }

        if (flag == 1)
        {
            break;
        }

        arr = reset_ptr;
        arr_next = reset_ptr+1;
    }
}

void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
    int *replace_address = arr;
    int *min_address = arr;
    int min = *arr;
    int i,j;

    for (i = 0; i<size; i++)
    {
        for (j = i; j<size; j++)
        {
            if (min > *arr)
            {
                min = *arr;
                min_address = arr;
            }
            arr++;
        }
        swap(min_address,replace_address);
        replace_address++;
        arr = replace_address;
        min = *replace_address; // taking the first number as min from where next loop will start.
        min_address = replace_address;
    }
}

typedef void (*SortFunction)(int*, int); // implementation in the main function

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
float divide(float a, float b) { return b != 0 ? a / b : 0; }

void simpleCalculator(int (*addition)(int,int), int (*subtraction)(int,int), int (*multiplication)(int,int), float (*division)(float,float)){
    // TODO: Implement a simple calculator using switch statement
char operation;
int operand1,operand2;

printf("\nEnter first number: ");
scanf("%d",&operand1);
printf("\nEnter second number: ");
scanf("%d",&operand2);
printf("\nEnter operation (+,-,*,/): ");
scanf(" %c",&operation);


    switch(operation)
    {
        case '+':
            printf("Sum: %d \n", addition(operand1,operand2));
            break;

        case '-':
            printf("Subtract: %d \n", subtraction(operand1,operand2));
            break;

        case '*':
            printf("Product: %d \n", multiplication(operand1,operand2));
            break;

        case '/':
            printf("Division: %f \n", division((float) operand1, (float) operand2));
            break;

        default:
            printf("Wrong Operation");
            break;

    }
}


// Part 4: Linked List
struct Node {
    int data;
    struct Node* next;
};

void insertAtBeginning(struct Node** head, int value) {
    // TODO: Implement insert at beginning

    struct Node *newnode;

    newnode = (struct Node *)malloc(sizeof(struct Node));

    newnode->data = value;

    newnode->next = *head;

    *head = newnode;
}

void deleteByValue(struct Node** head, int value) {
    // TODO: Implement delete by value
    struct Node* temp = *head;
    struct Node* prev = NULL;

    if (temp != NULL && temp->data == value) { // If the head node itself holds the value to be deleted
        *head = temp->next; // Change head
        free(temp); // Free old head
        return;
    }

    while (temp != NULL && temp->data != value) {
        prev = temp; // prev node track
        temp = temp->next; // moving to next node
    }

    if (temp == NULL) return; // If value was not present in linked list

    // Unlinking the middle element that contains matched value, i.e 1,2,3 will become 1,3 with 2 deleted
    prev->next = temp->next;
    free(temp);
}

void printList(struct Node* head) {
    // TODO: Implement print list
    // lets call that head is our currentNode so I don't have to define its duplicate again

    while (head!=NULL)
    {
        printf("%d ", head->data);
        head = head->next;
    }
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

int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
    int i,num;
    int *starting_address;
    int *array = (int*) malloc(size*sizeof(int));

    starting_address = array; // create a pointer that points to start of array

    for (i=0; i<size; i++)
    {
        printf("Enter Number %d: ",i+1);
        scanf("%d",&num);
        *array = num;
        array++;
    }
    printf("\nDynamic Memory Allocted!");
    printf("\nPrinting Array: ");

    array = starting_address;
    for (i=0; i<size; i++)
    {
        printf("%d ",*array);
        array++;
    }
    printf("\n");

    return starting_address;
}

void extendArray(int** arr, int* size, int newSize) {
    // TODO: Extend the array using realloc()
    int i,num;
    int* starting_address;

	starting_address = *arr;
    *arr = (int *) realloc(*arr, newSize*sizeof(int));
	starting_address = *arr;    // reseting pointer address to start of array

    printf("\nExtended array size by %d\n",newSize);

	*arr = (*arr) + (*size);    // pointing to the newly added element
    printf("\n");

    // to allocate new numbers
    for (i=*size;i<newSize;i++)
    {
        printf("Enter Number %d: ", i+1);
        scanf("%d",&num);
        **arr = num;
        (*arr)++;
    }

    printf("\nPrinting Extended Array: ");

    *arr = starting_address;
    for (i=0; i<newSize; i++)
    {
        printf("%d ",**arr);
        (*arr)++;
    }
    printf("\n");
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
	free(ptr);
}

void checkMemoryLeaks() {
    // TODO: Check for memory leaks
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
    // TODO: Write student data to a binary file
    FILE *fptr;
    int i;
    size_t elementsWritten;
    char str[20];

    fptr = fopen(filename, "w");

    if (fptr == NULL)
    {
        printf("File failed to open!");
        exit(0);
    }

    printf("\nWriting Student's Record");
    size_t nameLength = strlen(s->name) + 1; // adding 1 to include the null terminator in the end
    elementsWritten = fwrite(s->name,sizeof(char),nameLength,fptr);

    if (elementsWritten != nameLength)
    {
        printf("\nError writing Student's Name");
        fclose(fptr);
        exit(0);
    }

    sprintf(str, "%d", s->id); // converting integer to string since fwrite works only on integers
    elementsWritten = fwrite("\n",sizeof(char),strlen("\n"),fptr); // adding new line myself
    elementsWritten = fwrite(str,sizeof(char),strlen(str),fptr);

    if (elementsWritten != strlen(str))
    {
        printf("\nError writing Student's ID");
        fclose(fptr);
        exit(0);
    }

    for (i=0; i<3; i++) // loop to write grades of 3 subjects
    {

        memset(str, '\0',sizeof(str)); // resetting the string, \0 is considered as a null
        sprintf(str, "%.2f", s->grades[i]);
        elementsWritten = fwrite("\n",sizeof(char),sizeof("\n"),fptr);
        elementsWritten = fwrite(str,sizeof(char),sizeof(str),fptr);

        if (elementsWritten != sizeof(str))
            {
                printf("\nError writing Student's Grades");
                fclose(fptr);
                exit(0);
            }

    }
    fclose(fptr);

    printf("\nStudent's Record Written Succesfully\n");

}

void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
    FILE *fptr;
    int ch;
    fptr = fopen(filename, "r");

    if (fptr == NULL)
    {
        printf("\nThe file failed to open");
        exit(0);
    }
    else
    {
        printf("\nThe file contents are:\n");
        ch = fgetc(fptr);

        while (ch != EOF)
            {
                printf("%c",ch);
                ch = fgetc(fptr);
            }
    }

    printf("\n");
    fclose(fptr);
}

void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
    FILE *fptr;
    int i;
    size_t elementsWritten;
    char str[20];

    fptr = fopen(filename, "wb");

    if (fptr == NULL)
    {
        printf("File failed to open!");
        exit(0);
    }

    printf("\nWriting Student's Record");
    size_t nameLength = strlen(s->name) + 1; // adding 1 to include the null terminator in the end
    elementsWritten = fwrite(s->name,sizeof(char),nameLength,fptr);

    if (elementsWritten != nameLength)
    {
        printf("\nError writing Student's Name");
        fclose(fptr);
        exit(0);
    }

    sprintf(str, "%d", s->id); // converting integer to string since fwrite works only on integers
    elementsWritten = fwrite("\n",sizeof(char),strlen("\n"),fptr); // adding new line myself
    elementsWritten = fwrite(str,sizeof(char),strlen(str),fptr);

    if (elementsWritten != strlen(str))
    {
        printf("\nError writing Student's ID");
        fclose(fptr);
        exit(0);
    }

    for (i=0; i<3; i++) // loop to write grades of 3 subjects
    {

        memset(str, '\0',sizeof(str)); // resetting the string, \0 is considered as a null
        sprintf(str, "%.2f", s->grades[i]);
        elementsWritten = fwrite("\n",sizeof(char),sizeof("\n"),fptr);
        elementsWritten = fwrite(str,sizeof(char),sizeof(str),fptr);

        if (elementsWritten != sizeof(str))
        {
            printf("\nError writing Student's Grades");
            fclose(fptr);
            exit(0);
        }

    }
    fclose(fptr);

    printf("\nStudent's Record Written Succesfully\n");

}

void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file

    FILE *fptr;
    int i;
    char buffer[100];

    fptr = fopen(filename, "rb");

    if (fptr == NULL)
    {
        printf("\nThe file failed to open");
        exit(0);
    }
    else
    {
        printf("\nThe file contents are:\n");

        fread(buffer,sizeof(buffer),1,fptr);

        for (i=0; i<strlen(buffer);i++)
        {
            printf("%u",buffer[i]);
        }
    }

    printf("\n");

    fclose(fptr);

}

void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    FILE *fptr;

    time_t t = time(NULL);
    struct tm *tm = localtime(&t);
    char timestamp[64];
    size_t ret = strftime(timestamp, sizeof(timestamp), "%c", tm);
    assert(ret);
    printf("%s\n", timestamp);                                  // generating timestamp

    fptr = fopen(logfile, "a");

    if (fptr == NULL)
    {
        printf("Failed to open file");
        exit(0);
    }

    printf("\nAdding message into log file\n");
    strcat(timestamp,": ");                                     // adding space between timestamp and message
    fwrite("\n",sizeof(char),strlen("\n"),fptr);
    fwrite(timestamp,sizeof(char),strlen(timestamp),fptr);      // writing timestamp in beggining and message later
    fwrite(message,sizeof(char),strlen(message),fptr);
    printf("\nAdded the message succesfully\n");

    fclose(fptr);
}

void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
    FILE *fptr;
    int ch;
    fptr = fopen(logfile, "r");

    if (fptr == NULL)
    {
        printf("\nThe file failed to open");
        exit(0);
    }
    else
    {
        printf("\nThe file contents are:\n");
        ch = fgetc(fptr);

        while (ch != EOF)           // loop will stop at End of File EOF
        {
            printf("%c",ch);        // printing character by character
            ch = fgetc(fptr);       // traversing character to next character
        }
    }

    printf("\n");

    fclose(fptr);
}



int main() {
    srand(time(NULL));
    int i;
    int number;

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);

    // Part 1: Pointer Basics and Arithmetic
    printf("Task 1: Pointer Basics and Arithmetic\n");
    // TODO: Implement exercises 1.1, 1.2, and 1.3

    //1.1
    int integer = 42;
    int *ptr_int = &integer;
    printf("\nValue of integer through Direct Access: %d\n", integer);
    printf("Value of integer through Pointer: %d\n", *ptr_int);
    printf("Task 1.1 Complete\n");

    printf("\n Task 1.2: Implementing SWAP Function\n");
    int swap_a = 1;
    int swap_b = 2;
    printf("Before swap, the value of a is %d, and the value of b is %d\n",swap_a,swap_b);
    swap(&swap_a,&swap_b);
    printf("After swap, the value of a is %d, and the value of b is %d\n",swap_a,swap_b);
    printf("Task 1.2 Complete\n");

    printf("\n Task 1.3: Array using Pointers\n");

    int sum = 0;
    int size = 10;
    int arr[10] = {1,2,3,4,5,6,7,8,9,10};

    int *ptr_arr = arr;

    printf("Printing Array: ");
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        sum += *ptr_arr;
        ptr_arr++;
    }

    printf("\nTotal Sum of Elements is: %d\n",sum);

    reverseArray(arr,size);
    printf("Reversed Array is: ");

    ptr_arr = arr; // initializing the pointer to array beginning
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        ptr_arr++;
    }
    printf("\nTask 1.3 Complete\n");

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);




    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n");
    // TODO: Implement exercises 2.1 and 2.2
    printf("\nTask 2.1: Matrix Initialization And Usage\n");
    int rows = 3;
    int cols = 4;
    int matrix[rows][cols];
    initializeMatrix(rows,cols,matrix);

    printMatrix(rows,cols,matrix);

    printf("\nMaximum number in the matrix is %d\n",findMaxInMatrix(rows,cols,matrix));
    printf("Task 2.1 Complete!\n");

    printf("\nTask 2.2: Sum of each Row in Matrix\n");

    findSumOfEachRowInMatrix(rows,cols,matrix);
    printf("Task 2.2 Complete!\n");

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);


    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n");
    // TODO: Implement exercises 3.1, 3.2, and 3.3

    printf("\n Task 3.1: Bubble Sort and Selection Sort");

    int arr_bbsort[10] = {2,1,3,4,6,8,5,7,9,10};

    printf("\nThe unsorted array is: ");
    ptr_arr = arr_bbsort; // initializing the pointer to array beginning
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        ptr_arr++;
    }



    bubbleSort(arr_bbsort,10);
    printf("\nThe sorted array using Bubble Sort is is: ");
    ptr_arr = arr_bbsort; // initializing the pointer to array beginning
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        ptr_arr++;
    }

    int arr_selsort[10] = {2,1,3,4,6,8,5,7,9,10};

    printf("\nThe unsorted array is: ");
    ptr_arr = arr_selsort; // initializing the pointer to array beginning
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        ptr_arr++;
    }



    selectionSort(arr_selsort,10);
    printf("\nThe sorted array using Selection Sort is: ");
    ptr_arr = arr_selsort; // initializing the pointer to array beginning
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        ptr_arr++;
    }

    printf("\nTask 3.1 Complete!\n");

    printf("\nTask 3.2: Function Pointer for Sorting Algorithm\n");

    printf("Unsorted Array is: ");

    int arr_sort[10] = {2,1,3,4,6,8,5,7,9,10};
    ptr_arr = arr_sort; // initializing the pointer to array beginning
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        ptr_arr++;
    }

    printf("\n\nUsing Function of SortFunction() (function pointer) to sort the array!\n");

    void (*SortFunction) (int*, int);

    SortFunction = selectionSort;

    SortFunction(arr_sort,10);
    printf("\nThe sorted array using SortFunction() is: ");
    ptr_arr = arr_sort; // initializing the pointer to array beginning
    for (i=0; i<size; i++)
    {
        printf("%d ",*ptr_arr);
        ptr_arr++;
    }

    printf("\nTask 3.2 Complete!\n");

    printf("\nTask 3.3: Calculator through Function Pointers\n");

    simpleCalculator(add,subtract,multiply,divide);

    printf("\nTask 3.3 Complete!\n");

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);


    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n");
    // TODO: Implement exercises 4.1 and 4.2

    printf("\nTask 4.1: Linked List\n");

    struct Node* head = NULL;

    insertAtBeginning(&head, 10);
    insertAtBeginning(&head, 20);
    insertAtBeginning(&head, 30);

    printf("Linked list after inserting nodes: ");
    printList(head);
    printf("\n");

    printf("Deleting by value of %d\n",20);

    deleteByValue(&head,20);
    printf("Linked list after deleting by value: ");
    printList(head);
    printf("\n");
    free(head);

    printf("\nTask 4.1 Complete!\n");

    // TASK 4.2 : GENERIC LINKED LIST

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
    printf("\nTask 4.2 Complete\n");

    printf("\nPart 4 Complete\n");

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);


    // Part 5: Dynamic Memory Allocation
    printf("\nPart 5: Dynamic Memory Allocation\n");
    // TODO: Implement exercises 5.1, 5.2, and 5.3
    printf("\nTask 5.1: Memory Allocation:\n");
    int size_array = 5;
    int newsize_array = 10;
    int* array_pointer = createDynamicArray(size_array);

    extendArray(&array_pointer, &size_array, newsize_array);

    void *mem_address = allocateMemory(10);

    mem_ptr = mem_address;

    freeMemory(mem_address);
    mem_ptr = NULL;

    checkMemoryLeaks();

    printf("\nPart 5 Complete!\n");

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);



    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n");
    // TODO: Implement exercises 6.1, 6.2, 6.3, and 6.4

    struct Student student;

    inputStudentData(&student);

    printf("The average grade is: %f",calculateAverage(&student));

    printStudentInfo(&student);

    printf("\nPart 6 Complete!\n");

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);

    // Part 7: File I/O
    printf("\nPart 7: File I/O\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3

    writeStudentToFile(&student,"file.txt");

    readStudentFromFile(&student,"file.txt");

    writeStudentToBinaryFile(&student,"file.bin");

    readStudentFromBinaryFile(&student,"file.bin");

    logMessage("Added the first log","logfile.txt");

    logMessage("Added the second log","logfile.txt");

    logMessage("Added the third log","logfile.txt");

    displayLog("logfile.txt");

    printf("\nPart 7 Complete!\n");

    printf("\nEnter ANY NUMBER to continue: ");
    scanf("%d",&number);

//    checkMemoryLeaks();

    return 0;
}
