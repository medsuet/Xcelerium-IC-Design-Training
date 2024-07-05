#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Macro to check if a pointer is NULL
#define CHECKNULL(ptr) if(ptr==NULL) return 1
// Macro to check if a pointer is NULL for functions returning void
#define CHECKNULLv(ptr) if(ptr==NULL) return

// Part 1: Pointer Basics and Arithmetic
void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp;
    CHECKNULLv(a); CHECKNULLv(b);
    temp = *a; *a = *b; *b = temp;
}
void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    CHECKNULLv(arr);
    int i;
    int temp;
    for (i=0; i< (int) size/2; i++) {
        swap(arr+i, arr+size-1 - i);
    }	
}
void printArray(int *arr, int size) {
    // Displays elements of an integer array
    CHECKNULLv(arr);
    printf("{ ");
    for (int i=0; i<size; i++) {
        printf("%d ",arr[i]);
    }
    printf("}\n");
}
int sumArray(int *arr, int size) {
    // Returns sum of elements of an array
    CHECKNULL(arr);
    int i;
    int sum=0;
    for (i=0; i<6; i++) {
        sum += arr[i];
    }
    return sum;
}

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Initialize Matrix with random values
    CHECKNULLv(matrix);
    for (int r=0; r<rows; r++) {
        CHECKNULLv(*(matrix+r));
        for (int c=0; c<cols; c++) {
            *(*(matrix + r) + c) = rand()%1000;
        }
    }
}
void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
    CHECKNULLv(matrix);
    for (int r=0; r<rows; r++) {
        CHECKNULLv(*(matrix+r));
        printf("[");
        for (int c=0; c<cols; c++) {
            printf("%d\t",*(*(matrix + r) + c));    
        }
        printf("]\n");
    }
            
}
int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    
    CHECKNULL(matrix);
    int max = *(*matrix); // initial max is the 0,0 element

    for (int r=0; r<rows; r++) {
        CHECKNULL(*(matrix+r));
        for (int c=0; c<cols; c++) {
            if ( *(*(matrix+r)+c) > max ) {
                max = *(*(matrix+r)+c);
            }
        }
    }

    return max;
}
void sumRows(int *sum, int rows, int cols, int (*matrix)[cols]) {
    CHECKNULLv(matrix);
    for (int r=0; r<rows; r++) {
        CHECKNULLv(*(matrix+r));
        sum[r]=0;
        for (int c=0; c<cols; c++) {
           sum[r] += (*(matrix+r))[c];
        }
    }
}

// Part 3: Function Pointers
void bubbleSort(int *arr, int size) {
    // TODO: Implement bubble sort
    CHECKNULLv(arr);
    short noMoreSwaps = 0;
    while (noMoreSwaps == 0) {
        noMoreSwaps=1;
        for (int i=1; i<size; i++) {
            if (arr[i-1]>arr[i]) {
                swap(arr+i-1, arr+i);
                noMoreSwaps=0;
            }
        }
        size--;
    }
    
}
void selectionSort(int *arr, int size) {
    // TODO: Implement selection sort
    CHECKNULLv(arr);

    int min, minindex;
    for (int leftbound=0; leftbound<size; leftbound++) {
        // find min unsorted element
        min = arr[leftbound];
        minindex=leftbound;
        
        for (int i = minindex+1; i<size; i++){
            if (arr[i] < min) {
                min =  arr[i];
                minindex = i;
            }
        }
        swap(arr+minindex, arr+leftbound);
    }
}
typedef void (*SortFunction)(int*, int);

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
    CHECKNULLv(head);
    struct Node *newNode = (struct Node *) malloc(sizeof(struct Node));
    CHECKNULLv(newNode);

    newNode->data = value;
    newNode->next = *head;
    *head = newNode;
}
void deleteByValue(struct Node** head, int value) {
    // TODO: Implemient delete by value
    CHECKNULLv(head);
    struct Node *thisNode = *head;
    struct Node *prevNode = NULL;
    
    CHECKNULLv(head); CHECKNULLv(*head);

    while (thisNode != NULL) {
        if ( (thisNode->data) == value) {
            if (prevNode == NULL) {// for cases where data is at head
                *head = thisNode->next;
            }
            else {
                prevNode->next = thisNode->next;
            }
            break;
        }
        else {
            prevNode = thisNode;
            thisNode = thisNode->next;
        }
    }
}
void printList(struct Node* head) {
    // TODO: Implement print list
    struct Node *thisNode;
    int i=0;

    CHECKNULLv(head);

    thisNode = head;
    do {
        printf("%d -> ", thisNode->data);
        thisNode = thisNode->next;

    } while (i++<5 && thisNode != NULL);
    printf("NULL\n");
}

// Part 5: Dynamic Memory Allocation
int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
    return (int *) calloc(size, sizeof(int));
}
void extendArray(int** arr, int* size, int newSize) {
    // TODO: Extend the array using realloc()
    CHECKNULLv(arr); CHECKNULLv(*arr);
    *arr = (int *) realloc( *arr, *size * sizeof(int));
    *size = newSize;
}

int Global_numDynAlloc = 0;

// Memory leak detector
void* allocateMemory(size_t size) {
    // TODO: Allocate memory and keep track of it
    Global_numDynAlloc +=1;
    return (void *) malloc(size);
}
void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
    Global_numDynAlloc -= 1;
    free(ptr);
}
void checkMemoryLeaks() {
    // TODO: Check for memory leaks
    if (Global_numDynAlloc==0) printf("\nNo memory leak\n");
    else printf("\nMemory leak present!\n");
}

// Part 6: Structures and Unions
struct Student {
    char name[50];
    unsigned int id;
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
struct GenericNode{
    union Data value;
    struct GenericNode *next;
};
void insertGenericNodeAtBeginning(struct Node** head, union Data value) {
    // insert at beginning
    CHECKNULLv(head);
    struct GenericNode *newNode = (struct GenericNode *) malloc(sizeof(struct GenericNode));
    CHECKNULLv(newNode);

    newNode->value = value;
    newNode->next = *head;
    *head = newNode;
}
void inputStudentData(struct Student* s) {
    // Inputs name, id, grades of 3 subjects and stores in struct of type Student
    CHECKNULLv(s);
    printf("Student information:\n");
    printf("Enter name: ");
    scanf("%s", s->name);
    printf("Enter id: ");
    scanf("%d",&(s->id));
    printf("Enter subject 1 grade: ");
    scanf("%f",(s->grades));
    printf("Enter subject 2 grade: ");
    scanf("%f",(s->grades)+1);
    printf("Enter subject 3 grade: ");
    scanf("%f",(s->grades)+2);
}
float calculateAverage(struct Student* s) {
    // Returns average of grade array of struct Student
    int size = sizeof(s->grades)/sizeof((s->grades)[0]);
    float sum = 0;
    for (int i=0; i<size; i++) {
        sum += (s->grades)[i];
    }
    return (float) sum / size;
}
void printStudentInfo(struct Student* s) {
    // Prints data in struct Student
    CHECKNULLv(s);
    float avgGrade = calculateAverage(s);
    printf("\n");
    printf("Student information:\n");
    printf("Name:%s\tId:%d\n",s->name, s->id);
    
    int size = sizeof(s->grades)/sizeof((s->grades)[0]);
    for (int i=0; i<size; i++) {
        printf("Grade %d:%.2f\n", i+1, (s->grades)[i]);
    }
    printf("Average grade = %.2f", avgGrade);
}

// Part 7: File I/O
void writeStudentToFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a text file
    CHECKNULLv(s);
    FILE *dataFile = fopen(filename, "w");
    CHECKNULLv(dataFile);
    
    fprintf(dataFile, "%s,", s->name);
    fprintf(dataFile, "%d,", s->id);
    fprintf(dataFile, "%f,", s->grades[0]);
    fprintf(dataFile, "%f,", s->grades[1]);
    fprintf(dataFile, "%f\n", s->grades[2]);

    fclose(dataFile);
}
void readStudentFromFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a text file
    CHECKNULLv(s);
    FILE *dataFile = fopen(filename, "r");
    CHECKNULLv(dataFile);

    // read 1 line from file
    char line[100];
    fgets(line,100,dataFile);

    char *token;
    // split line by "," using strtok
    // get 1st part of line before , (name)
    // and store it in struct variable
    token = strtok(line,",");
    strcpy(s->name, token);

    // get 2nd part of line before , (id)
    token = strtok(NULL,",");
    s->id = atoi(token);    // convert to integer
    
    // get 3rd,4th,5th part of line before , (grades)
    token = strtok(NULL,",");   // convert to double
    s->grades[0] = strtod(token,NULL);
    token = strtok(NULL,",");
    s->grades[1] = strtod(token,NULL);
    token = strtok(NULL,",");
    s->grades[2] = strtod(token,NULL);

    fclose(dataFile);
}
void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    // TODO: Write student data to a binary file
    CHECKNULLv(s);
    FILE *dataFile = fopen(filename, "wb");
    CHECKNULLv(dataFile);
    
    fwrite(s,sizeof(struct Student),1,dataFile);

    fclose(dataFile);
}
void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    // TODO: Read student data from a binary file
    CHECKNULLv(s);
    FILE *dataFile = fopen(filename, "rb");
    CHECKNULLv(dataFile);

    fread(s, sizeof(struct Student), 1, dataFile);

    fclose(dataFile);
}
void logMessage(const char* message, const char* logfile) {
    // TODO: Append a timestamped message to the log file
    FILE *log = fopen(logfile, "a");

    time_t t; time(&t); char *logTime =ctime(&t);
    logTime[strcspn(logTime,"\n")] = 0;  // remove new line
    fprintf(log, "[%s]: %s\n", logTime, message);

    fclose(log);
}
void displayLog(const char* logfile) {
    // TODO: Read and display the contents of the log file
    FILE *log = fopen(logfile, "r");
    char line[300];

    while ( fgets(line, 100, log) ) {
        printf("%s", line);
    }

    fclose(log);
}

void Task1(void){
    // Part 1: Pointer Basics and Arithmetic
    printf("Part 1: Pointer Basics and Arithmetic\n\n");
    
    int *a, *b;
    int num1, num2;
    
    a = &num1;
    num1 = 50;
    printf("Initially: num1 = %d, *a = %d\n", num1, *a);
    *a = 83;
    printf("When *a is changed: num1 = %d, *a = %d\n", num1, *a);

    b = &num2; *b = 25;
    printf("Before reversal: num1 = %d, num2 = %d\n", num1, num2);
    swap(a,b);
    printf("After reversal: num1 = %d, num2 = %d\n", num1, num2);

    int array1[6] = {11,12,13,14,15,16};
    int sum = 0;
    int i;
    
    printf("Initial array: ");
    printArray(array1, 6);

    sum = sumArray(array1, 6);
    printf("Sum of array = %d\n", sum);

    printf("Reverse array: ");
    reverseArray(array1, 6);
    printArray(array1, 6);
}
void Task2(void){
    // Part 2: Pointers and Arrays
    printf("\nPart 2: Pointers and Arrays\n\n");
    
    int M[3][2];
    int max;
    int rowSum[3];

    initializeMatrix(3,2,M);
    printMatrix(3,2,M);
    max = findMaxInMatrix(3,2,M);
    printf("Max value in matrix M is %d\n", max);

    sumRows(rowSum,3,2,M);
    printf("Sum of rows of matrix: ");   
    printArray(rowSum, 3);
}
void Task3(void){
    // Part 3: Function Pointers
    printf("\nPart 3: Function Pointers\n\n");
    
    void (*fptr)(int*, int) = &bubbleSort;

    int myArray[10] = {10,8,7,1,9,5,2,3,4,6};
    printf("BubbleSort\nUnsorted array: "); printArray(myArray,10);
    (*fptr)(myArray,10);
    printf("Sorted array: "); printArray(myArray,10);

    fptr = &selectionSort;
    int myArray2[10] = {15,16,19,18,11,12,14,20,17,13};
    printf("SelectionSort\nUnsorted array: "); printArray(myArray2,10);
    (*fptr)(myArray2,10);
    printf("Sorted array: "); printArray(myArray2,10);

        // function pointer for math (+ - * /)
    int (*math)(int,int);

    int a,b,result;
    char op;
    printf("Enter math expression: ");
    scanf("%d %c %d", &a, &op, &b);

    switch (op) {
        case '+': math=add; break;
        case '-': math=subtract; break;
        case '*': math=multiply; break;
        case '/': math=divide; break;
        default:
            printf("Operation not supported!\n");
            break;
    }
    printf("= %d \n",math(a,b));
}
void Task4(void){
    // Part 4: Advanced Challenge
    printf("\nPart 4: Advanced Challenge\n\n");
    
    struct Node node0,node1,node2;
    struct Node *root = &node0;
    
    node0.data=0; node0.next=&node1;
    node1.data=1; node1.next=&node2;
    node2.data=2; node2.next=NULL;
    printf("Linked list: ");
    printList(root);

    insertAtBeginning(&root, -1);
    printf("Linked list (element added): ");
    printList(root);

    deleteByValue(&root, 2);
    printf("Linked list (element deleted): ");
    printList(root);

    // generic linked list
    struct GenericNode node10;
    struct GenericNode *root2 = &node0;
    union Data d1; d1.c='x';
    node10.value = d1;
    
    d1.i=11; insertGenericNodeAtBeginning(root2, d1);
    d1.f=12; insertGenericNodeAtBeginning(root2, d1);


}
void Task5(void){
    // Part 5: Dynamic Memory Allocation
    printf("\nPart 5: Dynamic Memory Allocation\n\n");

    int sizeDynamicArray;
    int sumDynamicArray;
    float avgDynamicArray;
    printf("Enter size of dynamic array: ");
    scanf("%d", &sizeDynamicArray);

    int *dynamicArray1 = createDynamicArray(sizeDynamicArray);
    CHECKNULLv(dynamicArray1);
    printf("Enter elements of dynamic array:\n");
    for (int i=0; i<sizeDynamicArray; i++)
    {
        printf("Element %d = ",i);
        scanf("%d",dynamicArray1+i);
    }
    printf("DynamicArray = ");
    printArray(dynamicArray1, sizeDynamicArray);
    sumDynamicArray = sumArray(dynamicArray1, sizeDynamicArray);
    avgDynamicArray = (float) sumDynamicArray / sizeDynamicArray;
    printf("Sum of dynamicArray = %d\n",sumDynamicArray);
    printf("Average of dynamicArray = %f\n",avgDynamicArray);
    
    // extend dynamic array
    int newSizeDynamicArray, oldSizeDynamicArray;
    oldSizeDynamicArray = sizeDynamicArray;

    printf("Enter new size of dynamic array: ");
    scanf("%d", &newSizeDynamicArray);
    
    extendArray(&dynamicArray1, &sizeDynamicArray, newSizeDynamicArray);
    CHECKNULLv(dynamicArray1);
    printf("Enter new elements of dynamic array:\n");
    for (int i=oldSizeDynamicArray; i<newSizeDynamicArray; i++) {
        printf("Element %d = ",i);
        scanf("%d",dynamicArray1+i);
    }
    printf("Extended DynamicArray = ");
    printArray(dynamicArray1, sizeDynamicArray);
    
    free(dynamicArray1);

    // memory leak detector
    printf("\n\nMemory leak detector:\n");
    printf("Allocating memory:\n");
    char *newArray = (char *) allocateMemory(10*sizeof(char));
    
    printf("Checking memoryleak:");
    checkMemoryLeaks();

    printf("\nFreeing memory:\n");
    freeMemory(newArray);
    
    printf("Checking memoryleak:");
    checkMemoryLeaks();
}
void Task6(void){
    // Part 6: Structures and Unions
    printf("\nPart 6: Structures and Unions\n\n");
    
    struct Student student1;
    inputStudentData(&student1);
    printStudentInfo(&student1);

    struct Student studentsList1[3] = {
        {"Peter", 25, {8.8, 9.0, 7.5}},
        {"Jack", 26, {2.2, 6.8, 8.9}},
        {"George", 27, {5.8, 7.4, 5.5}}
    };

    struct Student studentsList2[3] = {
        {"John", 29, {8.0, 2.9, 6.2}},
        {"Peter", 30, {8.0, 6.8, 5.6}},
        {"Thomas", 28, {9.0, 3.3, 4.8}}
    };

    struct Student studentsList3[4] = {
        {"Tayyab", 31, {8.0, 2.9, 6.2}},
        {"Usman", 32, {8.0, 6.8, 5.6}},
        {"Ahmad", 33, {8.0, 6.8, 5.6}},
        {"Ali", 34, {9.0, 3.3, 4.8}}
    };

    struct Department departments[3] = {
        {"EE", studentsList1, 3},
        {"CS", studentsList2, 3},
        {"MECH", studentsList3, 4}
    };

    struct University thisUniversity = {"UET Lahore", departments, sizeof(departments)/sizeof(departments[0])};

    union {
        int iscore;
        float fscore;
        short sscore;
    } team;

    printf("\n");
    team.iscore =  45;
    printf("team.iscore: %d\n",team.iscore);
    team.fscore = 45.2;
    printf("team.fscore: %f\n",team.fscore);
    team.sscore = (short) 45;
    printf("team.sscore: %d\n",team.sscore);

}
void Task7(void){
    // Part 7: File I/O
    printf("\nPart 7: File I/O\n\n");
    struct Student student1={"Babar Azam",2,{8.5,0,7}};
    struct Student student2, student3;
    
    printf("Text file I/O:");
    writeStudentToFile(&student1, "studentdata.txt");
    readStudentFromFile(&student2, "studentdata.txt");
    printStudentInfo(&student2);

    printf("\n\nBinary file I/O:");
    writeStudentToBinaryFile(&student1, "studentdata.bin");
    readStudentFromBinaryFile(&student3, "studentdata.bin");
    printStudentInfo(&student3);

    printf("\n\nLog file I/O:\n");
    logMessage("All is well", "logfile.log");
    displayLog("logfile.log");
}

int main() {
    srand(time(NULL));
    //Task1();
    //Task2();
    //Task3();
    Task4();
    //Task5();
    //Task6();
    //Task7();

    printf("\n\n");

    return 0;
}
