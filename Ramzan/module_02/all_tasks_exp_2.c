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


//part(b)

/*
#include <stdio.h>
#include <stdlib.h>

// Function to extend the array using realloc
void extendArray(int** arr, int* size, int newSize) {
    // Reallocate memory for the array to the new size
    int* temp = (int*)realloc(*arr, newSize * sizeof(int));
    // Check if memory reallocation was successful
    if (temp == NULL) {
        printf("Memory reallocation failed!\n");
        free(*arr);
        exit(1);
    }
    *arr = temp; // Update the pointer to the newly reallocated memory
    *size = newSize; // Update the size of the array
}

int main() {
    int size = 5;
    int newSize = 10;

    // Create an initial dynamic array
    int* array = (int*)malloc(size * sizeof(int));
    if (array == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Initialize the array with some values
    for (int i = 0; i < size; i++) {
        array[i] = i + 1;
    }

    printf("Original array:\n");
    for (int i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    // Extend the array
    extendArray(&array, &size, newSize);

    // Initialize the new elements of the array
    for (int i = 5; i < newSize; i++) {
        array[i] = i + 1;
    }

    printf("Extended array:\n");
    for (int i = 0; i < newSize; i++) {
        printf("%d ", array[i]);
    }
    printf("\n");

    // Free the allocated memory
    free(array);

    return 0;
}
*/







//part(c)

/*
#include <stdio.h>
#include <stdlib.h>

#define MAX_ALLOCS 1000  // Adjust this based on your needs

// Structure to track allocated memory addresses
void* allocatedMemory[MAX_ALLOCS];
int numAllocations = 0;

// Allocate memory and track it
void* allocateMemory(size_t size) {
    void* ptr = malloc(size);
    if (ptr != NULL && numAllocations < MAX_ALLOCS) {
        allocatedMemory[numAllocations++] = ptr;
    }
    return ptr;
}

// Free memory and update tracking
void freeMemory(void* ptr) {
    for (int i = 0; i < numAllocations; ++i) {
        if (allocatedMemory[i] == ptr) {
            free(ptr);
            allocatedMemory[i] = NULL;
            break;
        }
    }
}

// Check for memory leaks
void checkMemoryLeaks() {
    for (int i = 0; i < numAllocations; ++i) {
        if (allocatedMemory[i] != NULL) {
            printf("Memory leak detected: Address %p\n", allocatedMemory[i]);
        }
    }
}

// Example usage
int main() {
    // Allocate some memory
    int* ptr1 = allocateMemory(sizeof(int));
    int* ptr2 = allocateMemory(10 * sizeof(int));

    // Simulate a memory leak (comment out the free)
    // freeMemory(ptr1);

    // Check for memory leaks at the end of the program
    checkMemoryLeaks();

    // Free allocated memory
    freeMemory(ptr1);
    freeMemory(ptr2);

    return 0;
}
*/


