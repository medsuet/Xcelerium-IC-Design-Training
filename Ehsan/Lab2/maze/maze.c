#include <stdio.h>
#include <stdlib.h>

//following function dynamically allocate memory
int** allocateMemory(int mazeSize) {
    // Making pointer that points rows of maze
    int** maze_ptr = (int **)malloc(mazeSize*sizeof(int*));
    printf("%p\n", (void*)maze_ptr);
    if (maze_ptr == NULL) {
        printf("memory_allocation_failed\n");
        exit(1);
    }
    // Allocating space for rows and columns
    for (int i = 0; i < mazeSize; i++) {
        maze_ptr[i] = (int *)malloc(mazeSize * sizeof(int));
        // Checking if memory allocated or not, if not deallocate the allocated memory
        if (maze_ptr[i] == NULL) {
            printf("memory_allocation_failed_!\n");
            // Deallocating memory
            for (int j = 0; j < i; j++) {
                free(maze_ptr[j]);
            }
            free(maze_ptr);
            exit(1);
        }
    }
    return maze_ptr;
}
//following function intialize the maze elements walls and paths
void initializeMazeElements(int **maze, int mazeSize) {
    for (int i = 0; i < mazeSize; i++) {
        for (int j = 0; j < mazeSize; j++) {
            maze[i][j] = rand() % 2;
        }
    }
}

//following function print maze
void printMaze(int **maze, int mazeSize) {
    for (int rows=0; rows<mazeSize; rows++) {
        for (int cols=0; cols<mazeSize; cols++) {
            printf("%d ",(maze[rows][cols]));
        }
        printf("\n");
    }    
}

int navigateMaze(int **maze, int mazeSize) {

    
}



int main () {
    int mazeSize = 5;
    int** ptr = allocateMemory(mazeSize);
    initializeMazeElements(ptr,mazeSize);
    printMaze(ptr, mazeSize);
    navigateMaze(ptr,mazeSize);
    
}