#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Part 5: Dynamic Memory Allocation

int* createDynamicArray(int size) {
    
    // Allocate memory for an array of integers
    //int* ptr_m = (int *)calloc(size, sizeof(int));
    int* ptr_m = (int *)malloc(size*sizeof(int));
    return ptr_m;
}

void extendArray(int** arr, int* size, int newSize) {
    
    // Extend the array using realloc()
    * arr  = (int *)realloc(*arr, sizeof(int)*newSize);
    * size = newSize;
}

void printArrayAndSize(int* arr, int size){

    // Print the array using for loop
    printf("Array size is : %d\n", size);
    printf("Your array is: \n   [ ");
    for(int i=0; i<size; i++){
        printf("%d ", *(arr+i));
    }
    printf("]\n");
}

void arrayInitialize(int* arr, int size){

    // Initialize the array with random values
    printf("Your Array initialized with random values.\n   [ ");
    for (int i=0; i<size; i++) {
        arr[i] = ((rand() % 100) + 1);
        printf("%d ", arr[i]);
    }
    printf("]\n");
}

int arraySum(int* arr, int size){
    int sum = 0;
    // Return the sum of the array
    for(int i=0; i<size; i++){
        sum = sum + arr[i];
    }
    return sum;
}

int arrayAverage(int num, int den){
    int avg = num / den;
    return avg;
}

int main() {
    srand(time(NULL));

    
    int size;
    int* arr_m = NULL;  // array malloc
    int extSize;
    int sum;            // Sum of the elements in the array
    int avg;            // Average of the array

    printf("Enter the size of the array: ");
    scanf("%d",&size);

    arr_m = createDynamicArray(5);

    printArrayAndSize(arr_m, size);
    
    printf("\n");
    arrayInitialize(arr_m, size);

    sum = arraySum(arr_m, size);
    avg = arrayAverage(sum, size);

    printf("\nThe sum of all the elements in the array : %d\n", sum);
    printf("The average of the array : %d\n", avg);

    free(arr_m);

    printf("\nAfter free the memory.\n");
    printArrayAndSize(arr_m, size);

    extSize = 10;
    extendArray(&arr_m, &size, extSize);

    printf("\nAfter extend the memory.\n");
    printArrayAndSize(arr_m, size);

    printf("\n");
    arrayInitialize(arr_m, size);

    free(arr_m);

    /*
    //new_ptr = arr;
    printf("I just extend the array 2 times\n");
    extendArray(&arr , arr, 10);

    for (int j = 5; j < 10; j++){ 
        arr[j] = j + 10;
        //printf("%d ", *(arr + j)); 
    }

    for(int i=0; i<10; i++){
           *(arr+i) = 10 + i;
           printf("%d ", *(arr+i));  
    }
    printf("\n");

    //printf("%ld\n",sizeof(arr));
    free(arr);

    for(int k=0; k<10; k++){
           arr[k] = 10 + k;
           printf("%d ", arr[k]);  
    }
    printf("\n");*/

    return 0;
}
