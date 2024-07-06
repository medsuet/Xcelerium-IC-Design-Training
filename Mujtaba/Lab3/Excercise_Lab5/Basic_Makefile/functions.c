#include <stdio.h>

void swap(int *a, int *b) {
    // TODO: Implement swap function
    int temp;
    temp = *a;
    *a = *b;
    *b = temp;
}

void reverseArray(int *arr, int size) {
    // TODO: Implement array reversal using pointers
    for (int i=0; i<size/2; i++){
        swap(&arr[i], &arr[size-i-1]);
    }
}
