#include <stdio.h>
#include <stdlib.h>

#define WALL 1
#define PATH 0

int maze_size = 5; // Example size, can be modified

int** allocate_maze(int size) {
    int** maze = (int**)malloc(size * sizeof(int*));
    for (int i = 0; i < size; i++) {
        maze[i] = (int*)malloc(size * sizeof(int));
    }
    return maze;
}

void free_maze(int** maze, int size) {
    for (int i = 0; i < size; i++) {
        free(maze[i]);
    }
    free(maze);
}

void print_maze(int** maze, int size) {
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%d ", maze[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

int navigate_maze(int* current_position, int** maze, int size) {
    int row = current_position[0];
    int col = current_position[1];

    // Print the maze at the current step
    print_maze(maze, size);

    // Check if out of bounds
    if (row < 0 || row >= size || col < 0 || col >= size) {
        return -1; // Dead end
    }

    // Check if it's a wall
    if (maze[row][col] == WALL) {
        return -1; // Dead end
    }

    // Check if it's the exit
    if (row == size - 1 && col == size - 1) {
        printf("Hurrah! We reached the end!\n");
        return 1; // Success
    }

    // Mark the current position as visited
    maze[row][col] = WALL;

    // Explore adjacent positions (up, down, left, right)
    int next_position[2];

    // Up
    next_position[0] = row - 1;
    next_position[1] = col;
    if (navigate_maze(next_position, maze, size) == 1) {
        return 1; // Success
    }

    // Down
    next_position[0] = row + 1;
    next_position[1] = col;
    if (navigate_maze(next_position, maze, size) == 1) {
        return 1; // Success
    }

    // Left
    next_position[0] = row;
    next_position[1] = col - 1;
    if (navigate_maze(next_position, maze, size) == 1) {
        return 1; // Success
    }

    // Right
    next_position[0] = row;
    next_position[1] = col + 1;
    if (navigate_maze(next_position, maze, size) == 1) {
        return 1; // Success
    }

    // No valid path found, mark as unvisited
    maze[row][col] = PATH;

    return -1; // Dead end
}

int main() {
    // Allocate memory for the maze
    int** maze = allocate_maze(maze_size);

    // Initialize the maze (example initialization)
    for (int i = 0; i < maze_size; i++) {
        for (int j = 0; j < maze_size; j++) {
            maze[i][j] = PATH; // All paths for simplicity, you can add walls as needed
        }
    }

    // Set up walls in the maze (example setup)
    maze[1][1] = WALL;
    maze[2][2] = WALL;
    maze[3][3] = WALL;

    // Define the starting position
    int start_position[2] = {0, 0};

    // Navigate the maze
    int result = navigate_maze(start_position, maze, maze_size);

    if (result == 1) {
        printf("Path to the exit found!\n");
    } else {
        printf("No path to the exit. We lost.\n");
    }

    // Free the allocated memory
    free_maze(maze, maze_size);

    return 0;
}



// #include <stdio.h>
// #include <stdlib.h>
// #include <stdbool.h>

// #define WALL 1
// #define PATH 0

// int maze_size;

// // Function prototypes
// int** create_maze();
// bool navigate_maze(int** maze, int* current_position);
// void free_maze(int** maze);

// int main() {
//     maze_size = 5;  // For this example, we'll use a 5x5 maze
//     int** maze = create_maze();
    
//     // Initialize the maze (0 for path, 1 for wall)
//     // This is a sample maze, you can modify it as needed
//     int initial_maze[5][5] = {
//         {0, 1, 0, 0, 0},
//         {0, 1, 0, 1, 0},
//         {0, 0, 0, 1, 0},
//         {0, 1, 1, 1, 0},
//         {0, 0, 0, 1, 0}
//     };
    
//     for (int i = 0; i < maze_size; i++) {
//         for (int j = 0; j < maze_size; j++) {
//             maze[i][j] = initial_maze[i][j];
//         }
//     }
    
//     // Start navigation from the top-left corner
//     int start_position[2] = {0, 0};
//     if (navigate_maze(maze, start_position)) {
//         printf("Path found!\n");
//     } else {
//         printf("No path to exit.\n");
//     }
    
//     free_maze(maze);
//     return 0;
// }

// int** create_maze() {
//     int** maze = (int**)malloc(maze_size * sizeof(int*));
//     for (int i = 0; i < maze_size; i++) {
//         maze[i] = (int*)malloc(maze_size * sizeof(int));
//     }
//     return maze;
// }

// bool navigate_maze(int** maze, int* current_position) {
//     int row = current_position[0];
//     int col = current_position[1];
    
//     // Check if we're out of bounds
//     if (row < 0 || row >= maze_size || col < 0 || col >= maze_size) {
//         return false;
//     }
    
//     // Check if we've hit a wall
//     if (maze[row][col] == WALL) {
//         return false;
//     }
    
//     // Check if we've reached the exit (bottom-right corner)
//     if (row == maze_size - 1 && col == maze_size - 1) {
//         return true;
//     }
    
//     // Mark current position as visited
//     maze[row][col] = WALL;
    
//     // Recursive calls to explore adjacent positions
//     int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};  // up, down, left, right
//     for (int i = 0; i < 4; i++) {
//         int new_position[2] = {row + directions[i][0], col + directions[i][1]};
//         if (navigate_maze(maze, new_position)) {
//             return true;
//         }
//     }
    
//     // If we get here, this path is a dead end
//     return false;
// }

// void free_maze(int** maze) {
//     for (int i = 0; i < maze_size; i++) {
//         free(maze[i]);
//     }
//     free(maze);
// }