#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int swap(int*a,int*b);
int main() {
    int integer1=9;
    int integer2=67;
    int * ptr1=&integer1;
    int * ptr2=&integer2;
    printf("Before swapping:\n");
    printf("Value of integer1=%d\n",integer1);
    printf("Value of integer2=%d\n",integer2);
    swap(ptr1,ptr2);
    printf("After swapping:\n");
    printf("Value of integer1=%d\n",integer1);
    printf("Value of integer2=%d\n",integer2);
}
int swap(int*a,int*b){
    int temp;
    temp=*b;
    *b=*a;
    *a=temp;
    return 0;
}
