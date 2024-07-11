#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int** allocateMemory(int size) {
    int** array = (int**)malloc(size * sizeof(int*)); 
    for (int i = 0; i < size; i++) { 
        array[i] = (int*)malloc(size * sizeof(int)); 
    }
    return array;
}


void initializeArray(int** array, int size) {
    srand(time(NULL));
    for (int i = 0; i < size; i++) { 
        for (int j = 0; j < size; j++) { 
            array[i][j] = rand() % 2; 
        }
    }
}


char navigateMaze(int* current_position, int** maze, int size) {
    int x = current_position[0]; 
    int y = current_position[1]; 

   
    if (x < 0 || x >= size || y < 0 || y >= size) { 
        return 'O'; 
    }
    
    if (maze[x][y] == 1) { 
        return 'B'; 
    }
 
    if (x == size - 1 || y == size - 1) {
     	    return 'E'; 
    }

  
    maze[x][y] = 1; 


    
    char result; 

  
    current_position[0] = x; 
    current_position[1] = y + 1; 
    result = navigateMaze(current_position, maze, size); 
    if (result == 'E') return 'E'; 

    
    current_position[0] = x + 1; 
    current_position[1] = y; 
    result = navigateMaze(current_position, maze, size); 
    if (result == 'E') return 'E'; 

    
    current_position[0] = x; 
    current_position[1] = y - 1; 
    result = navigateMaze(current_position, maze, size); 
    if (result == 'E') return 'E'; 

  
    current_position[0] = x - 1; 
    current_position[1] = y; 
    result = navigateMaze(current_position, maze, size); 
    if (result == 'E') return 'E'; 

    printf("x and y before exit: %d %d\n",x, y);  
    maze[x][y] = 0; 
    return 'D'; 
}

void printMaze(int** maze, int size) {
    for (int i = 0; i < size; i++) { 
        for (int j = 0; j < size; j++) { 
            printf("%d ", maze[i][j]); 
        }
        printf("\n"); 
    }
}


void freeMemory(int** maze, int size) {
    for (int i = 0; i < size; i++) { 
        free(maze[i]); 
    }
    free(maze); 
}

int main() {
    int size = 5; 
    int** maze = allocateMemory(size); 
    initializeArray(maze, size); 

    printf("Generated Maze:\n");
    printMaze(maze, size); 

    int start_position[2];
    while (1) { 
        
        printf("Enter starting position (row and column, 0-indexed): "); 
        scanf("%d %d", &start_position[0], &start_position[1]); 

        
        if (start_position[0] < 0 || start_position[0] >= size || 
            start_position[1] < 0 || start_position[1] >= size) { 
            printf("Invalid starting position. Out of bounds.\n"); 
        } else if (maze[start_position[0]][start_position[1]] == 1) { 
            printf("Invalid starting position. It's a wall.\n"); 
        } else {
            break; 
        }
    }

    
    char result = navigateMaze(start_position, maze, size); 
    if (result == 'E') {
        printf("Path to exit found!\n"); 
    } else {
        printf("No path to exit found.\n"); 
    }

    
    freeMemory(maze, size); 

    return 0;
}

