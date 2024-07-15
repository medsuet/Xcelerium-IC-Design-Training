#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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

int deallocateMaze(int **maze, int mazeSize) {
    for (int i = 0; i < mazeSize; i++) {
            free(maze[i]);
    }
    free(maze);
    
}

// Function to navigate the maze using recursion
int navigate_maze(int **maze, int maze_size, int row, int col) {
    // Base case: if out of bounds or if it's a wall, return 0 (dead end)
    if (row < 0 || col < 0 || row >= maze_size || col >= maze_size || maze[row][col] == 1) {
        return 0;
    }
    
    // If we have reached the bottom-right corner, return 1 (success)
    if (row == maze_size - 1 && col == maze_size - 1) {
        return 1;
    }
    
    // Mark the current cell as part of the path
    maze[row][col] = 1;
    
    // Explore adjacent positions: right, down, left, up
    if (navigate_maze(maze, maze_size, row, col + 1) ||
        navigate_maze(maze, maze_size, row + 1, col) ||
        navigate_maze(maze, maze_size, row, col - 1) ||
        navigate_maze(maze, maze_size, row - 1, col)) {
        return 1;
    }
    
    // If none of the adjacent positions lead to the exit, unmark the current cell
    maze[row][col] = 0;
    return 0;
}



int main () {
    srand(time(NULL));
    int mazeSize = 5;
    int** maze = allocateMemory(mazeSize);
    initializeMazeElements(maze,mazeSize);
    int current_position[] = {0,0};
    maze[0][0] = 1;
    maze[mazeSize - 1][mazeSize - 1] = 0;
    printMaze(maze, mazeSize);

    //navigateMaze(current_position,ptr,mazeSize);
    
    if (navigate_maze(maze, mazeSize, 0, 0)) {
        printf("Path found!\n");
    } else {
        printf("Path not found.\n");
    }
    printf("Maze after navigation:\n");
    deallocateMaze(maze, mazeSize);
    return 0;
    
}