#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Step 1: Allocate Memory for the Maze
int** allocateMemory(int size) {
    int** array = (int**)malloc(size * sizeof(int*)); // Line 5
    for (int i = 0; i < size; i++) { // Line 6
        array[i] = (int*)malloc(size * sizeof(int)); // Line 7
    }
    return array; // Line 9
}

// Step 2: Initialize the Maze
void initializeArray(int** array, int size) {
    srand(time(NULL)); // Seed for random number generation - Line 13
    for (int i = 0; i < size; i++) { // Line 14
        for (int j = 0; j < size; j++) { // Line 15
            array[i][j] = rand() % 2; // Randomly assign 0 or 1 - Line 16
        }
    }
}

// Step 3: Navigate the Maze
char navigateMaze(int* current_position, int** maze, int size) {
    int x = current_position[0]; // Line 23
    int y = current_position[1]; // Line 24

    // Check for out of bounds
    if (x < 0 || x >= size || y < 0 || y >= size) { // Line 27
        return 'O'; // Out of bounds - Line 28
    }
    // Check for walls
    if (maze[x][y] == 1) { // Line 31
        return 'B'; // Blocked - Line 32
    }
    // Check for exit
    if (x == size - 1 && y == size - 1) { // Line 35
        return 'E'; // Exit found - Line 36
    }

    // Mark the current position as visited
    maze[x][y] = 1; // Line 39

    // Explore adjacent positions
    int new_position[2]; // Line 42
    char result; // Line 43

    // Move right
    new_position[0] = x; // Line 46
    new_position[1] = y + 1; // Line 47
    result = navigateMaze(new_position, maze, size); // Line 48
    if (result == 'E') return 'E'; // Line 49

    // Move down
    new_position[0] = x + 1; // Line 52
    new_position[1] = y; // Line 53
    result = navigateMaze(new_position, maze, size); // Line 54
    if (result == 'E') return 'E'; // Line 55

    // Move left
    new_position[0] = x; // Line 58
    new_position[1] = y - 1; // Line 59
    result = navigateMaze(new_position, maze, size); // Line 60
    if (result == 'E') return 'E'; // Line 61

    // Move up
    new_position[0] = x - 1; // Line 64
    new_position[1] = y; // Line 65
    result = navigateMaze(new_position, maze, size); // Line 66
    if (result == 'E') return 'E'; // Line 67

    // No path found, backtrack
    maze[x][y] = 0; // Line 70
    return 'D'; // Dead end - Line 71
}

// Step 4: Print the Maze
void printMaze(int** maze, int size) {
    for (int i = 0; i < size; i++) { // Line 77
        for (int j = 0; j < size; j++) { // Line 78
            printf("%d ", maze[i][j]); // Line 79
        }
        printf("\n"); // Line 81
    }
}

// Step 5: Free the Allocated Memory
void freeMemory(int** maze, int size) {
    for (int i = 0; i < size; i++) { // Line 87
        free(maze[i]); // Line 88
    }
    free(maze); // Line 90
}

int main() {
    int size = 5; // Define the size of the maze - Line 95
    int** maze = allocateMemory(size); // Line 96
    initializeArray(maze, size); // Line 97

    printf("Generated Maze:\n");
    printMaze(maze, size); // Line 100

    int start_position[2];
    while (1) { // Line 103
        // Prompt User for Starting Position
        printf("Enter starting position (row and column, 0-indexed): "); // Line 105
        scanf("%d %d", &start_position[0], &start_position[1]); // Line 106

        // Validate starting position
        if (start_position[0] < 0 || start_position[0] >= size || 
            start_position[1] < 0 || start_position[1] >= size) { // Line 109
            printf("Invalid starting position. Out of bounds.\n"); // Line 111
        } else if (maze[start_position[0]][start_position[1]] == 1) { // Line 112
            printf("Invalid starting position. It's a wall.\n"); // Line 113
        } else {
            break; // Line 115
        }
    }

    // Step 3: Navigate the Maze from User-Defined Start Position
    char result = navigateMaze(start_position, maze, size); // Line 119
    if (result == 'E') {
        printf("Path to exit found!\n"); // Line 121
    } else {
        printf("No path to exit found.\n"); // Line 123
    }

    // Step 5: Free Allocated Memory
    freeMemory(maze, size); // Line 127

    return 0;
}

