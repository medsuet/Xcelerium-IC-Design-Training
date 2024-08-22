#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int SelectionSort(int*Array,int size);
int main() {
    

    printf("\nUsing SelectionSort function:\n");
    int Array[6]={10,5,100,999,60,500};
    int size=sizeof(Array)/sizeof(Array[0]);
    printf("Before Sorting\n");
    for (int i=0;i<size;++i){
        printf("%d ",*(Array+i));
    }
    int (*SelectionSort_ptr)(int *,int)=&SelectionSort;
    SelectionSort_ptr(Array,size);
    printf("\nAfter Sorting\n");
    for (int j=0;j<size;++j){
        printf("%d ",*(Array+j));
    }
    return 0;
}

int SelectionSort(int*Array,int size){
    int temp,min_index;
    int swap_count,min;
    int DO;
    while (swap_count!=0){
        swap_count=0;
        for (int k=0;k<size;k++){
            min=10000;
            DO=0;
            for (int i=k;i<size;++i){
                if(*(Array+i)<min){
                    min=*(Array+i);
                    min_index=i;
                    DO=1;
                }
            } 
            if (DO==1){
                temp=*(Array+k);
                *(Array+k)=min;
                *(Array+min_index)=temp;
            }
        }
    }
    return 1;
}