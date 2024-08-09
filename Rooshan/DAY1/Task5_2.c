#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int Second_largest_num_finder(int *array,int n);
int main() {
    int n;
    printf("Enter Number of elements in the array: ");
    scanf("%d",&n);
    int array[n];
    int num;
    
    for (int i=0;i<n;++i){
        printf("Enter number %d: ",i);
        scanf("%d",&num);
        array[i]=num;
    }
    printf("Second largest number: %d ",Second_largest_num_finder(array,n));
}
int Second_largest_num_finder(int *array,int n){
    int max=0;
    for(int i =0;i<n;++i){
        if (*(array+i)>max){
            max=*(array+i);
        }
    }
    int max2=-1;
    for(int j =0;j<n;++j){
        if (*(array+j)>max2 && *(array+j)<max){
            max2=*(array+j);
        }
    }
    return (max2);
}