#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
typedef struct Maze_Size{
    int rows;
    int cols;
}Maze_Size;
int navigate_the_maze(int * current_position,int **maze,int **MAZE2,Maze_Size maze_size);
int main(){
    Maze_Size maze_size;
    int cp[2] = {0, 0};
    int * current_position=cp;
    srand(time(NULL));
    printf("Enter dimensions of the maze:\n");
    printf("Enter number of rows");
    scanf("%d",&maze_size.rows);
    printf("Enter number of columns");
    scanf("%d",&maze_size.cols);
    int ** MAZE=malloc(sizeof(int*)*maze_size.rows);
    if (MAZE == NULL) {
        printf("Memory allocation failed for rows\n");
        return 1;
    }
    for (int i=0;i<maze_size.rows;i++){
        MAZE[i]=malloc(sizeof(int)*maze_size.cols);
        if (MAZE[i] == NULL) {
            printf("Memory allocation failed for columns\n");
            return 1;
        }
    }
    for (int i=0;i<maze_size.rows;i++){
        for (int j=0;j<maze_size.cols;j++){
            MAZE[i][j]=0;
        }
    }
    MAZE[0][0]=0;
    MAZE[0][1]=1;
    MAZE[1][1]=1;
    MAZE[2][2]=1;
    MAZE[3][2]=1;
    MAZE[4][3]=1;
    MAZE[4][4]=0;
    for (int i=0;i<maze_size.rows;i++){
        printf("\n");
        for (int j=0;j<maze_size.cols;j++){
            printf("%d ",MAZE[i][j]);
        }
    }

    int ** MAZE2=malloc(sizeof(int*)*maze_size.rows);
    if (MAZE2 == NULL) {
        printf("Memory allocation failed for rows\n");
        return 1;
    }
    for (int i=0;i<maze_size.rows;i++){
        MAZE2[i]=malloc(sizeof(int)*maze_size.cols);
        if (MAZE2[i] == NULL) {
            printf("Memory allocation failed for columns\n");
            return 1;
        }
    }
    for (int i=0;i<maze_size.rows;i++){
        for (int j=0;j<maze_size.cols;j++){
            MAZE2[i][j]=2;
        }
    }
/*    for (int i=0;i<maze_size.rows;i++){
        printf("\n");
        for (int j=0;j<maze_size.cols;j++){
            printf("%d ",MAZE2[i][j]);
        }
    }*/

    navigate_the_maze(current_position,MAZE,MAZE2,maze_size);
    for (int i=0;i<maze_size.rows;i++){
        free(MAZE[i]);
    }
    free(MAZE);
    for (int i=0;i<maze_size.rows;i++){
        free(MAZE2[i]);
    }
    free(MAZE2);
}
int navigate_the_maze(int * current_position,int **maze,int **MAZE2,Maze_Size maze_size){
    int y=current_position[0];
    int x=current_position[1];
    printf("x=%d,y=%d",x,y);
    printf("\n");
    if (x>0&&x<maze_size.rows-1){
        if(y>0&&y<maze_size.cols-1){
            if((maze[y+1][x]==1 && maze[y-1][x]==1 && maze[y][x+1]==1 && maze[y][x-1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
        if(y==0){
            if((maze[y+1][x]==1 && maze[y][x+1]==1 && maze[y][x-1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
        if(y==maze_size.cols-1){
            if((maze[y-1][x]==1 && maze[y][x+1]==1 && maze[y][x-1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
    }
    else if (x==0){
        if(y>0&&y<maze_size.cols-1){
            if((maze[y+1][x]==1 && maze[y-1][x]==1 && maze[y][x+1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
        if(y==0){
            if((maze[y+1][x]==1 && maze[y][x+1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
        if(y==maze_size.cols-1){
            if((maze[y-1][x]==1 && maze[y][x+1]==1 ) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
    }
    else if (x==maze_size.rows-1){
        if(y>0&&y<maze_size.cols-1){
            if((maze[y+1][x]==1 && maze[y-1][x]==1 && maze[y][x-1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
        if(y==0){
            if((maze[y+1][x]==1 && maze[y][x-1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
        if(y==maze_size.cols-1){
            if((maze[y-1][x]==1 && maze[y][x-1]==1) &&(x!=(maze_size.rows-1)&&x!=(maze_size.cols-1))){
                printf("DEAD END. Maze can not be solved.");
                exit(0);
            } 
        }
    }
    
    for (int i=0;i<maze_size.rows;i++){
        printf("\n");
        for (int j=0;j<maze_size.rows;j++){
            printf("%d ",MAZE2[i][j]);
        }
    }
    if (MAZE2[y][x]==1 || MAZE2[y][x]==0){
        return 0;
    }
    else if (maze[y][x]==1){
        printf("\nDead End\n");
        MAZE2[y][x]=1;
        for (int i=0;i<maze_size.rows;i++){
            printf("\n");
            for (int j=0;j<maze_size.rows;j++){
                printf("%d ",MAZE2[i][j]);
            }
        }
        if ((x==maze_size.rows-1)&&(y==maze_size.cols-1)){
            printf("The maze can not be solved\n");
            for (int i=0;i<maze_size.rows;i++){
                printf("\n");
                for (int j=0;j<maze_size.rows;j++){
                    printf("%d ",MAZE2[i][j]);
                }
            }
            exit(0);
        }
        return 0;
    }
    else if(maze[y][x]==0){
        MAZE2[y][x]=0;
        if(current_position[0]==(maze_size.rows-1) && current_position[1]==(maze_size.rows-1)){
            printf("\nSuccess\n");
            for (int i=0;i<maze_size.rows;i++){
                printf("\n");
                for (int j=0;j<maze_size.rows;j++){
                    printf("%d ",MAZE2[i][j]);
            }
            }
            exit(1);
        }
        else{
            if (y+1<=maze_size.cols-1){
                current_position[0]=y+1;
                current_position[1]=x;
                navigate_the_maze(current_position,maze,MAZE2,maze_size);
            }
            if (y-1>=0){
                current_position[0]=y-1;
                current_position[1]=x;
                navigate_the_maze(current_position,maze,MAZE2,maze_size);
            }
            if (x+1<=maze_size.rows-1){
                current_position[0]=y;
                current_position[1]=x+1;
                navigate_the_maze(current_position,maze,MAZE2,maze_size);
            }
            if (x-1>=0){
                current_position[0]=y;
                current_position[1]=x-1;
                navigate_the_maze(current_position,maze,MAZE2,maze_size);
            }
        }
    }
    return 0;
}