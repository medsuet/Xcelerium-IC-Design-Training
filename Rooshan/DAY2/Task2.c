#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
int initializeMatrix(int rows,int cols,int (*matrix)[cols]);
int printMatrix(int rows,int cols,int (*matrix)[cols]);
int findMaxInMatrix(int rows,int cols,int (*matrix)[cols]);
int main() {
    int rows,columns;
    printf("Enter the dimensions of the matrix");
    scanf(" %d %d",&rows,&columns);
    int Matrix[rows][columns];
    initializeMatrix(rows,columns,Matrix);
    printf("The matrix is\n");
    printMatrix(rows,columns,Matrix);
    printf("The Maximum element of the matrix is %d",findMaxInMatrix(rows,columns,Matrix));
}
int initializeMatrix(int rows,int cols,int (*matrix)[cols]){
    srand(time(0));
    for (int i=0;i<rows;++i){
        for (int j=0;j<cols;++j){
            *(*(matrix+i)+j)=(rand()%100+1);
        }
    }
    return 1;
}
int printMatrix(int rows,int cols,int (*matrix)[cols]){
    for (int i=0;i<rows;++i){
        for (int j=0;j<cols;++j){
            printf("%d ",*(*(matrix+i)+j));
        }
        printf("\n");
    }
    return 1;    
}
int findMaxInMatrix(int rows,int cols,int (*matrix)[cols]){
    int max=-1;
    for (int i=0;i<rows;++i){
        for (int j=0;j<cols;++j){
            if (*(*(matrix+i)+j)>max){
                max=*(*(matrix+i)+j);
            }
        }
    }
    return max;    
}
