#include<stdio.h>

//Task 3.1
//Bubble sort algorithm
/*
void BubbleSort(int *arr,int size);
int main()
{
    int my_arr[] = {-2,45,0,11,-9};
    int len = sizeof(my_arr)/sizeof(my_arr[0]);
    BubbleSort(my_arr,len);
    for(int j = 0;j<len;j++)
    {
        printf("%d ",my_arr[j]);
    }
    return 0;
}
void BubbleSort(int *arr,int size)
{
    int step = 0;
    int i = 0;
    for(step = 0;(step<size-1);step++)
    {
        for(i=0;(i<size-1);i++)
        {
            //int temp;
            if(*(arr+i)>*(arr+i+1))
            {
                int temp = *(arr+i);
                *(arr+i) = *(arr+i+1);
                *(arr+i+1) = temp;
            }
        }
    }
}
*/


//Selection sort


/*
void SelectionSort(int *arr,int size);
int main()
{
    int my_arr[] = {20,12,10,15,2};
    int len = sizeof(my_arr)/sizeof(my_arr[0]);
    SelectionSort(my_arr,len);
    printf("Selection Sort is:\n");
    for(int x=0;x<len;x++)
    {
        printf("%d ",my_arr[x]);
    }
    return 0;

}
void SelectionSort(int *arr,int size)
{
    int step;
    int j;
    for(step = 0;(step<size-1);step++)
    {
        int min_index = step;
        for(j=step+1;j<size;j++)
        {
            if(*(arr+j)< *(arr+min_index))
            {
                min_index = j;
            }
        }
        int temp = *(arr+step);
        *(arr+step) = *(arr+min_index);
        *(arr+min_index) = temp;
    }
}

*/



//Task 3.2


/*
void BubbleSort(int *arr,int size);
int main()
{
    int my_arr[] = {-2,45,0,11,-9};
    int len = sizeof(my_arr)/sizeof(my_arr[0]);
    //Declaring a function pointer for sorting
    void (*SortFun)(int[],int) = BubbleSort;
    SortFun(my_arr,len);
    for(int j = 0;j<len;j++)
    {
        printf("%d ",my_arr[j]);
    }
    return 0;
}
void BubbleSort(int *arr,int size)
{
    int step = 0;
    int i = 0;
    for(step = 0;(step<size-1);step++)
    {
        for(i=0;(i<size-1);i++)
        {
            //int temp;
            if(arr[i]>arr[i+1])
            {
                int temp = *(arr+i);
                *(arr+i) = *(arr+i+1);
                *(arr+i+1) = temp;
            }
        }
    }
}
*/


//Task 3.3

void Calculator(int a,int b);
int main()
{
    int x = 10;
    int y = 3;
    //Use function pointer
    void(*FuncPointer)(int,int) = Calculator;
    FuncPointer(x,y);
}
void Calculator(int a,int b)
{
    printf("Addition is:%d\n",a+b);
    printf("Subtraction is:%d\n",a-b);
    printf("Multiplication is:%d\n",a*b);
    printf("Division is:%5.2f\n",(float) a/b);
    return 0;
}

