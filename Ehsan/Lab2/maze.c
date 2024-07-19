#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//following function dynamically allocate memory
int** allocateMemory(int mazeSize) {
    //making pointer that points rows of maze
    int** maze_ptr = (int **)malloc(mazeSize*sizeof(int*));
    //printf("%p\n", (void*)maze_ptr);
    if (maze_ptr == NULL) {
        printf("memory_allocation_failed\n");
        exit(1);
    }
    //allocating space for rows and columns
    for (int i = 0; i < mazeSize; i++) {
        maze_ptr[i] = (int *)malloc(mazeSize * sizeof(int));
        //checking if memory allocated or not, if not deallocate the allocated memory
        if (maze_ptr[i] == NULL) {
            printf("memory_allocation_failed_!\n");
            //deallocating memory
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

//following deallocating memory allocated for maze
void deallocateMaze(int **maze, int mazeSize) {
    for (int i = 0; i < mazeSize; i++) {
            free(maze[i]);
    }
    free(maze);    
}

//following function to navigate the maze using recursion
int navigateMaze(int **maze, int maze_size, int row, int col) {

    //if out of bounds, return 0 
    if (row < 0 || col < 0 || row >= maze_size || col >= maze_size) {
        return 0;
    }

    //if we reached at wall, return 0 
    if (maze[row][col] == 1) {
        return 0;
    }

    //if we reached at the bottom-right corner, return 1 
    if (row == maze_size - 1 && col == maze_size - 1) {
        return 1;
    }
    
    //mark the current cell as explored
    maze[row][col] = 1;
    
    //go adjacent positions: right, down, left, up
    if (navigateMaze(maze, maze_size, row, col + 1) ||
        navigateMaze(maze, maze_size, row + 1, col) ||
        navigateMaze(maze, maze_size, row, col - 1) ||
        navigateMaze(maze, maze_size, row - 1, col)) {
        return 1;
    }
    
}


int main () {
    srand(time(NULL));
    int mazeSize = 3;
    int** maze_ptr = allocateMemory(mazeSize);
    initializeMazeElements(maze_ptr,mazeSize);
    printMaze(maze_ptr, mazeSize);
    
    if (navigateMaze(maze_ptr, mazeSize, 0, 0)) {
        printf("Path found.\n");
    } else {
        printf("Path not found.\n");
    }
    deallocateMaze(maze_ptr, mazeSize);
    return 0;
}