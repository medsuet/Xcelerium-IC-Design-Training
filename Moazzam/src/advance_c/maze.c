#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int** createDynamicMatrix(int maze_size) {
    // TODO: Allocate matrix for an array of integers
    int** matrix = (int**)malloc(maze_size * sizeof(int*));
    for (int i = 0; i < maze_size; i++)
        matrix[i] = (int*)malloc(maze_size * sizeof(int));
    return matrix;
}

void initializeMatrix(int rows, int cols, int **matrix) {
    // TODO: Initialize matrix with random values
    int element[rows];
    for(int i = 0; i<rows; i++){
        //printf("Enter total %d element of %d row: ", rows,i+1);
        //for(int i = 0; i < rows; ++i) {
        //    scanf("%d", &element[i]);
        //}
        for(int j = 0; j<cols; j++){
            *(*(matrix + i) + j) = rand() % 2; 
        }
    }
}

void printMatrix(int rows, int cols, int **matrix) {
    // TODO: Print the matrix
    printf("The matrix of %dx%d of random number is given as:\n",rows, cols);
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<cols; j++){
            printf("%d ",*(*(matrix + i) + j)); 
        }
        printf("\n");
    }
}
// Function to navigate the maze
int navigate_maze(int* current_position, int** maze, int maze_size) {
    int row = current_position[0];
    int col = current_position[1];

    // Check if the current position is out of bounds return 0
    if (row < 0 || row >= maze_size || col < 0 || col >= maze_size) {
        return 0; // Dead end
    }

    // Check if the current element is a wall
    if (maze[row][col] == 1) {
        return 0; // Dead end and if first number is 1 so start is aslo dead end
    }

    // Check if we have reached the exit (bottom-right corner)
    if (row == maze_size - 1 && col == maze_size - 1) {
        return 1; // Success
    }

    // Mark the current path as visited to avoid cycles
    maze[row][col] = 1;

    // Define the possible movements (down, up, right, left)
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    // Explore adjacent positions recursively
    for (int i = 0; i < 4; i++) {
        int new_row = row + directions[i][0];
        int new_col = col + directions[i][1];
        int new_position[2] = {new_row, new_col};

        if (navigate_maze(new_position, maze, maze_size)) {
            return 1; // Success
        }
    }

    // Unmark the current path (backtracking)
    maze[row][col] = 0;

    return 0; // Dead end
}

int main(){
    srand(time(NULL));
    int maze_size = 5 ;
    int sel;
    int **matrix;
    int **starting_address;

    printf("Welcome to Maze Game!\n");
    printf("Enter: 1(for pre-build maze matrix), Enter:2(for random maze matrix)\n");
    scanf("%d", &sel);

    if (sel == 1){
        matrix = createDynamicMatrix(maze_size); 
        starting_address = matrix;

        //Initialize the maze (1 = wall, 0 = path)
        int element[5][5] = {
            {0, 1, 0, 0, 0},
            {0, 0, 0, 1, 0},
            {0, 1, 0, 1, 0},
            {0, 1, 0, 0, 0},
            {1, 1, 0, 1, 0}
        };
        
        //put values in maze
        for(int i = 0; i<maze_size; i++){
            for(int j = 0; j<maze_size; j++){
                *(*(matrix + i) + j) = element[i][j]; 
            }
        }
    }
    


    else if(sel == 2){
        printf("Enter maze_size of maze: ");
        scanf("%d", &maze_size);
        matrix = createDynamicMatrix(maze_size); 
        starting_address = matrix;


        initializeMatrix(maze_size,maze_size,starting_address);

    }

    printMatrix(maze_size,maze_size, starting_address);

    int start_position[2] = {0, 0};
    // Navigate the maze
    if (navigate_maze(start_position, starting_address, maze_size)) {
        printf("Found a path to the exit!\n");
    } else {
        printf("No path to the exit.\n");
    }

    //printMatrix(maze_size,maze_size, matrix);

    free(matrix);
    return 0;
}
