#include <stdio.h>
#include <stdlib.h>

#define NUMROWS 4
#define NUMCOLS 4

#define DEADEND 1
#define SUCCESS 2

#define WALL 1
#define PATH 0
#define VISITED 2

// Macro to check if a pointer is NULL
#define CHECKNULL(ptr) if(ptr==NULL) return -1
// Macro to check if a pointer is NULL for functions returning void
#define CHECKNULLv(ptr) if(ptr==NULL) return

void Pos2Coord(int *position, int *row, int *col) {
    // Converts matrix position to row and coloum indexes
    *row = *position / NUMROWS;
    *col = *position % NUMCOLS;
}
int Coord2Pos(int row, int col) {
    // Converts row and coloum indexes to matrix position
    return ((NUMROWS * row) + col);
}

int** createMaze() {
    // Allocates memory for maze
    
    int mazeSize = NUMCOLS * NUMROWS;
    // Create an array of pointers
    int **maze = (int **) malloc(NUMROWS * sizeof(int*));
    for (int i=0; i<NUMROWS; i++) {
        maze[i] = (int *) calloc(NUMCOLS, sizeof(int));
    }

    return maze;
}

void freeMaze(int **maze) {
    // frees all rows of maze and then frees maze itself
    CHECKNULLv(maze);
    for (int i=0; i<NUMROWS; i++) {
        free(maze[i]);
    }
    free(maze);
}

void printMaze(int **maze) {

    for (int i=0; i<NUMROWS; ++i) {
        for (int j=0; j<NUMCOLS; j++) {
            printf("%s", (maze[i][j]==WALL) ? "█" : " ");
        }
        printf("\n");
    }
    printf("\n");
}

void initializeMaze(int **maze) {
    int sampleMaze[4][4] = {{0,0,0,0},
                            {0,1,1,1},
                            {0,0,0,0},
                            {0,0,0,0},};
    for (int i=0; i<NUMROWS; ++i) {
        for (int j=0; j<NUMCOLS; j++) {
            maze[i][j] = sampleMaze[i][j];
        }
    }
}

int traverse(int *currentPosition, int **maze) {
    // Traverses matrix recursively in each direction to find end position

    int row, col; Pos2Coord(currentPosition, &row, &col);
    maze[row][col] = VISITED;   // Don't explore current position again
    
    printf("%d, %d\n", row, col);       // Print locations visited on terminal

    int currentElement = maze[row][col];
    if (currentElement == WALL) {
        return DEADEND;
    }
    // if currentElement is a path
    else {
        // Check end condition (last row, last coloum)
        if ((row==(NUMROWS-1)) && (col==(NUMCOLS-1))){
            return SUCCESS;
        }
        else {
            // If not end condition, check to where you can move and explore.
            // Check up
            if (row > 0) {                                      // If within array bounds
                if (maze[row-1][col] != VISITED) {              // and not already visited
                    int newPosition = Coord2Pos(row-1, col);
                    int status = traverse(&newPosition, maze);  // explore there
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            // Check down
            if (row < (NUMROWS-1)) {                            // If within array bounds
                if (maze[row+1][col] != VISITED) {              // and not already visited
                    int newPosition = Coord2Pos(row+1, col);
                    int status = traverse(&newPosition, maze);  // explore there
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            // Check left
            if (col > 0) {                                      // If within array bounds
                if (maze[row][col-1] != VISITED) {              // and not already visited
                    int newPosition = Coord2Pos(row, col-1);
                    int status = traverse(&newPosition, maze);  // explore there
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            // Check right
            if (col < (NUMCOLS-1)) {                            // If within array bounds
                if (maze[row][col+1] != VISITED) {              // and not already visitedv
                    int newPosition = Coord2Pos(row, col+1);
                    int status = traverse(&newPosition, maze);  // explore there
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            return DEADEND;
        }
    }
}

int main(){
    system("clear");

    // Create a maze
    int **maze = createMaze(NUMROWS,NUMCOLS);

    initializeMaze(maze);
    printMaze(maze);

    // Start from position 0 in matrix and search for end condition.
    int currentPostition = 0;
    printf("Nodes visited");
    int status = traverse(&currentPostition, maze);
    printf("%s\n\n", (status==SUCCESS) ? "Success":"Failure");

    freeMaze(maze);
}
