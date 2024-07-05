
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
