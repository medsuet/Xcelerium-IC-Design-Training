#include <stdio.h>

// setting clear bit function
void setClearBit(int* num , int bit_num, int set_clear){

    if (set_clear == 1){ // setting the bit

        *num = ( *num | (1 << (bit_num  )) );
    }
    else //clearing the bit
    {
        *num =  (*num & (~(1 << (bit_num ))));
    }

}


int main(void){
    
    int num = 7;
    int bit_num = 2; 
    int set_clear = 0;
    
    
    setClearBit(&num , bit_num , set_clear );
    
 
    return 0;

}