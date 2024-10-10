//********Author: Masooma Zia********
//********Date: 10-07-2025********
//********Description: Maze Code Lab2 -C language Task
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//Used to initialize a 2d array with 0 and 1 in random sequence
void initializeMatrix(int rows, int cols, int **maze) {
    srand(time(NULL)); 
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            maze[i][j] = rand() % 2;
        }
    }
    maze[0][0] = 0; //Entrance should be a path
    maze[rows - 1][cols - 1] = 0; //Exit should be a path
}

// Function used to print all the elements of matrix using pointer to matrix
void printMatrix(int rows, int cols, int **maze) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            printf("%d ", maze[i][j]);
        }
        printf("\n");
    }
}
//Function used to allocate the memory for 2d array(maze)
int** allocateMaze(int maze_size) {
    int **maze = (int **)malloc(maze_size*sizeof(int *));
    for (int i = 0; i < maze_size; i++) {
        maze[i] = (int *)malloc(maze_size*sizeof(int));
    }
    return maze;
}
//Function used to free the memory allocated for maze
void freeMaze(int **maze, int maze_size) {
    for (int i = 0; i < maze_size; i++) {
        free(maze[i]);
    }
    free(maze);
}
//Function for finding the path for exit otherwise if no path found then deadend
int navigateMaze(int **maze, int maze_size, int *current_pointer) {
    int row = current_pointer[0];
    int col = current_pointer[1];
    //Boundary condition
    if (row < 0 || row >= maze_size || col < 0 || col >= maze_size) {
        return 0;
    }
    //Dead end
    if (maze[row][col] == 1) {
        return 0;
    }
    //Checking for last row and last column (exit found)
    if (row == maze_size - 1 && col == maze_size - 1) {
        return 1;
    }
    maze[row][col] = 1;
    int new_pointer[2];
    //right
    new_pointer[0] = row;
    new_pointer[1] = col + 1;
    if (navigateMaze(maze, maze_size, new_pointer) == 1) {
        return 1;
    }
    //down
    new_pointer[0] = row + 1;
    new_pointer[1] = col;
    if (navigateMaze(maze, maze_size, new_pointer) == 1) {
        return 1;
    }
    //left
    new_pointer[0] = row;
    new_pointer[1] = col - 1;
    if (navigateMaze(maze, maze_size, new_pointer) == 1) {
        return 1;
    }
    // up
    new_pointer[0] = row - 1;
    new_pointer[1] = col;
    if (navigateMaze(maze, maze_size, new_pointer) == 1) {
        return 1;
    }
    maze[row][col] = 0;

    return 0;
}

int main() {
    int maze_size;
    printf("Enter maze size: ");
    scanf("%d", &maze_size);

    int **maze = allocateMaze(maze_size);

    initializeMatrix(maze_size, maze_size, maze);
    printMatrix(maze_size, maze_size, maze);

    int start_pointer[2] = {0, 0};
    if (navigateMaze(maze, maze_size, start_pointer) == 1) {
        printf("Exit found!\n");
    } else {
        printf("No exit found.\n");
    }

    freeMaze(maze, maze_size);
    return 0;
}
