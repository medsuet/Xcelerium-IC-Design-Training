#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

/*
code written by: Usman Shahzad
Date: 10 july 2024

This file is performing division operations on unsigned integers
using mathod of restoring of Division Algorithm
*/


// Function to perform restoring division
void restoring_division(uint32_t dividend, uint32_t divisor, uint32_t *quotient, uint32_t *remainder) {
    if (divisor == 0) {
        // Handle division by zero case
        *quotient = *remainder = 0xFFFFFFFF; // Use max value to indicate error
        return;
    }

    uint32_t A = 0;
    uint32_t Q = dividend;
    uint32_t M = divisor;
    uint32_t n = sizeof(uint32_t) * 8; // Number of bits in uint32_t

    for (uint32_t i = 0; i < n; i++) {
        // Step 2: Shift A and Q left by 1 bit
        A = (A << 1) | ((Q >> (n - 1)) & 1);
        Q = Q << 1;

        // Step 3: Subtract M from A
        A = A - M;

        // Step 4: Check MSB of A
        if ((A & (1 << (n - 1))) == 0) {
            Q = Q | 1; // Set LSB of Q to 1
        } else {
            A = A + M; // Restore A
        }
    }

    *quotient = Q;
    *remainder = A;
}

int main() {
for(int i=0; i<=10; i++){
    uint32_t dividend = rand();
    uint32_t divisor = rand();
    uint32_t quotient, remainder;

    restoring_division(dividend, divisor, &quotient, &remainder);
    if(quotient != dividend/divisor || remainder != dividend % divisor){

             printf("test failed for Dividend: %u, Divisor: %u\n", dividend, divisor);
             printf("Expected Quotient: %u, Remainder: %u\n", quotient, remainder);
             printf("Got Quotient: %u, Remainder: %u",dividend/divisor, dividend%remainder);
             return 1;
    }
}    
    printf("All test passed\n");

    return 0;
}
