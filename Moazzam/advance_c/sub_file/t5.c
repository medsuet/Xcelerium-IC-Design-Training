#include <stdio.h>
#include <stdlib.h>

int* mem_ptr;

int* createDynamicArray(int size) {
    // TODO: Allocate memory for an array of integers
    int* memory = (int*)malloc(size * sizeof(int));
    return memory;
}

void extendArray(int** arr, int newSize) {
    // TODO: Extend the array using realloc()
    int* temp = (int*)realloc(*arr, newSize * sizeof(int));
    if (temp == NULL) {
        printf("Memory reallocation failed\n");
        exit(1);
    }
    *arr = temp;
}

// Memory leak detector
void* allocateMemory(size_t size) {
    // TODO: Allocate memory and keep track of it
}

void freeMemory(void* ptr) {
    // TODO: Free memory and update tracking
}

void checkMemoryLeaks() {
    // TODO: Check for memory leaks
}

int main(){
    int size = 5;
    int *memory = createDynamicArray(size); 
    int *starting_address = memory;
    
    for(int i=0; i<size; i++){
        *memory = i;
        memory += 1;
    }

    memory = starting_address;
    printf("before realloc array: ");
    for(int i=0; i<size; i++){
        printf("%d ", *memory);
        memory += 1;
    }
    printf("\n");

    // Extend the array
    int newSize = 10;
    extendArray(&starting_address, newSize);

    // Initialize the new elements
    memory = starting_address+size;
    for (int i = 5; i < newSize; i++) {
        *memory = i;
        memory += 1;
    }

    memory = starting_address;
    // Print the extended array
    printf("Extended array: ");
    for (int i = 0; i < newSize; i++) {
        printf("%d ", *memory);
        memory += 1;
    }
    printf("\n");

    memory = starting_address;
    free(memory);

    void *mem_address = allocateMemory(10);

    mem_ptr = mem_address;

    freeMemory(mem_address);
    mem_ptr = NULL;

    checkMemoryLeaks();


    return 0;
}
 