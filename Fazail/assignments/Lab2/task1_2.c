#include <stdio.h>

// The code will swap the value of the two integers using pointers

int main()
{
    int value1 = 3;
    int value2 = 21;
    int temp_value = value1;
    
    int *ptr1 = &value1;
    int *ptr2 = &value2;     // This holds the address of 2nd value.
    int *temp_ptr = &temp_value;

    printf("Value of integer 1: %d\n", value1);
    printf("Value of integer 2: %d\n", value2);

    *ptr1     = *ptr2;
    *ptr2     = *temp_ptr;

    printf("Swaped Value of integer 1: %d\n", value1); 
    printf("Swaped Value of integer 2: %d\n", *ptr2);
    return 0;
}
