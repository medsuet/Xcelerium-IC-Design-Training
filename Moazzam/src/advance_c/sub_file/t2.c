#include <stdio.h>
#include <time.h>
#include <stdlib.h>

void initializeMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Initialize matrix with random values
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            *(*(matrix + i) + j) = ((rand() % (99 - 10 + 1)) + 10); 
            //rand() % (upper_bound - lower_bound + 1) + lower_bound; 
        }
    }
}

void printMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Print the matrix
    printf("The matrix of %dx%d of random number is given as:\n",rows, cols);
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            printf("%d ",*(*(matrix + i) + j)); 
        }
        printf("\n");
}
}

int findMaxInMatrix(int rows, int cols, int (*matrix)[cols]) {
    // TODO: Find and return the maximum element in the matrix
    int max = 0;
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            if(max<*(*(matrix + i) + j)){
                max = *(*(matrix + i) + j);
            }
        }
    }
    //printf("the max number in the given matrix is %d.\n", max);
    return max;
}

void addrows(int rows, int cols, int (*matrix)[cols]){
    int max = 0;
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            max += *(*(matrix + i) + j);
        }
    printf("the addition of %d row in the given matrix is %d.\n", i+1, max);
    max = 0;
    }
}

int main(){
    srand(time(NULL));
    int rows  = 3;
    int cols = 4;
    int matrix[rows][cols];
    
    initializeMatrix(rows, cols, matrix);
    printMatrix(rows, cols, matrix);
    printf("the max number in the given matrix is %d.\n", findMaxInMatrix(rows, cols, matrix));

    addrows(rows, cols, matrix);
    return 0;
}