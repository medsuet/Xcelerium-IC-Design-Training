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
