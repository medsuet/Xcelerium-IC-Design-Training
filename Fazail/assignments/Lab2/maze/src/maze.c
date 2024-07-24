#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "functions.h"

// Dynamically Allocate Memory for the array of pointers
int** allocate2DMemory( int mazeSize){

	int** array = NULL;
	
	// make the array of pointers for the starting address of row
	array = (int**) malloc (mazeSize * sizeof(int *));
	if (array == NULL) {
        fprintf(stderr, "Memory allocation failed for rows\n");
    }

	// allocate the memory of each row row contains i.e column size
	for (int i=0; i< mazeSize; i++) {
		*(array + i) =  (int *)malloc(mazeSize * sizeof(int));
		if (*(array + i) == NULL) {
            fprintf(stderr, "Memory allocation failed for row %d\n", i);
            // Free the already allocated memory before returning
            for (int j = 0; j < i; j++) {
                free(array[j]);
            }
            free(array);
		}
	}
	return array;
	
}

// free the 2D array
void free2DArray(int **array, int mazeSize) {
    for (int i = 0; i < mazeSize; i++) {
        free(array[i]);
    }
    free(array);
}

// Function to initialize the 2D array
void randomInitialize2DArray(int **array, int mazeSize, int mazedata[mazeSize][mazeSize]) {
    for (int i = 0; i < mazeSize; i++) {
        for (int j = 0; j < mazeSize; j++) {
            *(*(array + i) +j) = mazedata[j][i];
        }
    }
    
}

// Function to print the 2D array
void print2DArray(int **array, int mazeSize) {
	for(int i=0; i< mazeSize; i++) {
		for (int j = 0; j < mazeSize; j++) {
            // *(*(array + i) +j) = i*j;
            printf("%d ",  *(*(array + i) +j));
        }
        printf("\n");
	}
}

// Function to navigate the maze
int navigateMaze(int **maze, int mazeSize, int *current_position) {
    int row = current_position[0];
    int col = current_position[1];

    // Check boundaries
    if (row < 0 || row >= mazeSize || col < 0 || col >= mazeSize) {
        return DEAD_END;
    }

    // Check if the current position is a wall
    if (maze[row][col] == WALL) {
        return DEAD_END;
    }

    // Check if the current position is the exit (e.g., bottom-right corner)
    if (row == mazeSize - 1 && col == mazeSize - 1) {
        return SUCCESS;
    }

    // Mark the current position as visited (to avoid loops)
    maze[row][col] = WALL;

    // Explore adjacent positions (up, down, left, right)
    int new_position[2];

    // Down
    new_position[0] = row + 1;
    new_position[1] = col;
    if (navigateMaze(maze, mazeSize, new_position) == SUCCESS) {
        return SUCCESS;
    }

    // Up
    new_position[0] = row - 1;
    new_position[1] = col;
    if (navigateMaze(maze, mazeSize, new_position) == SUCCESS) {
        return SUCCESS;
    }

    // Right
    new_position[0] = row;
    new_position[1] = col + 1;
    if (navigateMaze(maze, mazeSize, new_position) == SUCCESS) {
        return SUCCESS;
    }

    // Left
    new_position[0] = row;
    new_position[1] = col - 1;
    if (navigateMaze(maze, mazeSize, new_position) == SUCCESS) {
        return SUCCESS;
    }

    // Unmark the current position before backtracking
    maze[row][col] = PATH;

    return DEAD_END;
}

int main(void) {
    srand(time(NULL));
   
    int mazeSize = 5 ;
    int currentPosition[2];
    int ** maze = NULL;			// maze matrix
    
    int mazedata[5][5] = {
        {0, 1, 0, 0, 0},
        {0, 1, 0, 1, 0},
        {0, 0, 0, 1, 0},
        {0, 1, 1, 1, 0},
        {0, 0, 0, 0, 0}
    };
    
    
    currentPosition[0] = 0; 	// Row
    currentPosition[1] = 0;		// Column
    
    // i write row manually because using random function it very difficult 
    // to find the correct case
    
	maze = allocate2DMemory ( mazeSize );
	
    randomInitialize2DArray ( maze, mazeSize, mazedata );

	print2DArray ( maze, mazeSize );
	
	if( navigateMaze( maze, mazeSize, currentPosition) == SUCCESS){
		printf("\n>>>> Sucessfully Reached <<<< \n");
	}
	else {
		printf("\nOOPS!!! :( Stuck some where!!\nI want to reached the bottom the right corner. So the exit is off!!\n");
	}

    return 0;
}

