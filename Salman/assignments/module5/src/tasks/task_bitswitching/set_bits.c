#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// set any bit by assigning the bitnumber
void setBit (int* value, int bitnumber){
    int i = 1;
    *value = *value | (i << bitnumber);
}

// clear any bit giving the bitnumber
void clrBit (int* value, int bitnumber){
    int i = 1;
    *value = *value & ( -1 ^ ( i << bitnumber));
}

int main()
{
    int value = 10;
    int setbit = 2;
    int clrbit = 3;
    //printf("The interger value: %d\n", value);  // 1010 = 10

    setBit(&value, setbit);
    //printf("Set bit number 2 of the value: %d\n", value);  // 1110 = 14

    clrBit(&value, clrbit);
    //printf("Clear bit number 3 of the Set bit value: %d\n", value);  // 0110 = 6
    
    // endless loop 
    while (1)
    {
        /* code */
    }
    
    //return 0;
}
