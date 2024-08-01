#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

int main()
{
   srand(time(NULL)); 

   int rows = 3;
   int cols = 4;
   int row_el = 0;
   int high_value = 0;
   int matrix[rows][cols];
   int (*p_matrix)[cols] = matrix;

   // Initialize the matrix with random values and then print the matrix
   for(int i = 0 ; i<rows; i++)
   { 
       for(int j = 0; j<cols; j++)
       {
           *(*(p_matrix + i) + j) = rand() % 100;
           printf("%d ", *(*(p_matrix + i) + j));
       }
   printf("\n");
   }
   
   //The maximum element in matrix
   for(int x=0; x<rows; x++)
   {
        for(int y=0; y<cols; y++)
        {
            if (matrix[rows][cols] > high_value) {
                high_value = matrix[x][y];}
            else {
                high_value = high_value;}
        }
   }
   printf("\nThe highest value in the matrix is :%d\n\n", high_value);

   // Calculates the sum of each rows.
   for(int k=0; k<rows; k++)
   {
        for(int l=0; l<cols; l++)
        {
            row_el = row_el + matrix[k][l];
        }
        printf("Sum of row %d %d\n", k, row_el);
        row_el = 0;
   }

   return 0;
}
