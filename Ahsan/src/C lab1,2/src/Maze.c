#include <stdio.h>
#include <stdlib.h>

// Function to dynamically allocate memory for a 2D maze
int** allocateMaze(int size) {
    int** maze = (int**)malloc(size * sizeof(int*));
    for (int i = 0; i < size; i++) {
        maze[i] = (int*)malloc(size * sizeof(int));
    }
    return maze;
}

// Function to free the dynamically allocated memory for the maze
void freeMaze(int** maze, int size) {
    for (int i = 0; i < size; i++) {
        free(maze[i]);
    }
    free(maze);
}

// Function to initialize the maze with predefined values
void initializeMaze(int** maze, int size) {
    int initial_maze[5][5] = {
        {0, 1, 0, 0, 0},
        {0, 1, 1, 1, 0},
        {0, 0, 0, 1, 0},
        {1, 1, 0, 1, 0},
        {0, 0, 0, 0, 0}
    };

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            maze[i][j] = initial_maze[i][j];
        }
    }
}

// Function to print the maze (for debugging purposes)
void printMaze(int** maze, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d ", maze[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

// Function to navigate the maze
int navigateMaze(int row, int col, int** maze, int size) {
    // Check boundaries and wall condition
    if (row < 0 || row >= size || col < 0 || col >= size || maze[row][col] == 1) {
        return 0; // Out of bounds or wall
    }

    // Check if the exit is reached
    if (row == size - 1 && col == size - 1) {
        return 1; // Success
    }

    // Mark the current position as visited by using a different value (e.g., 2)
    maze[row][col] = 2;

    // Explore adjacent positions in a different order: right, down, left, up
    if (navigateMaze(row, col + 1, maze, size) || // Move right
        navigateMaze(row + 1, col, maze, size) || // Move down
        navigateMaze(row, col - 1, maze, size) || // Move left
        navigateMaze(row - 1, col, maze, size)) { // Move up
        return 1; // Found the exit
    }

    // Unmark the current position (backtrack)
    maze[row][col] = 0;

    return 0; // Dead end
}

int main() {
    int maze_size = 5;
    int** maze = allocateMaze(maze_size);

    // Initialize the maze
    initializeMaze(maze, maze_size);

    // Print the initial maze
    printf("Initial Maze:\n");
    printMaze(maze, maze_size);

    // Starting position
    int start_row = 0, start_col = 0;

    // Navigate the maze
    if (navigateMaze(start_row, start_col, maze, maze_size)) {
        printf("Successfully found the exit!\n");
    } else {
        printf("No escape found.\n");
    }

    // Print the maze after navigation attempt
    printf("Maze after navigation attempt:\n");
    printMaze(maze, maze_size);

    // Free the dynamically allocated memory
    freeMaze(maze, maze_size);

    return 0;
}
