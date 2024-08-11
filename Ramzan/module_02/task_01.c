#include<stdio.h>
//Part 1: Pointer Basics and Arithmetic


//Task 1.1
/*
int main()
{
    int x = 10;
    int *ptr;
    ptr = &x;
    printf("Value using direct access is:%d\n",x);
    printf("Value using pointer access is:%d\n",*ptr);

    printf("Modified value is:\n");

    *ptr = 40;
    printf("Value after modification is:%d\n",*ptr);
    return 0;
}
*/



//Task 1.2
/*
int swap( int *a,int *b);
int main()
{
    int x = 10;
    int y = 20;
    printf("Elements before swap are x=%d,y=%d\n",x,y);
    swap(&x,&y);
    printf("Elements after swap are x=%d,y=%d\n",x,y);
}
int swap(int *a,int *b)
{
    int z;
    z = *a;
    *a = *b;
    *b = z;
    return 0;
}
*/



//Task 1.3

int main()
{
    int arr[5] = {1,2,3,4,5};
    int *ptr = arr;
    int sum = 0;
    int new_arr[5];
    printf("Elements of an arraay are:\n");
    for(int i=0;i<5;i++)
    {
        printf("%d ",(*ptr+i));
        sum = sum + *(ptr+i);
        new_arr[i] = arr[5-1-i];
    }
    printf("\n");
    printf("Sum of all elements is:%d\n",sum);
    printf("Reversed array is:\n");
    for(int i=0;i<5;i++)
    {
        printf("%d ",new_arr[i]);
    }
    //rintf("%d",new_arr[0]);
    return 0;
}



