#include<stdio.h>

void insertionSort(int *array, int size){
    for (int iteration = 0; iteration < size - 1; iteration++){
        int index = iteration;
        int nextIndex = iteration + 1;
        for (int comparison = 0; comparison < (iteration + 1); comparison++)
        {
            if (*(array + index) > *(array + nextIndex)){
                int temporaryVariable = *(array + index);
                *(array + index) = *(array + (nextIndex));
                *(array + (nextIndex)) = temporaryVariable;
            }
            index -= 1;
            nextIndex -= 1;
        }
    }
}

int main(void){
    int array[10] = {25, 10, 15, 7, 30,34,3,67,35,12};
    printf("Unsorted Array: ");
    for (int iteration = 0; iteration < 10; iteration ++ ){
        printf("%d ", array[iteration]);
    }
    printf("\n");
    insertionSort(array, 10);
    printf("Sorted Array: ");
    for (int iteration = 0; iteration < 10; iteration ++ ){
        printf("%d ", array[iteration]);
    }
    printf("\n");
}