/*
 * ============================================================================
 * Filename:    sequential_multiplier.c 
 * Description: File consists of maze generator and path navigation codes
 * Author:      Bisal Saeed
 * Date:        7/7/2024
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>

// Function to dynamically allocate memory for a maze of given size
int** generateMaze(int mazeSize) {
    // Allocate memory formazeSize rows
    int **maze = (int **)malloc(mazeSize * sizeof(int *));
    //if memory taken from user has size 0 or is null
    if (maze == NULL || mazeSize == 0) {
        printf("Memory allocation failed.\n");
        return NULL; 
    }

    //allocate memory for each row with pointers and for each row allocate memory for columns
    for (int i = 0; i <mazeSize; ++i) {
        maze[i] = (int *)malloc(mazeSize * sizeof(int));
        if (maze[i] == NULL) {
            printf("Memory allocation failed.\n");
             
            // Clean up already allocated memory on failure
            for (int j = 0; j < i; ++j) {
                free(maze[j]);
            }
            free(maze);
            return NULL; // Return NULL on failure
        }

        // Initialize maze elements
        for (int j = 0; j <mazeSize; ++j) {
            // Initialize cols and row (walls and paths) randomly
            maze[i][j] = rand() % 2; // 0 (path) or 1 (wall)
        }
    }
    return maze;
}

// Function to deallocate memory for the maze
void freeMaze(int **maze, int mazeSize) {
    //free each row 
    for (int i = 0; i <mazeSize; ++i) {
        free(maze[i]);
    }

    // free memory for the maze pointer
    free(maze);
}

// Print the maze 
void printMaze(int **maze, int mazeSize) {
    printf("Maze:\n");
    //print like matrix is printed
    for (int i = 0; i <mazeSize; ++i) {
        for (int j = 0; j <mazeSize; ++j) {
            printf("%d ", maze[i][j]);
        }
        printf("\n");
    }
}

// Navigate the maze recursively
int navigateMaze(int *currentPosition, int **maze, int mazeSize) {
    int row = currentPosition[0]; 
    int col = currentPosition[1]; 

    // Check if current position is outside maze boundaries
    //check if row and column allocated or column is outside the defined by being less than 0 or grater than maze size
    if (row < 0 || row >=mazeSize || col < 0 || col >=mazeSize) {
        //out of maze
        return 0; 
    }

    // Check if current position is a wall
    if (maze[row][col] == 1) {
        //deadend case
        return 0; 
    }

    // Check if current position is the exit 
    //at last row and last column -->maze-1
    if (row ==mazeSize - 1 && col ==mazeSize - 1) {
        return 1; 
    }
    // initiate if column is visited mark it by value 3 
    maze[row][col] = 3; 

    // Possible moves 
    int moves[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    for (int i = 0; i < 4; ++i) {
        int new_row = row + moves[i][0];
        int new_col = col + moves[i][1];

        // Recursively navigate to adjacent positions
        if (navigateMaze(&(maze[new_row][new_col]), maze,mazeSize)) {
            return 1; // Found exit through this path
        }
    }
    //Reset path -> backtracking
    maze[row][col] = 0; 

    return 0; 
}


int main() {
   
    int mazeSize; 
    printf("Enter the maze size you want to solve: ");
    scanf("%d",&mazeSize);
    //initiate a matrix pointer named maze
    int **maze;

    // generate a maze with random elements
    maze = generateMaze(mazeSize);
    //print generated maze
    printMaze(maze, mazeSize);

    // Find a path in the maze from the top-left corner (0, 0)
    int startPosition[2] = {0, 0};
    printf("\nFINDING PATH .........\n");
    if (navigateMaze(startPosition, maze, mazeSize)) {
        printf("Path found!\n");
    } else {
        printf("Dead End.\n");
    }
    freeMaze(maze, mazeSize);

    return 0;
}