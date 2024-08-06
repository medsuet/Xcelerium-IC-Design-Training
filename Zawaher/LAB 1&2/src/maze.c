#include <stdio.h>
#include <stdlib.h>

int** createMaze(int maze_size) {
    int** maze = (int**)malloc(maze_size * sizeof(int*));
    for (int i = 0; i < maze_size; i++) {
        maze[i] = (int*)malloc(maze_size * sizeof(int));
    }
    return maze;
}

void freeMaze(int** maze, int maze_size) {
    for (int i = 0; i < maze_size; i++) {
        free(maze[i]);
    }
    free(maze);
}

void printMaze(int** maze, int maze_size, int* current_position) {
    for (int i = 0; i < maze_size; i++) {
        for (int j = 0; j < maze_size; j++) {
            if (i == current_position[0] && j == current_position[1]) {
                printf("P ");
            } else {
                printf("%d ", maze[i][j]);
            }
        }
        printf("\n");
    }
}

int navigateMaze(int** maze, int maze_size, int* current_position) {
    int row = current_position[0];
    int col = current_position[1];

    // Check if we have reached the exit
    if (row == maze_size - 1 && col == maze_size - 1) {
        return 1; // Found the exit
    }

    char move;
    printf("Enter your move (W for up, S for down, A for left, D for right): ");
    scanf(" %c", &move);

    int new_position[2] = {row, col};

    switch (move) {
        case 'W': case 'w':
            new_position[0] -= 1;
            break;
        case 'S': case 's':
            new_position[0] += 1;
            break;
        case 'A': case 'a':
            new_position[1] -= 1;
            break;
        case 'D': case 'd':
            new_position[1] += 1;
            break;
        default:
            printf("Invalid move!\n");
            return navigateMaze(maze, maze_size, current_position);
    }

    // Check for boundary conditions and if the next position is a wall
    if (new_position[0] < 0 || new_position[0] >= maze_size ||
        new_position[1] < 0 || new_position[1] >= maze_size ||
        maze[new_position[0]][new_position[1]] == 1) {
        printf("Invalid move! You hit a wall or boundary.\n");
        //return navigateMaze(maze, maze_size, current_position);
        return 0;
    }

    // Update current position
    current_position[0] = new_position[0];
    current_position[1] = new_position[1];

    //printing maze for debugging purpose:
    
    //printMaze(maze, maze_size, current_position);

    // Continue navigating
    return navigateMaze(maze, maze_size, current_position);
}

int main() {
    int maze_size = 5;
    int** maze = createMaze(maze_size);

    // Example maze initialization (1 = wall, 0 = path)
    int exampleMaze[5][5] = {
        {0, 1, 0, 0, 0},
        {0, 1, 0, 1, 0},
        {0, 0, 0, 1, 0},
        {0, 1, 1, 1, 0},
        {0, 0, 0, 0, 0}
    };

    for (int i = 0; i < maze_size; i++) {
        for (int j = 0; j < maze_size; j++) {
            maze[i][j] = exampleMaze[i][j];
        }
    }

    int start_position[2] = {0, 0};
    printMaze(maze, maze_size, start_position);

    if (navigateMaze(maze, maze_size, start_position)) {
        printf("Congratulations! You found the exit.\n");
    } else {
        printf("No path found.\n");
    }

    freeMaze(maze, maze_size);

    return 0;
}
