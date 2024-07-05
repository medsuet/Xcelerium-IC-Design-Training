
//Task-03

//part(a)

//Programme to find Fibbonacci Squence of numbers between 1 and 100;
#include<stdio.h>

int main()
{
    int num=10;
    int n1=0;
    int n2=1;
    int next_num;
    for(int i=0;i<10;i++)
    {
        printf("%d\n",n1);
        next_num = n1+n2;
        n1 = n2;
        n2 = next_num;
    }
    return 0;
}

