#include <stdio.h>
#include <stdlib.h>

int** CreateDynamicArray2D(int maze_size){
    int **arr_ptr = (int **)malloc(maze_size*sizeof(int *));

    for (int i = 0; i < maze_size; i++) {
        arr_ptr[i] = (int*)malloc(maze_size * sizeof(int));
    }
    return arr_ptr;
}

void initializeDArray(int** DArray, int maze_size){
    for (int i=0; i<maze_size; i++){
        for (int j=0; j<maze_size; j++){
            DArray[i][j] = rand() % 2; 
        }
    }
}

void freeMemory(int** DArray, int maze_size){
    for (int i=0; i<maze_size; i++){
        free(DArray[i]);
    }
    free(DArray);
}

void printArray2D(int **DArray, int maze_size){
    for (int i=0; i<maze_size; i++){
        for (int j=0; j<maze_size; j++){
            printf("%d ", DArray[i][j]);
        }
        printf("\n");
    }
}

// Function to navigate the maze
int navigateMaze(int *current_position, int **DArray, int maze_size) {
    // Extract the current row and column from the current position
    int crow = (*current_position / maze_size);
    int ccol = (*current_position % maze_size);
    // printf("crow: %d ccol: %d ", crow, ccol);

    // Check if the current cell is a wall (1)
    if (DArray[crow][ccol] == 1) {
        return 1;
    }

    // Check if the current cell is the exit (bottom-right corner)
    if (crow == maze_size - 1 && ccol == maze_size - 1) {
        return 2;
    }

    // Move to the next cell (right or down)
    int new_crow = crow;
    int new_ccol = ccol;

    if (ccol < maze_size - 1) {
        new_ccol++;
    } else if (crow < maze_size - 1) {
        new_crow++;
    } else {
        return 1; // No more moves available
    }

    // Update the current position
    *current_position = new_crow * maze_size + new_ccol;

    // Recursively navigate the maze
    return navigateMaze(current_position, DArray, maze_size);
}

int main(void){
    int maze_size;
    int maze_status;
    int current_position;
    printf("Enter the size of maze: ");
    scanf("%d", &maze_size);
    printf("Creating the 2D Array......\n");
    int **DArray = CreateDynamicArray2D(maze_size);
    printf("Done\n");
    printf("Creating the maze.......\n");
    initializeDArray(DArray, maze_size);
    printf("Done\n");
    printf("Showing Maze......\n");
    printArray2D(DArray, maze_size);
    printf("Done\n");
    printf("From where you want to start?? (Remember: The elements are accessed from 0 instead of 1) ");
    scanf("%d", &current_position);
    printf("Solving the maze......\n");
    maze_status = navigateMaze(&current_position, DArray, maze_size);
    if (maze_status == 0){
        printf("No more moves!\n");
    }else if (maze_status == 1){
        printf("Hit a Wall. Dead End\n");
    } else if (maze_status == 2){
        printf("Successfully Solved. Reached to the end.\n");
    }
    freeMemory(DArray, maze_size);
    return 0;
}