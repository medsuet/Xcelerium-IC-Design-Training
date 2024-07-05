#include <stdio.h>
#include <stdlib.h>

// Function to dynamically allocate memory for a maze of given size
int** allocateMaze(int maze_size) {
    // Allocate memory for maze_size rows
    int **maze = (int **)malloc(maze_size * sizeof(int *));
    if (maze == NULL) {
        printf("Memory allocation failed.\n");
        return NULL; // Return NULL on failure
    }

    // Allocate memory for each row
    for (int i = 0; i < maze_size; ++i) {
        maze[i] = (int *)malloc(maze_size * sizeof(int));
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
        for (int j = 0; j < maze_size; ++j) {
            // Initialize walls randomly
            maze[i][j] = rand() % 2; // 0 (path) or 1 (wall)
        }
    }
    return maze;
}

// Function to deallocate memory for the maze
void deallocateMaze(int **maze, int maze_size) {
    // Deallocate memory for each row
    for (int i = 0; i < maze_size; ++i) {
        free(maze[i]);
    }

    // Deallocate memory for the maze pointer
    free(maze);
}

// Function to print the maze (for debugging purposes)
void printMaze(int **maze, int maze_size) {
    printf("Maze:\n");
    for (int i = 0; i < maze_size; ++i) {
        for (int j = 0; j < maze_size; ++j) {
            printf("%d ", maze[i][j]);
        }
        printf("\n");
    }
}

// Function to navigate the maze recursively
int navigateMaze(int *current_position, int **maze, int maze_size) {
    int row = current_position[0]; // Current row index
    int col = current_position[1]; // Current column index

    // Check if current position is outside maze boundaries
    if (row < 0 || row >= maze_size || col < 0 || col >= maze_size) {
        return 0; // Out of bounds
    }

    // Check if current position is a wall
    if (maze[row][col] == 1) {
        return 0; // Dead end (wall)
    }

    // Check if current position is the exit (bottom-right corner)
    if (row == maze_size - 1 && col == maze_size - 1) {
        return 1; // Success (found exit)
    }

    // Mark current position as visited (optional, depends on requirements)
    maze[row][col] = 2; // Example: Mark as visited (2 means visited)

    // Define possible moves (up, down, left, right)
    int moves[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    for (int i = 0; i < 4; ++i) {
        int new_row = row + moves[i][0];
        int new_col = col + moves[i][1];

        // Recursively navigate to adjacent positions
        if (navigateMaze(&(maze[new_row][new_col]), maze, maze_size)) {
            return 1; // Found exit through this path
        }
    }

    // Unmark current position (backtrack) if no path found
    // This step is optional depending on maze marking requirements
    maze[row][col] = 0; // Reset to path (0)

    return 0; // Dead end (no path found)
}

// Function to calculate the total bits in a number
int calculateBitCount(int number) {
    int count = 0;
    
    // Counting bits until the number is zero
    while (number != 0) {
        count++;
        number >>= 1; // Right Shift the number by 1 bit 
    }

    return count;
}

void ArithmeticRightShift(int *A, int *Q, int *Q0, int iterations) {
    int aLSB = *A & 1;
    int qLSB = *Q & 1;
    
    *A >>= 1;
    *Q >>= 1;
    *Q |= (qLSB << (iterations - 1));

    *Q0 = qLSB;  // Update Q0 to qLSB for next iteration
}

void Add(int *A, int M, int iterations) {
    *A += M;
}

void Subtract(int *A, int M, int iterations) {
    *A -= M;
}

int boothMultiplier(int multiplicand, int multiplier, int count) {
    int product = 0;
    int A = 0;
    int Q = multiplier;
    int M = multiplicand;
    int Q0 = 0;
    int iterations = count;
    int multiplierLSB = 0;
    
    // Calculating the multiplierLSB using bitwise Anding
    multiplierLSB = Q & 1;

    while (iterations > 0) {
        Q0 = Q & 1;

        if (multiplierLSB == 0 && Q0 == 1) {
            Add(&A, M, iterations);  // A = A + M
        } else if (multiplierLSB == 1 && Q0 == 0) {
            Subtract(&A, M, iterations);  // A = A - M
        }

        ArithmeticRightShift(&A, &Q, &Q0, iterations);
        iterations--;
    }

    product = A | Q;

    return product;
}

int main() {

    // Task Y

    int multiplicand = 84;
    int multiplier = 7;

    // Calculating the multiplicand and multiplier bits
    int multiplicandBits = calculateBitCount(multiplicand);
    int multiplierBits = calculateBitCount(multiplier);

    // Setting the count equal to multiplier bits for number of iterations
    int count = multiplierBits;

    int product = boothMultiplier(multiplicand, multiplier, count);

    printf("The product of %d and %d is %d\n", multiplicand, multiplier, product);

    // Task Z

    int maze_size = 5; // Example maze size
    int **maze;

    // Allocate memory for the maze
    maze = allocateMaze(maze_size);

    // Print the maze
    printMaze(maze, maze_size);

    // Accessing and modifying maze elements
    printf("Modifying maze:\n");
    maze[1][1] = 1;

    // Print modified maze
    printMaze(maze, maze_size);

    // Find a path in the maze from the top-left corner (0, 0)
    int start_position[2] = {0, 0};
    if (navigateMaze(start_position, maze, maze_size)) {
        printf("Path to exit found!\n");
    } else {
        printf("No path to exit found.\n");
    }

    // Deallocate memory for the maze
    deallocateMaze(maze, maze_size);

    return 0;
}
