/*
#  =================================================================================
#  Filename:    division_nonrestore.c
#  Description: File consists of code to implement non restoring division algorithm
#  Author:      Bisal Saeed
#  Date:        7/15/2024
#  ==================================================================================
*/

#include <stdio.h>

void non_restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder) {
    // Initialize quotient and remainder
    *quotient = 0;
    *remainder = 0;
    
    // Loop for 32 bits
    for (int i = 31; i >= 0; i--) {
        // Shift remainder left by 1 (similar to multiplying by 2)
        *remainder <<= 1;
        
        // Set LSB of remainder with MSB of dividend
        *remainder |= (dividend >> i) & 1;
        
        // Subtract divisor from remainder
        *remainder -= divisor;
        
        // If remainder < 0, add divisor back and set quotient bit to 0
        if (*remainder < 0) {
            *remainder += divisor;
            *quotient <<= 1;  // Shift left by 1 (quotient bit is 0)
        } else {
            *quotient <<= 1;  // Shift left by 1 (quotient bit is 1)
            *quotient |= 1;   // Set LSB of quotient to 1
        }
    }
}

int main() {
    unsigned int dividend = 100;
    unsigned int divisor = 4;
    unsigned int quotient, remainder;
    
    // Perform non-restoring division
    non_restoring_division(dividend, divisor, &quotient, &remainder);
    
    // Print results
    printf("Quotient: %u\n", quotient);
    printf("Remainder: %u\n", remainder);
    
    return 0;
}
