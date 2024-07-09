#include<stdio.h>
#include<stdlib.h>

#define DEAD_END -1
#define SUCCESS 1

int **CreateMaze(int rows,int cols){//function to create maze
    //allocate memory for rows
    int **maze = (int**)malloc(rows*sizeof(int*));
    if(maze==NULL)
    {
        printf("Failed to allocate memory.\n");
        exit(EXIT_FAILURE);
    }
    // Allocate memory for columns (elements in each row)
    for(int i=0;i<rows;i++)
    {
        maze[i] = (int*)malloc(cols*sizeof(int));
        if (maze[i]==NULL)
        {
            printf("Failed to allocate memory for any array.\n");
            exit(EXIT_FAILURE);
        }
    }
    //// Initialize maze elements (optional)
    for (int i=0;i<rows;i++)
    {
        for (int j=0;j<cols;j++)
        {
            maze[i][j] =0;//I have initialized that al elements and o value
        }
    }
    return maze;
}
void FreeMemory(int **maze,int rows)
{
    for(int i=0;i<rows;i++)
    {
        free(maze[i]);
    }
    free(maze);
}

// Function to navigate the maze

int navigateMaze(int *current_position, int **maze, int rows, int cols) {
    int x = current_position[0];
    int y = current_position[1];

    // Check if the current position is out of bounds
    if (x < 0 || x >= rows || y < 0 || y >= cols) {
        return DEAD_END;
    }

    // Check if the current position is a wall or already part of the path
    if (maze[x][y] == 1 || maze[x][y] == 2) {
        return DEAD_END;
    }

    // Check if the current position is the exit
    if (x == rows - 1 && y == cols - 1) {
        maze[x][y] = 2; // Mark the exit as part of the path
        return SUCCESS;
    }

    // Mark the current position as part of the path
    maze[x][y] = 2;

    // Explore adjacent positions
    int new_position[2];

    // Move right
    new_position[0] = x;
    new_position[1] = y + 1;
    if (navigateMaze(new_position, maze, rows, cols) == SUCCESS) {
        return SUCCESS;
    }

    // Move down
    new_position[0] = x + 1;
    new_position[1] = y;
    if (navigateMaze(new_position, maze, rows, cols) == SUCCESS) {
        return SUCCESS;
    }

    // Move left
    new_position[0] = x;
    new_position[1] = y - 1;
    if (navigateMaze(new_position, maze, rows, cols) == SUCCESS) {
        return SUCCESS;
    }

    // Move up
    new_position[0] = x - 1;
    new_position[1] = y;
    if (navigateMaze(new_position, maze, rows, cols) == SUCCESS) {
        return SUCCESS;
    }

    // Unmark the current position as part of the path
    maze[x][y] = 0;

    // No path found
    return DEAD_END;
}
int main()
{
    int rows;
    int cols;
    printf("Enter size of the maze (X x X maze): ");
    scanf("%d %d", &rows, &cols);
    int **maze = CreateMaze(rows,cols);

    //set a wall at postion (0,0)
    // Example: Set some walls in the maze
    maze[0][1] = 1;
    maze[1][1] = 1;
    maze[2][1] = 1;

    printf("Initial Maze:\n");
    for(int i=0;i<rows;i++)
    {
        for(int j=0;j<cols;j++)
        {
            printf("%d ",maze[i][j]);
        }
        printf("\n");
    }

    int start_position[2] = {0,0};

    int result = navigateMaze(start_position,maze,rows,cols);
    if(result == SUCCESS)
    {
        printf("Successfully found the exit!");
    }
    else
    {
        printf("No path to the exit was found.\n");
    }

    //now print maze after navigation

    printf("Maze after Navigation:\n");
    for(int i=0;i<rows;i++)
    {   
       for(int j=0;j<cols;j++)
        {
           printf("%d ",maze[i][j]);
        }
        printf("\n");
    }


    //// Free allocated memory using function
    FreeMemory(maze,rows);
    return 0;
}
