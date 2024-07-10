#include <stdio.h>
#include <stdlib.h>

int** allocateMemory(int size){
 int** array = (int**)malloc(size * sizeof(*int));
// int arr1[10][10] = (int)malloc(size * sizeof(int)) ;
 for (int i=0; i<=size; i++){
 int arri[10][10] = (int)calloc(size , sizeof(int)) ;
 array[i] = &arri;
 }
 return array;
    
}

char navigateMAze(int* current_position , int** maze){
    int current_element;
	 current_element=maze[current_position]
}

int main(){


return 0;
}
