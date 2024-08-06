#include <stdio.h>

// Functions Prototypes
void swap(int *a, int *b);
void reverseArray(int *arr, int size);

int main(void){
    int a = 5, b = 10;
    printf("Before swap: a = %d, b = %d\n", a, b);
    swap(&a, &b); // Pass addresses of a and 
    printf("After swap: a = %d, b = %d\n", a, b);

    printf("Before Reverse Array: ");
    int arr[] = {1,2,3,4,5,6,7,8,9};
    for (int i=0; i<9; i++){
        printf("%d, ", arr[i]);
    }
    printf("\n");
    reverseArray(arr,9);
    printf("After Reverse Array: ");
    for (int i=0; i<9; i++){
        printf("%d, ", arr[i]);
    }
    printf("\n");
}
