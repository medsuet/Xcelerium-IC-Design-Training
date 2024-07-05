#include <stdio.h>
#include <stdlib.h>

int main() {
    size_t size = 9; // Initial size of the array
    int *ptr = (int *)malloc(size * sizeof(int));
    if (ptr == NULL) {
        printf("Memory allocation failed\n");
        return 1;
    }

    for (size_t i = 0; i < size; i++) {
        ptr[i] = i + 1;
    }

    // Print the array before freeing
    printf("Array before freeing: ");
    for (size_t i = 0; i < size; i++) {
        printf("%d ", ptr[i]);
    }
    printf("\n");

    // Free the allocated memory
    free(ptr);

    // Attempt to print the array after freeing
    printf("Array after freeing: ");
    for (size_t i = 0; i < size; i++) {
        printf("%d ", ptr[i]);
    }
    printf("\n");

    return 0;
}
