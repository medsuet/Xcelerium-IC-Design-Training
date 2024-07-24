#include <stdio.h>

int main()
{
    int value = 10;
    int *ptr = &value;

    printf("The value of the interger is: %d\n", value);
    printf("The value of the interger using pointer is : %d\n", *ptr);

    *ptr = 20;
    printf("The modified value of the interger is: %d\n", value);
    return 0;
}    
