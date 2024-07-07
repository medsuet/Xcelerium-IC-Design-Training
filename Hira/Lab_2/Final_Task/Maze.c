#include <stdio.h>
#include <stdlib.h>

// Function to dynamically allocate a 2D array
int** create_maze(int maze_size) {
    int** maze = (int**)malloc(maze_size * sizeof(int*));
    for (int i = 0; i < maze_size; i++) {
        maze[i] = (int*)malloc(maze_size * sizeof(int));
    }
    return maze;
}

// Function to print the maze
void print_maze(int** maze, int maze_size) {
    for (int i = 0; i < maze_size; i++) {
        for (int j = 0; j < maze_size; j++) {
            printf("%d ", maze[i][j]);
        }
        printf("\n");
    }
}

// Function to navigate the maze
int navigate_maze(int x, int y, int** maze, int maze_size) {
    // Print the current maze state
    printf("Current position: (%d, %d)\n", x, y);
    print_maze(maze, maze_size);
    printf("\n");

    // Check if the current position is out of bounds
    if (x < 0 || x >= maze_size || y < 0 || y >= maze_size) {
        return 0; // Dead end
    }

    // Check if the current element is a wall
    if (maze[x][y] == 1) {
        return 0; // Dead end
    }

    // Check if the current position is the exit (bottom-right corner)
    if (x == maze_size - 1 && y == maze_size - 1) {
        return 1; // Found the exit
    }

    // Mark the current path as visited by setting it to 1
    maze[x][y] = 1;

    // Move to adjacent positions (up, down, left, right)
    if (navigate_maze(x + 1, y, maze, maze_size)) { // Move down
        return 1; // Found the exit
    }
    if (navigate_maze(x, y + 1, maze, maze_size)) { // Move right
        return 1; // Found the exit
    }
    if (navigate_maze(x - 1, y, maze, maze_size)) { // Move up
        return 1; // Found the exit
    }
    if (navigate_maze(x, y - 1, maze, maze_size)) { // Move left
        return 1; // Found the exit
    }

    // Unmark the current path
    maze[x][y] = 0;

    return 0; // Dead end
}

// Function to free the dynamically allocated 2D array
void free_maze(int** maze, int maze_size) {
    for (int i = 0; i < maze_size; i++) {
        free(maze[i]);
    }
    free(maze);
}

int main() {
    int maze_size = 5;
    int** maze = create_maze(maze_size);

    // Initialize the maze (1 = wall, 0 = path)
    int initial_maze[5][5] = {
        {0, 1, 0, 0, 0},
        {0, 1, 0, 1, 0},
        {0, 0, 0, 1, 0},
        {0, 1, 1, 1, 0},
        {0, 0, 0, 0, 0}
    };

    // Copy the initial maze to the dynamically allocated maze
    for (int i = 0; i < maze_size; i++) {
        for (int j = 0; j < maze_size; j++) {
            maze[i][j] = initial_maze[i][j];
        }
    }

    // Print the initial maze
    printf("Initial maze:\n");
    print_maze(maze, maze_size);
    printf("\n");

    int start_x = 0, start_y = 0;
    if (navigate_maze(start_x, start_y, maze, maze_size)) {
        printf("Exit found!\n");
    } else {
        printf("No exit found.\n");
    }

    free_maze(maze, maze_size);
    return 0;
}
