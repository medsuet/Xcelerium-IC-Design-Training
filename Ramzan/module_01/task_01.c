
//Task 0.1: Basic Syntax and Data Types

//part(a)

#include<stdio.h>
#include <stdlib.h>
void printSizes(int a,float b,double c,char d);
int main()
{
    int x = 2;
    float y = 3.4;
    double z= 3.1234566;
    char zz = 'A';
    // TODO: Declare variables of different types and print their sizes
    printSizes(x,y,z,zz);
}
void printSizes(int a,float b,double c,char d) {
    printf("Size of an integer is:%zu\n",sizeof(a));
    printf("Size of an float is:%zu\n",sizeof(b));
    printf("Size of an double is:%zu\n",sizeof(c));
    printf("Size of an char is:%zu\n",sizeof(d));
    return 0;
}

//part(b)