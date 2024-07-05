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
    *row = *position / NUMROWS;
    *col = *position % NUMCOLS;
}
int Coord2Pos(int row, int col) {
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
    int row, col; Pos2Coord(currentPosition, &row, &col);
    maze[row][col] = VISITED;   // Dont explore this position again
    
    printf("%d, %d\n", row, col);

    int currentElement = maze[row][col];
    if (currentElement == WALL) {
        return DEADEND;
    }
    else {
        if ((row==(NUMROWS-1)) && (col==(NUMCOLS-1))){
            return SUCCESS;
        }
        else {
            // Check up
            if (row > 0) {
                if (maze[row-1][col] != VISITED) {
                    int newPosition = Coord2Pos(row-1, col);
                    int status = traverse(&newPosition, maze);
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            // Check down
            if (row < (NUMROWS-1)) {
                if (maze[row+1][col] != VISITED) {
                    int newPosition = Coord2Pos(row+1, col);
                    int status = traverse(&newPosition, maze);
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            // Check left
            if (col > 0) {
                if (maze[row][col-1] != VISITED) {
                    int newPosition = Coord2Pos(row, col-1);
                    int status = traverse(&newPosition, maze);
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            // Check up
            if (col < (NUMCOLS-1)) {
                if (maze[row][col+1] != VISITED) {
                    int newPosition = Coord2Pos(row, col+1);
                    int status = traverse(&newPosition, maze);
                    if (status==SUCCESS) return SUCCESS;
                }
            }
            return DEADEND;
        }
    }
}

int main(){
    system("clear");
    int **maze = createMaze(NUMROWS,NUMCOLS);

    initializeMaze(maze);
    printMaze(maze);

    int currentPostition = 0;
    printf("Nodes visited");
    int status = traverse(&currentPostition, maze);
    printf("%s\n\n", (status==SUCCESS) ? "Success":"Failure");

    freeMaze(maze);
}