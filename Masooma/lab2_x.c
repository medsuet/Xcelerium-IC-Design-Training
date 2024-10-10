// Description: Xcelerium Training Lab 1 --C language
// Author: Masooma Zia
// Date: 02-07-2024
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void *global_arr=NULL;
//Function used to swap the values of two variables using their pointers
void swap(int *a, int *b) {
    int temp;
    temp=*a;
    *a=*b;
    *b=temp;
}
//Function used to print the array elements using pointer to array
void printArray(int *arr,int size){
    int *ptr_arr=arr;
    if (ptr_arr==NULL){
        printf("No allocation\n");
    }
    for (int i=0;i<size;i++){
        printf("%d ",*(ptr_arr+i));
    }
    printf("\n");
}
//Function used to calculate the sum of all elements of an array using pointer to array
int sumArray(int *arr, int size){
    int sum=0;
    int *ptr_arr=arr;
    for (int i=0;i<size;i++){
        sum += *(ptr_arr+i);
    }
    return sum;
}
//Function used to reverse an array using pointer to array
void reverseArray(int *arr, int size) {
    int *ptr_arr=arr;
   for (int i=0;i<size/2;i++){
        swap(ptr_arr+i,ptr_arr+(size-i-1));
    }
}

// Part 2: Pointers and Arrays
//Function used to initialize a matrix of given rows and columns with random numbers between 0 and 99 using pointer to matrix
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    int num;
    for (int i=0;i<rows;i++){
        for (int j=0;j<cols;j++){
            num = rand()%100;
            *(*(matrix+i)+j) = num;
        }
    }   

}
//Function used to print all the elements of matrix using pointer to matrix
void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    for (int i=0;i<rows;i++){
        for (int j=0;j<cols;j++){
            printf("%d ", *(*(matrix+i)+j));
        }
        printf("\n");
    }
}
//Function used to find out the maximum integer among all the elements of a matrix using pointer to matrix
int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    int temp=0;
    for (int i=0;i<rows;i++){
        for (int j=0;j<cols;j++){
            if (*(*(matrix+i)+j)>temp){
                temp=*(*(matrix+i)+j);
            }
        }
    }
    return temp;
}
//Function used to calculate and display the sum of each row of matrix using pointer to matrix
void matrixSum(int row, int col, int matrix[row][col]){
    int sum=0;
    int (*ptr_matrix)[col]=matrix;
   for (int i=0;i<row;i++){
        for (int j=0;j<col;j++){
            sum+=*(*(matrix+i)+j);
            if (j==col-1){
                printf("%d row sum is: %d\n",i,sum);
                sum=0;
            }
            else{}
        }
   }
}

// Part 3: Function Pointers
//Bubble sort algorithm to sort an array
void bubbleSort(int *arr, int size) {
    int *arr_ptr=arr;
    for (int i=0;i<size;i++){
        for (int j=0;j<(size-i-1);j++){ //to traverse through the consecutive pair of two integers and sortmthose two integers
            if (*(arr_ptr+j)>*(arr_ptr+j+1)){
                swap(arr_ptr+j,arr_ptr+j+1);
            }
        }
    }
}
//Selection sort used to sort an array
void selectionSort(int *arr, int size) {
    int *arr_ptr=arr;
    for (int i=0;i<size;i++){
        int min_ind=i;
        for (int j=min_ind;j<size;j++){
            if (*(arr_ptr+min_ind)>*(arr_ptr+j)){
                min_ind=j;//determine the index containing smallest integer
            }
        }
        swap(arr_ptr+i,arr_ptr+min_ind);
    }
}
//Function pointer of sorting Functions
typedef void (*SortFunction)(int*, int);
void sortArray(SortFunction sortFunc, int *arr, int size){
    sortFunc(arr, size);
}

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }
//Function pointer of Calculator functions
typedef int (*ArithmeticOper)(int, int);
int calculatorObj(ArithmeticOper arithOper,int a,int b){
    arithOper(a,b);
}
//Function used to calculate addition, subtraction, multiplication and division using function pointers
void myCalculator(char opr, int a, int b){
     switch (opr){
        int sum, minus, product, div;
        case 'a':
            sum=calculatorObj(add,a,b);
            printf("Sum %d\n",sum);
            break;
        case 's':
            minus=calculatorObj(subtract,a,b);
            printf("Subtraction %d\n",minus);
            break;
        case 'm':
            product=calculatorObj(multiply,a,b);
            printf("Product %d\n",product);
            break;
        case 'd':
            div=calculatorObj(divide,a,b);
            printf("Division %d\n",div);
            break;
    }
}
union Data {
    int i;
    float f;
    char c;
};
// Part 4: Linked List
struct Node {
    int data;
    struct Node* next;
};
//generic Linked list
struct NodeNew {
    union Data data;
    struct NodeNew* next;
};
//User entered integer value for generic linked list
void integerValueLL(struct NodeNew* node){
    int num_int;
    printf("Enter integer value:");
    scanf("%d",&num_int);
    node->data.i=num_int;
}
//User entered float value for generic linked list
void floatValueLL(struct NodeNew* node){
    float num_float;
    printf("Enter float value:");
    while(getchar()!='\n');
    scanf("%f",&num_float);
    node->data.f=num_float;
}
//User entered character value for generic linked list
void charValueLL(struct NodeNew* node){
    char character;
    printf("Enter character value:");
    while (getchar()!='\n');
    scanf("%c",&character);
    node->data.c=character;
}
//Function pointer of datatype of value of linked list
typedef void (*DataType)(struct NodeNew*);
void myLL(DataType dataType,struct NodeNew* node){
    dataType(node);
}
//Initialize one node of generic linkedlist with the value of desired datatype
void initializeLL(char flag){
    struct NodeNew* node=(struct NodeNew*)malloc(sizeof(struct Node));
    node->next=NULL;
    if (flag=='i'){
        myLL(integerValueLL,node);
    }
    else if (flag=='f'){
        myLL(floatValueLL,node);
    }
    else if (flag=='c'){
        myLL(charValueLL,node);
    }
    else {
        printf("Not valid data type\n");
    }
}
//Function used to insert a new node at the beginning of linkedlist
void insertAtBeginning(struct Node** head, int value) {
    struct Node* myNode=(struct Node*)malloc(sizeof(struct Node));
    if (myNode==NULL){
        printf("Falure in memory Allocation\n");
    }
    myNode->data=value;
    myNode->next=*head; //makes the new node point to what head currently points to
    *head=myNode; //now the head pointer should be equal to the new node pointer entered at the beginning of linkedlist
}
//Function used to delete the node from beginning, mid or end of a linkedlist
void deleteByValue(struct Node** head, int value) {
    struct Node* current = *head;
    struct Node* previous = NULL;
    //Deleting the head node
    if (current->data == value) {
        *head = current->next;
        free(current);
        return;
    }

    while (current != NULL && current->data != value) {
        previous = current;
        current = current->next;
    }
    previous->next = current->next;
    free(current);
}
//Function used to print the values of each node of linkedlist
void printList(struct Node* head) {
    struct Node* current=head;
    while (current!=NULL){
        printf("%d ",current->data);
        current=current->next;
    }
    printf("\n");
}

// Part 5: Dynamic Memory Allocation
//Function used to dynamically allocate memory of given size using malloc
int* createDynamicArray(int size) {
    int *arr;
    arr=(int *)malloc(size*sizeof(int));
    return arr;
    }
//Function used to put given integer at the desired index of an array
int* putNumber(int *arr,int value,int index){
    *(arr+index)=value;
    return arr;
}
//Function used to calculate the average of all the integers of an array
int averageArray(int *arr,int size){
    int sum,average;
    sum=sumArray(arr,size);
    average=sum/size;
    return average;

}
//Function used to realloc the memory for an array
void extendArray(int** arr, int* size, int newSize) {
    size=&newSize;
    *arr=realloc(*arr,*size*sizeof(int)); //should be used with the current pointer to the array (*arr), not arr itself.
    printArray(*arr,*size);
}

// Memory leak detector
//Function used to dynamically allocate the memory
void* allocateMemory(size_t size) {
    void *mem_alloc;
    mem_alloc=malloc(size);
    if (mem_alloc==NULL){
        printf("Failure in memory allocation\n");
    }
    else {
        printf("Success in memory allocation\n");
    }
    global_arr=mem_alloc;
    return mem_alloc;
}
//free the allocated memory
void freeMemory(void* ptr) {
    if (ptr!=NULL){
        free(ptr);
        global_arr=NULL;
        printf("Freed\n");
    }
}
//Function to check whether the allocated memory freed or not
void checkMemoryLeaks() {
    if (global_arr!=NULL){
        printf("Not free and Memory Leakage\n");
    }
    else{
        printf("Free and no memory leakage\n");
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
//Function used to input data to structure student
void inputStudentData(struct Student* s) {
    struct Student temp={"Masooma",1,{2,3,4}};
    *s=temp;
}
//Function used to calculate the average of the grades
float calculateAverage(struct Student* s) {
    float *arr;
    float sum=0;
    float avg;
    arr=s->grades;
    int size=sizeof(arr)/sizeof(arr[0]);
    for (int i=0;i<size;i++){
        sum+=arr[i];
    }
    avg=sum/size;
    return avg;
}
//Function used to display the structure student information using pointer to structure
void printStudentInfo(struct Student* s) {
    printf("Name:%s\n",s->name);
    printf("ID:%d\n",s->id);
    float *ptr_arr=s->grades;
    printf("Grades:");
    for (int i=0;i<3;i++){
        printf("%f ",*(ptr_arr+i));
    }
    printf("\n");
}

// Part 7: File I/O
//Function used to write the structure student information into a .txt file
void writeStudentToFile(struct Student* s, const char* filename) {
    FILE *file=fopen(filename,"w");
    if (file==NULL){
        printf("Error in memory allocation\n");
    }
    else{
        fprintf(file,"%s ",s->name);
        fprintf(file,"%d ",s->id);
        float *ptr_arr=s->grades;
        for (int i=0;i<3;i++){
            fprintf(file,"%f ",*(ptr_arr+i));
        }
        fprintf(file,"\n");
        printf("Successfully write in txt file\n");
    }
    fclose(file);
}
//Function used to read the structure student information from .txt file and stored information into a new structure object
void readStudentFromFile(struct Student* s, const char* filename) {
    FILE *file=fopen(filename,"r");
    char buffer[100];
    if (file==NULL){
        printf("Error in memory allocation\n");
    }
    else{
       if (fscanf(file, "%s %d %f %f %f", s->name, &s->id, &s->grades[0], &s->grades[1], &s->grades[2]) != 5) {
        printf("Error reading student data\n");
        }
        else{
            printf("Successfully read from .txt file\n");
        }

    fclose(file);
    }
}
//Function used to write the structure student information in binary format
void writeStudentToBinaryFile(struct Student* s, const char* filename) {
    FILE *file=fopen(filename,"wb");
    if (file==NULL){
        printf("Error in memory allocation\n");
    }
    else{
        if (fwrite(s,sizeof(struct Student),1,file)!=1){
            printf("Failure in writing\n");
        }
        else{
            printf("Successfully written in binary format\n");
        }
    }
    fclose(file);
}
//Function used to read the structure student information from binary file and stored information into a new structure object
void readStudentFromBinaryFile(struct Student* s, const char* filename) {
    FILE *file=fopen(filename,"rb");
    if (file==NULL){
        printf("Error in memory allocation\n");
    }
    else{
        if (fread(s,sizeof(struct Student),1,file)!=1){
            printf("Failure in reading\n");
        }
        else{
            printf("Successful read from binary file\n");

        }
    }
    fclose(file);
}
//Function used to write(append) time, date and corresponding message in a log file
void logMessage(const char* message, const char* logfile) {
    FILE *file=fopen(logfile,"a");
    time_t now=time(NULL);
    char timestamp[100];
    if (file==NULL){
        printf("Error in memory allocation\n");
    }
    else{
    //strftime() used to format date and time and it contains a structure tm 
        strftime(timestamp,sizeof(timestamp),"%Y-%m-%d--%H:%M:%S",localtime(&now));//value inside localtime() is broken up into the structure tm and expressed in the local time zone.
        fprintf(file,"%s %s",timestamp,message);
    }
    fclose(file);
}
//Function to display the logfile contents
void displayLog(const char* logfile) {
    FILE *file=fopen(logfile,"r");
    char buffer[250];
    if (file==NULL){
        printf("Error in memory allocation\n");
    }
    else{
        while (fgets(buffer,sizeof(buffer),file)!=NULL){ //fgets is used in a while loop to read lines from a file, it internally keeps track of the current position in the file stream. 
            printf("%s",buffer);
        }
    }
    fclose(file);
}
int main() {
    srand(time(NULL));

    printf("------Part 1: Pointer Basics and Arithmetic------\n\n");
    int var = 8;
    int num1=9;
    int num2=1;
    int *ptr_num1=&num1;
    int *ptr_num2=&num2;
    int *ptr=&var;
    printf("Direct Access %d\n",var);
    printf("Pointer Access %d\n",*ptr);
    *ptr=100;
    
    printf("Pointer Access(New Value) %d\n",*ptr);
    printf("Numbers are:\n a=%d and b=%d\n",*ptr_num1,*ptr_num2);
    swap(ptr_num1,ptr_num2);
    printf("Numbers after swap:\n a=%d and b=%d\n",*ptr_num1,*ptr_num2);
   
   
    printf("------Part 2: Pointers and Arrays------\n\n");
    int arr[]={1,2,3,4,5,6,7,8,9};
    int size;
    size=sizeof(arr)/sizeof(arr[0]);
    printf("Elements of an array are:\n");
    printArray(arr,size);
    
    printf("Sum of all elements is\n %d\n",sumArray(arr,size));
    printf("Reversed Array\n");
    reverseArray(arr,size);
    printArray(arr,size);
    
    //int matrix[3][4]={{1,2,3,4},{5,6,7,8},{9,10,11,12}};
    //int row = sizeof(matrix)/sizeof(matrix[0]);
    //int col = sizeof(matrix[0])/sizeof(matrix[0][0]);
    int matrix[3][4];
    int (*ptr_matrix)[4]=matrix;
    printf("Matrix Initialization with random numbers having 3 rows and 4 columns\n");
    initializeMatrix(3,4,ptr_matrix);
    printMatrix(3,4,ptr_matrix);
    printf("Max number of matrix is:%d\n",findMaxInMatrix(3,4,ptr_matrix));
    matrixSum(3,4,matrix);

    printf("------Part 3: Function Pointers------\n\n");
    int array1[5]={6,3,1,2,0};
    int size_array1=sizeof(array1)/sizeof(array1[0]);
    printf("Original Array\n");
    printArray(array1,size_array1);
    printf("Bubble Sort\n");
    bubbleSort(array1,size_array1);
    printArray(array1,size_array1);

    int array2[5]={16,9,11,2,0};
    int size_array2=sizeof(array2)/sizeof(array2[0]);
    printf("Original Array\n");
    printArray(array2,size_array2);
    printf("Selection Sort\n");
    selectionSort(array2,size_array2);
    printArray(array2,size_array1);

    int arr_unsorted[5]={4,1,5,98,0};
    int size_of_arr=sizeof(arr_unsorted)/sizeof(arr_unsorted[0]);
    printf("Original array\n");
    printArray(arr_unsorted,size_of_arr);
    printf("Using Bubble sort(Function Pointer example)\n");
    sortArray(bubbleSort,arr_unsorted,size_of_arr);
    printArray(arr_unsorted,size_of_arr);

    int num_1,num_2;
    char opra;
    printf("------Calculator------\n");
    printf("Enter first number:");
    scanf("%d",&num_1);
    printf("Enter second number:");
    scanf("%d",&num_2);
    printf("Enter the operation:(a,s,m,d)");
    while(getchar()!='\n');
    scanf("%c",&opra);
    myCalculator(opra,num_1,num_2);
    
    printf("------Part 4: Advanced Challenge------\n\n");
    struct Node* head=NULL;
    insertAtBeginning(&head,11);
    insertAtBeginning(&head,24);
    insertAtBeginning(&head,4);
    insertAtBeginning(&head,5);
    insertAtBeginning(&head,89);
    printf("Linkedlist Nodes' Values\n");
    printList(head);

    deleteByValue(&head,11);
    printf("Linkedlist Nodes' Values after deletion of last node: ");
    printList(head);
    deleteByValue(&head,89);
    printf("Linkedlist Nodes' Values after deletion of first node: ");
    printList(head);
    deleteByValue(&head,4);
    printf("Linkedlist Nodes' Values after deletion of middle(4) node: ");
    printList(head);
    printf("------Part 5: Dynamic Memory Allocation------\n\n");
    printf("Part 5: Dynamic Memory Allocation\n");
    int size_allocate,value;
    int i=0;
    int *arr2;
    printf("Array allocated using malloc of size 5\n");
    printArray(createDynamicArray(5),5);
    printf("Enter size of array dynamically allocated:");
    scanf("%d",&size_allocate);
    arr2=createDynamicArray(size_allocate);
    while (i<size_allocate){
        printf("Enter element of array of %d index: ",i);
        scanf("%d",&value);
        printArray(putNumber(arr2,value,i),size_allocate);
        i++; 
    }
    int *ptr_arr=arr2;
    printf("Sum of all array elements: %d\n",sumArray(arr2,size_allocate));
    printf("Average of all array elements: %d\n",averageArray(arr2,size_allocate));
    int *si=&size_allocate;
    printf("Above Array after reallocation with size 10\n");
    extendArray(&ptr_arr,si,10);

    printf("------Memory Leakage Detector------\n");
    void *memory=allocateMemory(10);
    printArray(global_arr,10);
    freeMemory(memory);
    checkMemoryLeaks();



    printf("------Part 6: Structures and Unions------\n\n");
    struct Student student;
    inputStudentData(&student);
    printf("Average of grades: %f \n",calculateAverage(&student));
    printStudentInfo(&student);
    printf("------Display contents of Nested structure (University)------\n");
    struct Department dept={"Electrical",&student,45};
    struct University uni={"UET",&dept,21};
    printf("No. of departments:%d\n",uni.numDepartments);
    printf("No. of students:%d\n",uni.departments->numStudents);
    printf("ID:%d\n",uni.departments->students->id);

    union Data data;
    data.i=4;
    printf("Integer of union is %d\n",data.i);
    data.f=5.9;
    printf("Float of union is %f\n",data.f);
    data.c='a';
    printf("Character of union is %c\n",data.c);
    printf("Integer of union is(should be unpredictable valued) %d\n",data.i);
    printf("Float of union is (should be unpredictable valued) %f\n",data.f);
    char flag;
    printf("Enter data type for linkedlist(i,f,c):");
    while(getchar()!='\n');
    scanf("%c",&flag);
    initializeLL(flag);
    printf("------Part 7: File I/O------\n");
    // TODO: Implement exercises 7.1, 7.2, and 7.3
    const char filename[10]="data.txt";
    const char file_bin[20]="data_new.txt";
    writeStudentToFile(&student,filename);
    struct Student newstudent; 
    readStudentFromFile(&newstudent,filename);
    printf("Data read from .txt file\n");
    printf("ID is %d\n",newstudent.id);
    printf("Name is %s\n",newstudent.name);
    printf("Grades are:%f %f %f\n",newstudent.grades[0],newstudent.grades[1],newstudent.grades[2]);
    writeStudentToBinaryFile(&student,file_bin);
    readStudentFromBinaryFile(&newstudent,file_bin);
    printf("Data read from Binary file\n");
    printf("ID is %d\n",newstudent.id);
    printf("Name is %s\n",newstudent.name);
    printf("Grades are:%f %f %f\n",newstudent.grades[0],newstudent.grades[1],newstudent.grades[2]);

    char logfile[25]="log.txt";
    char buffer_log1[50]="My name is Masooma Zia\n";
    logMessage(buffer_log1,logfile);
    char buffer_log2[50]="My Registration number is 2021-EE-1\n";
    logMessage(buffer_log2,logfile);
    printf("------Log file Contents------\n");
    displayLog(logfile);
    return 0;
}
