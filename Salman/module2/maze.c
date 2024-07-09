#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>


// declaring an global pointer to keep track of maze_size
// to avoid leaving maze boundaries
// dimensions w/o providing argument to function
int* size_ptr;

int navigateMaze(int* current_position, int** maze){
    // TODO: To navigate maze through pointers recursively, and return 0(dead end) or 1(exit found)

    int row = current_position[0];
    int col = current_position[1];
    int up[] = {row-1,col};
    int down[] = {row+1,col};
    int left[] = {row,col-1};
    int right[] = {row,col+1};

    // base case: if current position is an exit
    if (( row == *size_ptr - 1) & ( col == *size_ptr - 1))
        {
            return 1; // found exit
        }

    // if current position is out of bounds
    if ( (row<0) | (col<0) | (row >= *size_ptr) | (col >= *size_ptr) )
        {
            return 0; // out of bounds
        }

    // if current position is wall - dead end
    if ( (* ( *(maze + row) + col) == 1 ) )
        {
            return 0; // dead end
        }

    // node used - set as wall - no cycle wastage
    *(*(maze + row) + col) = 1;

    // no base condition true - parse up,down,left,right
    return ( navigateMaze(up,maze) | navigateMaze(down,maze) | navigateMaze(left,maze) | navigateMaze(right,maze) );

}

void allocate2DArray(int rows, int cols){
    // TODO: Allocate 2D Array using Callocs or Mallocs
    int i = 0;
    int j = 0;

    size_ptr = &rows;
//    printf("\n%d\n",*size_ptr);

    // allocating space equal to represent rows
    int** maze = (int **) malloc(rows * sizeof(int*));                              // double pointer since each element is pointer
    int** starting_position = maze;
    if (maze == NULL)
        {
            printf("\nAllocation Failed!\n");
            exit(0);
        }

    printf("\nAdding memory storage element for each row\n");
    // allocating space for elements within each row
    for (i=0; i<rows; i++)
        {
            *(maze + i) = (int *) malloc(cols * sizeof(int));                       // allocating another malloc for each element
            if (*(maze + i) == NULL)
                {
                    printf("\nMemory Allocation Failed for Row %d\n",i);
                    exit(0);
                }
        }

    printf("\nInitializing the matrix!\n");
    int temp;
//    int count = 1;
    for (i=0; i<rows; i++)
        {
            for (j=0; j<cols; j++)
                {                                                                   // inner pointer: row traversal, outer pointer: for columns
                    *( *(maze+i) + j) = rand() % 2;                                 // randomly allocating 0's and 1's
//                    count++;
                }
        }

    *(*(maze)) = 0;                             // start of maze should be 0
    *( *(maze+ (rows-1)) + (cols-1) ) = 0;      // end of maze should be 0


    printf("\nThe initialized matrix is\n");
    *maze = *starting_position;
    for (i=0; i<rows; i++)
        {
            printf("[");
            for (j=0; j<cols; j++)
                {
                    printf("%d ", * ( *(maze + i) + j) );                          // printing the matrix
                }
            printf("]\n");
        }

    int start[] = {0,0};

    if ( navigateMaze(start,maze) == 1)
        {
            printf("\nSuccess! Path Found!\n");
        }
    else
        {
            printf("\nFailure! No paths found to exit\n");
        }


    //freeing the array after use
    for (i=0; i<rows; i++)
        {
            free(*(maze+i));
        }

    free(maze);
}

void main(){
    srand(time(NULL));

    int maze_size;

    printf("\nEnter the size of maze: ");
    scanf("%d",&maze_size);

    printf("\nAllocating 2D Array for Maze!\n");

    allocate2DArray(maze_size,maze_size);

}











