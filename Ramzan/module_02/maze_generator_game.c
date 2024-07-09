#include<stdio.h>

int **CreateMaze(int rows,int cols){//function to create maze
    //allocate memory for rows
    int **maze = (int**)malloc(rows*sizeof(int*));
    if(maze==NULL)
    {
        printf("Failed to allocate memory.\n");
        exit(EXIT_FAILURE);
    }
    // Allocate memory for columns (elements in each row)
    for(int i=0;i<row;i++)
    {
        maze[i] = (int*)maloc(cols*sizeof(int));
        if (maze[i]==NULL)
        {
            printf("Failed to allocate memory for any array.\n");
            exit(EXIT_FAILURE);
        }
    }

    //// Initialize maze elements (optional)
    for(int)


}
