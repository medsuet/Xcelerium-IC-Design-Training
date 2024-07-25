/*Author: Muhammad Ahsan Javed
FIle name:divider.c
FIle Description: This file contains the code of divider*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

    // Function to perform left shift on combined remainder and dividend
__uint64_t Left_shift(__uint32_t dividend, __uint32_t remainder) {

    __uint64_t value;
    // Shift remainder left by 32 bits
    value = (__uint64_t)remainder << 32;  
    // Combine remainder and dividend 
    value = value | dividend;  
    // Perform left shift by 1            
    value = value << 1;                    
    return value;
}

void Divider(__uint32_t dividend , __uint32_t divisor){
    //checking if divisor is 0
    if( divisor == 0){
        printf("invalid division");
    }
    else{
    //printing value for dividend and divisor
    //printing the values using '/' and "%"

    printf("The remainder and quotient of divided %d and divisor %d using operaots: %d %d\n",dividend,divisor,dividend%divisor,dividend/divisor);

    // n is for number of iterations

    int n = 8*sizeof(__uint32_t);
    __uint32_t A = 0;
    __uint32_t temp_A = 0;
    __uint32_t msb_A = 0;
    for(int i=0; i<n; i++){
    // Perform the combined shift

        __uint64_t combined = Left_shift(dividend, A);
        A = (combined >> 32) & 0xFFFFFFFF;  
        dividend = combined & 0xFFFFFFFF;
        
    // Subtract divisor from A
        A = A - divisor;
        
    // Check the most significant bit of A
        msb_A = A & 0x80000000;
        if (msb_A == 0x80000000){
    // Restore A and set LSB of Q to 0
            A = A + divisor;
            dividend = dividend & 0xFFFFFFFE;
        } else {
    // Set LSB of Q to 1
            dividend = dividend | 0x00000001;
        }
    
    }
    //printing result of our function
    printf("Final Remainder: %u, Final Quotient: %u\n", A, dividend);
    }

}


int main(){
    srand(time(NULL));
    //calling the function
    for(int i =0;i<40;i++){
        Divider(rand() % 1000, rand() % 1000);
    }
  
    return 0;
}
