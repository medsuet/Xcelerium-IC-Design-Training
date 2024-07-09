#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void allocate2DArray(int rows, int cols){
    // TODO: Allocate 2D Array using Callocs or Mallocs
    int i = 0;
    int j = 0;

    int** maze = (int **) calloc(rows,cols*sizeof(int*));
    int** starting_position = maze;

    printf("\nAdding memory storage element for each row\n");

    for (i=0; i<rows; i++)
        {
            *maze = (int *) calloc(cols, sizeof(int))   ;                           // to initialize each element of calloc array as calloc
            maze++;                                                             // each calloc will represent elements in row
        }

    printf("\nInitializing the matrix!\n");

    for (i=0; i<rows; i++)
        {
            for (j=0; j<cols; j++)
                {
                    printf("Enter the number %d%d",i,j);
                    scanf("%d", *(( *(maze+i) + j)) );                           // entering elements into each row and column, one by one
                }
        }

    printf("\nThe initialized matrix is\n");

    for (i=0; i<rows; i++)
        {
            printf("[");
            for (j=0; j<cols; j++)
                {
                    printf("%d", (( *(maze+i) + j)) );                          // printing the matrix
                }
            printf("]\n");
        }
}