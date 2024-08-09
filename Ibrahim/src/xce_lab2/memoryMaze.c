#include <stdio.h>
#include <stdlib.h>

// Function prototypes
void allocateMaze(int ***maze, int maze_size);
void freeMaze(int **maze, int maze_size);
void printMaze(int **maze, int maze_size);
int navigateMaze(int **maze, int *current_position, int maze_size);

int main() {
    int maze_size;
    int **maze;

    // Define starting position in the maze
    int start_x = 0, start_y = 0;
    int current_position[2] = {start_x, start_y}; 

    // Read maze size
    printf("Enter the size of the maze (4 or above) (e.g., 4 for a 4x4 maze): ");
    scanf("%d", &maze_size);

    // Allocate memory for the maze
    allocateMaze(&maze, maze_size);

    // Initialize the maze with example values (0 for path, 1 for wall)
    for (int i = 0; i < maze_size; i++) {
        for (int j = 0; j < maze_size; j++) {
            maze[i][j] = 0; // Set all paths initially
        }
    }

    // Set some walls for the example
    maze[0][1] = 1;
    maze[1][1] = 1;
    maze[2][1] = 1;
    maze[3][1] = 1;

    // Print the maze
    printf("Maze:\n");
    printMaze(maze, maze_size);

    // Navigate the maze
    if (navigateMaze(maze, current_position, maze_size)) {
        printf("Exit found!\n");
    } else {
        printf("No exit found.\n");
    }

    // Free the allocated memory
    freeMaze(maze, maze_size);

    return 0;
}

// Function to allocate memory for the maze
void allocateMaze(int ***maze, int maze_size) {
    
    // Allocate an array of pointers
    *maze = (int **)malloc(maze_size * sizeof(int *));

    // Allocate an array of int for every pointer in above array
    for (int i = 0; i < maze_size; i++) {
        (*maze)[i] = (int *)malloc(maze_size * sizeof(int));
        //  if (maze[i] == NULL) {
        //     printf("Memory allocation failed.\n");
    }
}

// Function to free the allocated memory for the maze
void freeMaze(int **maze, int maze_size) {
    
    // Free the pointers to rows first
    for (int i = 0; i < maze_size; i++) {
        free(maze[i]);
    }

    // Free the pointer to array of pointers
    free(maze);
}

// Function to print the maze
void printMaze(int **maze, int maze_size) {
    
    // Iterate each through each row and column and print the entries
    for (int i = 0; i < maze_size; i++) {
        for (int j = 0; j < maze_size; j++) {
            printf("%d ", maze[i][j]);
        }
        printf("\n");
    }
}

// Function to navigate the maze
int navigateMaze(int **maze, int *current_position, int maze_size) {
    int x = current_position[0];
    int y = current_position[1];

    // Check if current position is out of bounds
    if (x < 0 || x >= maze_size || y < 0 || y >= maze_size) {
        return 0; // Dead end
    }

    // Check if current position is a wall or already visited
    if (maze[x][y] == 1) {
        return 0; // Dead end
    }

    // Check if reached the exit (bottom-right corner)
    if (x == maze_size - 1 && y == maze_size - 1) {
        return 1; // Exit found
    }

    // Mark the current position as visited by setting it to a wall
    maze[x][y] = 1;

    // Explore adjacent positions (up, down, left, right)
    int new_position[2];
    
    // Up
    new_position[0] = x - 1;
    new_position[1] = y;
    if (navigateMaze(maze, new_position, maze_size)) {
        return 1;
    }
    // Down
    new_position[0] = x + 1;
    new_position[1] = y;
    if (navigateMaze(maze, new_position, maze_size)) { 
        return 1;
    }
    // Left
    new_position[0] = x;
    new_position[1] = y - 1;
    if (navigateMaze(maze, new_position, maze_size)) {
        return 1;
    }
    // Right
    new_position[0] = x;
    new_position[1] = y + 1;
    if (navigateMaze(maze, new_position, maze_size)) {
        return 1;
    }
    // Unmark the current position (backtrack)
    maze[x][y] = 0;

    return 0; // Dead end
}
