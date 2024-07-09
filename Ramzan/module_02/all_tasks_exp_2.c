#include<stdio.h>
//Part 1: Pointer Basics and Arithmetic


//Task 1.1
/*
int main()
{
    int x = 10;
    int *ptr;
    ptr = &x;
    printf("Value using direct access is:%d\n",x);
    printf("Value using pointer access is:%d\n",*ptr);

    printf("Modified value is:\n");

    *ptr = 40;
    printf("Value after modification is:%d\n",*ptr);
    return 0;
}
*/



//Task 1.2
/*
int swap( int *a,int *b);
int main()
{
    int x = 10;
    int y = 20;
    printf("Elements before swap are x=%d,y=%d\n",x,y);
    swap(&x,&y);
    printf("Elements after swap are x=%d,y=%d\n",x,y);
}
int swap(int *a,int *b)
{
    int z;
    z = *a;
    *a = *b;
    *b = z;
    return 0;
}
*/



//Task 1.3

/*
int main()
{
    int arr[5] = {1,2,3,4,5};
    int *ptr = arr;
    int sum = 0;
    int new_arr[5];
    printf("Elements of an arraay are:\n");
    for(int i=0;i<5;i++)
    {
        printf("%d ",(*ptr+i));
        sum = sum + *(ptr+i);
        new_arr[i] = arr[5-1-i];
    }
    printf("\n");
    printf("Sum of all elements is:%d\n",sum);
    printf("Reversed array is:\n");
    for(int i=0;i<5;i++)
    {
        printf("%d ",new_arr[i]);
    }
    //rintf("%d",new_arr[0]);
    return 0;
}

*/




/*

#include<stdio.h>
#include <stdlib.h>
#include <time.h>

//Part 2: Pointers and Arrays
//Task 2.1



// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Initialize matrix with random values
    srand(time(0));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 100; // Assign random values between 0 and 99
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Print the matrix
    printf("Our Matrix is:\n");
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Find and return the maximum element in the matrix
    int max = matrix[0][0];
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] > max) {
                max = matrix[i][j];
            }
        }
    }
    return max;
}

int main() {
    int rows = 2;
    int cols = 3;
    int arr[rows][cols];

    initializeMatrix(rows, cols, arr);
    printMatrix(rows, cols, arr);

    int max = findMaxInMatrix(rows, cols, arr);
    printf("Max Element is: %d\n", max);

    return 0;
}

*/




//Task 2.2



/*
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Part 2: Pointers and Arrays
void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Initialize matrix with random values
    srand(time(0));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = rand() % 100; // Assign random values between 0 and 99
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // Print the matrix
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int sumRow(int cols, int *row) {
    int sum = 0;
    for (int i = 0; i < cols; i++) {
        sum += row[i];
    }
    return sum;
}

int main() {
    int rows = 2;
    int cols = 3;
    int arr[rows][cols];

    initializeMatrix(rows, cols, arr);
    printMatrix(rows, cols, arr);

    for (int i = 0; i < rows; i++) {
        int sum = sumRow(cols, arr[i]);
        printf("Sum of row %d is: %d\n", i, sum);
    }

    return 0;
}

*/



/*

#include<stdio.h>

//Task 3.1
//Bubble sort algorithm

void BubbleSort(int *arr,int size);
int main()
{
    int my_arr[] = {-2,45,0,11,-9};
    int len = sizeof(my_arr)/sizeof(my_arr[0]);
    BubbleSort(my_arr,len);
    for(int j = 0;j<len;j++)
    {
        printf("%d ",my_arr[j]);
    }
    return 0;
}
void BubbleSort(int *arr,int size)
{
    int step = 0;
    int i = 0;
    for(step = 0;(step<size-1);step++)
    {
        for(i=0;(i<size-1);i++)
        {
            //int temp;
            if(*(arr+i)>*(arr+i+1))
            {
                int temp = *(arr+i);
                *(arr+i) = *(arr+i+1);
                *(arr+i+1) = temp;
            }
        }
    }
}
*/


//Selection sort


/*
void SelectionSort(int *arr,int size);
int main()
{
    int my_arr[] = {20,12,10,15,2};
    int len = sizeof(my_arr)/sizeof(my_arr[0]);
    SelectionSort(my_arr,len);
    printf("Selection Sort is:\n");
    for(int x=0;x<len;x++)
    {
        printf("%d ",my_arr[x]);
    }
    return 0;

}
void SelectionSort(int *arr,int size)
{
    int step;
    int j;
    for(step = 0;(step<size-1);step++)
    {
        int min_index = step;
        for(j=step+1;j<size;j++)
        {
            if(*(arr+j)< *(arr+min_index))
            {
                min_index = j;
            }
        }
        int temp = *(arr+step);
        *(arr+step) = *(arr+min_index);
        *(arr+min_index) = temp;
    }
}

*/



//Task 3.2


/*
void BubbleSort(int *arr,int size);
int main()
{
    int my_arr[] = {-2,45,0,11,-9};
    int len = sizeof(my_arr)/sizeof(my_arr[0]);
    //Declaring a function pointer for sorting
    void (*SortFun)(int[],int) = BubbleSort;
    SortFun(my_arr,len);
    for(int j = 0;j<len;j++)
    {
        printf("%d ",my_arr[j]);
    }
    return 0;
}
void BubbleSort(int *arr,int size)
{
    int step = 0;
    int i = 0;
    for(step = 0;(step<size-1);step++)
    {
        for(i=0;(i<size-1);i++)
        {
            //int temp;
            if(arr[i]>arr[i+1])
            {
                int temp = *(arr+i);
                *(arr+i) = *(arr+i+1);
                *(arr+i+1) = temp;
            }
        }
    }
}
*/



/*
//Task 3.3

void Calculator(int a,int b);
int main()
{
    int x = 10;
    int y = 3;
    //Use function pointer
    void(*FuncPointer)(int,int) = Calculator;
    FuncPointer(x,y);
}
void Calculator(int a,int b)
{
    printf("Addition is:%d\n",a+b);
    printf("Subtraction is:%d\n",a-b);
    printf("Multiplication is:%d\n",a*b);
    printf("Division is:%5.2f\n",(float) a/b);
    return 0;
}


*/


//Part 5: Dynamic Memory Allocation

//Task 5.1

//part(a)

/*
#include<stdio.h>
int* createDynamicArray(int size);
int main()
{
    int size;
    int sum=0;
    float average;
    int i;

    //Enter the sizeof an array
    printf("Enter the sizeof an array:");
    scanf("%d",&size);

    //Allocate dynamic array
    int *array = createDynamicArray(size);

    //Enter elements of an array
    printf("Enter %d elements:\n",size);

    for(i=0;i<size;i++)
    {
        printf("Elements %d: ",i+1);
        scanf("%d",&array[i]);
        
    }
    //calculate sum of an array
    for (int j=0;j<size;j++)
    {
        sum = sum + *(array+j);
    }
    printf("Sum of an array is %d\n",sum);
    //calculate average

    average = (float)sum/size;
    printf("Average of an array is %5.2f",average);

    //free the allocated memory
    free(array);
    return 0;
}
int *createDynamicArray(int size)
{
    // Allocate memory for an array of integers
    int *array = (int*)malloc(size*sizeof(int));
    // Check if memory allocation was successful
    if (array == NULL)
    {
        printf("Allocation was failed");
        exit(1);
    }
    printf("Total allocated address was:%p\n",array);
    return array;
}

*/




//Task 5.2


/*
#include<stdio.h>
void extendArray(int** arr, int* size, int newsize);
int main()
{
    int size = 5;
    int newsize = 10;
    //create  initial dynamic memory allocation
    int *array = (int*)malloc(size*sizeof(int));
    if (array == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }
    //first of all i form my original array
    for(int i=0;i<5;i++)
    {
        array[i] = i+1;
    }
    //printing my original array
    printf("Original array:\n");
    for(int i=0;i<size;i++)
    {
        printf("%d ",*(array+i));
    }
    printf("\n");
    //extending size f an array

    extendArray(&array,&size,&newsize);

    //initilize the new elememnts af an array;

    for(int j=0;j<newsize;j++)
    {
        array[j] =j+1;
    }

    printf("Extended array:\n");
    for(int j=0;j<newsize;j++)
    {
        printf("%d ",*(array+j));
    }
    printf("\n");

    // Free the allocated memory
    free(array);
    return 0;
}
void extendArray(int** arr, int* size, int newsize)
{
    int *temp = (int*)realloc(*arr,newsize*sizeof(int));
    if(temp==NULL)
    {
        printf("Memory allocation failed");
        free(*arr);
        return 1;
    }
    *arr = temp;
    *size = newsize;
}

*/



//Task 5.3


/*
#include <stdio.h>
#include <stdlib.h>

#define MAX_ALLOC 1000 // Adjust this based on our needs

void *allocatedMemory[MAX_ALLOC];
int numAllocations = 0;

// Allocate memory and track it
void *allocateMemory(size_t size) {
    void* ptr = malloc(size);
    if (ptr != NULL) {
        allocatedMemory[numAllocations++] = ptr; // Track allocated memory
    }
    return ptr;
}

// Free memory and update tracking
void freeMemory(void* ptr) {
    for (int i = 0; i < numAllocations; ++i) {
        if (allocatedMemory[i] == ptr) {
            free(ptr);
            allocatedMemory[i] = NULL; // Clear the tracked memory slot
            break;
        }
    }
}

// Check for memory leaks
void checkMemoryLeaks() {
    for (int j = 0; j < numAllocations; ++j) {
        if (allocatedMemory[j] != NULL) {
            printf("Memory leak detected: Address %p\n", allocatedMemory[j]);
        }
    }
}

int main() {
    // Allocate some memory
    int* ptr1 = allocateMemory(sizeof(int));
  //  int* ptr2 = allocateMemory(10 * sizeof(int));

    // freeMemory(ptr1);

    // Check for memory leaks
    checkMemoryLeaks();

    // Free allocated memory
    freeMemory(ptr1);
   // freeMemory(ptr2);

    // Check again after freeing
   // checkMemoryLeaks();

    return 0;
}
*/





//Part 6: Structures and Unions
//Task 6.1&6.2


/*
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

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

int main() {
    struct Student student1 = {"Sara Ali", 1, {3.2, 2.2, 4.5}};
    struct Student student2 = {"Fiqa Ali", 5, {6.2, 4.2, 0.5}};

    // Create a department and allocate memory for students
    struct Department my_dep;
    strcpy(my_dep.name, "Electrical Engineering");
    my_dep.students = (struct Student*)malloc(2 * sizeof(struct Student));
    my_dep.numStudents = 2;

    // Add students to the department
    my_dep.students[0] = student1;
    my_dep.students[1] = student2;

    // Create a university and allocate memory for departments
    struct University my_uni;
    strcpy(my_uni.name, "UET LAHORE");
    my_uni.departments = (struct Department*)malloc(2 * sizeof(struct Department));
    my_uni.numDepartments = 1;

    // Add the department to the university
    my_uni.departments[0] = my_dep;

    // Print information
    printf("University Name: %s\n", my_uni.name);
    printf("Number of Departments: %d\n", my_uni.numDepartments);
    printf("Department Name: %s\n", my_dep.name);
    printf("Number of Students in %s: %d\n", my_dep.name, my_dep.numStudents);

    //now i want to print etc of all above

    for(int i=0;i<my_dep.numStudents;i++)
    {
        printf("Student %d:\n",i+1);
        printf("Name: %s\n",my_dep.students[i].name);
        printf("ID: %d\n",my_dep.students[i].id);
        printf("Grades: %.2f, %.2f, %.2f",my_dep.students[i].grades[0],my_dep.students[i].grades[1],my_dep.students[i].grades[2]);

    }
    printf("\n");
}
*/

//Task 6.2


/*
#include<stdio.h>
struct Student {
    char name[50];
    int id;
    float grades[3];
};

void inputStudentData(struct Student* s);
float calculateAverage(struct Student* s);
void printStudentInfo(struct Student* s);

int main()
{
    struct Student my_students;
    inputStudentData(&my_students);
    printStudentInfo(&my_students);
    calculateAverage(&my_students);
    return 0;
}

void inputStudentData(struct Student* s)
{
    printf("Enter student Name: ");
    scanf("%s",s->name);
    printf("Enter student ID: ");
    scanf("%d",&s->id);

    printf("Enter grades for three subjects: ");
    for(int i=0;i<3;i++)
    {
        scanf("%f",&s->grades[i]);
    }
}

// Function to calculate the average grade
float calculateAverage(struct Student* s) {
    int sum =0;
    for(int j=0;j<3;j++)
    {
        sum = sum+s->grades[j];
    }
    float average = (float)sum/3;
    printf("Average grade: %.2f",average);
}

void printStudentInfo(struct Student* s)
{
    printf("Name: %s\n", s->name);
    printf("ID: %d\n", s->id);
    printf("Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
}
*/




//Task 6.3



/*

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// Structure definitions
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

// Function prototypes
float calculateAverage(struct Student* s);
void printStudentInfo(struct Student* s);
void printDepartmentInfo(struct Department* d);
void printUniversityInfo(struct University* u);

int main() {
    // Create students
    struct Student student1 = {"Sara Ali", 1, {3.2, 2.2, 4.5}};
    struct Student student2 = {"Fiqa Ali", 5, {6.2, 4.2, 0.5}};

    // Create a department and allocate memory for students
    struct Department my_dep;
    strcpy(my_dep.name, "Electrical Engineering");
    my_dep.students = (struct Student*)malloc(2 * sizeof(struct Student));
    my_dep.numStudents = 2;

    // Add students to the department
    my_dep.students[0] = student1;
    my_dep.students[1] = student2;

    // Create a university and allocate memory for departments
    struct University my_uni;
    strcpy(my_uni.name, "UET LAHORE");
    my_uni.departments = (struct Department*)malloc(1 * sizeof(struct Department));
    my_uni.numDepartments = 1;

    // Add the department to the university
    my_uni.departments[0] = my_dep;

    // Print university information
    printUniversityInfo(&my_uni);

    // Free allocated memory
    free(my_dep.students);
    free(my_uni.departments);

    return 0;
}

// Function definitions
float calculateAverage(struct Student* s) {
    float sum = 0;
    for (int i = 0; i < 3; i++) {
        sum += s->grades[i];
    }
    return sum / 3;
}

void printStudentInfo(struct Student* s) {
    printf("  Name: %s\n", s->name);
    printf("  ID: %d\n", s->id);
    printf("  Grades: %.2f, %.2f, %.2f\n", s->grades[0], s->grades[1], s->grades[2]);
    printf("  Average Grade: %.2f\n", calculateAverage(s));
}

void printDepartmentInfo(struct Department* d) {
    printf("Department Name: %s\n", d->name);
    printf("Number of Students: %d\n", d->numStudents);
    for (int i = 0; i < d->numStudents; i++) {
        printf("Student %d:\n", i + 1);
        printStudentInfo(&d->students[i]);
    }
}

void printUniversityInfo(struct University* u) {
    printf("University Name: %s\n", u->name);
    printf("Number of Departments: %d\n", u->numDepartments);
    for (int i = 0; i < u->numDepartments; i++) {
        printDepartmentInfo(&u->departments[i]);
    }
}
*/





//Task 6.4

/*
#include<stdio.h>

union DATA {
    int i;
    float f;
    char c;
    char str[56];
};
int main()
{
    union DATA my_data;
    my_data.i = 10;
    printf("My Integer data is: %d\n",my_data.i);

    my_data.f = 3.45;
    printf("My float data is: %f\n",my_data.f);


    my_data.c = 'A';
    printf("My character data is: %c\n",my_data.c);

    strcpy(my_data.str,"I love C Programming.");
    printf("My string data is: %s\n",my_data.str);
    return 0;

}
*/


