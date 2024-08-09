#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int reverseArray(int*Array,int size);
int main() {
    int Array[4]={10,5,100,999};
    int size=sizeof(Array)/sizeof(Array[0]);
    printf("Before Swapping\n");
    for (int i=0;i<size;++i){
        printf("%d ",*(Array+i));
    }
    reverseArray(Array,size);
    printf("\nAfter Swapping\n");
    for (int i=0;i<size;++i){
        printf("%d ",*(Array+i));
    }
    return 0;
}

int reverseArray(int*Array,int size){
    int temp[size];
    for (int i=0;i<size;++i){
        temp[size-i-1]=*(Array+i);
    }
    for (int i=0;i<size;++i){
        *(Array+i)=temp[i];
    }
    return 1;
}
