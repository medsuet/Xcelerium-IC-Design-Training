#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void swap(int *a, int *b){
    int temp_value = *a;
    int *temp_ptr = &temp_value;
    *a     = *b;
    *b     = *temp_ptr;
}

void bubble_sort(int *arr, int size){

    //this loop is use to recheck the sorting
    for(int i=0; i<(size-1); i++){

        // This loop is use to swaping the maximum value of the array
        for (int j=0; j<(size-1); j++){

            if ((*(arr+j)) > (*(arr+j+1))){
                swap((arr+j), (arr+j+1));
            }
            else {
                (*(arr+j)) = (*(arr+j));
            }
        }
    }
}

void selectionSort(int *arr, int size) {
    int i, j, min_idx;

    // One by one move boundary of unsorted subarray
    for (i = 0; i < (size-1); i++)
    {
        // Find the minimum element in unsorted array
        min_idx = i;
        for (j = i+1; j < size; j++)
          if (*(arr+j) < *(arr+min_idx))
            min_idx = j;

        // Swap the found minimum element with the first element
           if(min_idx != i)
            swap((arr+min_idx), (arr+i));
    }
}

// Calculator functions
int add(int a, int b) { return a + b; }
int subtract(int a, int b) { return a - b; }
int multiply(int a, int b) { return a * b; }
int divide(int a, int b) { return b != 0 ? a / b : 0; }

void printarray(int *arr, int size){
    for (int i=0; i<size; i++){
        printf("%d ", *(arr+i));
    }
    printf("\n");
}

int main()
{
    int arr[] = {6,2,3,5};
    int arr_len = sizeof(arr) / sizeof(int);    // length of the array

    void (* bs_ptr)(int *, int);                // bubble sort function pointer
    void (* ss_ptr)(int *, int);                // selection sort funtion pointer

    int (* add_func)(int, int);                 // add function pointer
    int (* sub_func)(int, int);                 // subtract function pointer
    int (* mul_func)(int, int);                 // multiply function pointer
    int (* div_func)(int, int);                 // divide function pointer

    add_func = add;
    sub_func = subtract;
    mul_func = multiply;
    div_func = divide;

    printf("Sum :%d\n", add_func(3,21));
    printf("Subtract :%d\n", sub_func(3,21));
    printf("Multiply :%d\n", mul_func(3,21));
    printf("Divide :%d\n", div_func(3,21));

    ss_ptr = selectionSort;
    bs_ptr = bubble_sort;

    printf("Array Length: %d\n", arr_len);
    printarray(arr, arr_len);

    ss_ptr(arr, arr_len);
    printarray(arr, arr_len);

    bs_ptr(arr, arr_len);    
    printarray(arr, arr_len);

    return 0;
}