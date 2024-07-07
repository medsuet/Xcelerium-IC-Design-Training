#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int BubbleSort(int*Array,int size);
int main() {
    int Array[6]={10,5,100,999,60,500};
    int size=sizeof(Array)/sizeof(Array[0]);
    printf("Before Sorting\n");
    for (int i=0;i<size;++i){
        printf("%d ",*(Array+i));
    }
    
    BubbleSort(Array,size);
    printf("\nAfter Sorting\n");
    for (int j=0;j<size;++j){
        printf("%d ",*(Array+j));
    }
    return 0;
}

int BubbleSort(int*Array,int size){
    int temp;
    int swap_count;
    while (swap_count!=0){
        swap_count=0;
        for (int i=0;i<size-1;++i){
            if (*(Array+i)>*(Array+i+1)){
            temp=*(Array+i+1);
            *(Array+i+1)=*(Array+i);
            *(Array+i)=temp;
            swap_count+=1;
            }
        }
    }
    return 1;
}
