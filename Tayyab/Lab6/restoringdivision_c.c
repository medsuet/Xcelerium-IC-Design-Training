/*
    Name: division.c
    Author: Muhammad Tayyab
    Date: 10-7-2024
    Description: Implements restoring division algorithem for uint32 numbers
*/

//#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

// Returns msb of num shifted to lsb position
#define GETMSB(num) (num) >> 31

void shiftLeft(uint32_t *reminder, uint32_t *quotient) {
    // Shifts reminder and quotient one place left as a single block
    
    // Store msb of quotient
    uint32_t quotient_msb = GETMSB(*quotient);

    // Shift reminder and quotient one place left
    *reminder = (*reminder) << 1;
    *quotient = (*quotient) << 1;
 
    // Place msb of quotient at lsb of reminder
    *reminder = (quotient_msb == 1) ? (*reminder | quotient_msb) : (*reminder & (~quotient_msb));
}

// TODO: Implement the restoring_division function
// It should take dividend and divisor as inputs and return quotient and remainder
void restoring_division(uint32_t dividend, uint32_t divisor, uint32_t *quotient, uint32_t *remainder) {
    // TODO: Implement the non-restoring division algorithm
    // Remember to handle division by zero
    // Returns quotient = remainder = 0 if divisor = 0

    // Q = quotient; A = remainder; M = Divisor

    int numBits;
    uint32_t remainder_msb;
    uint32_t remainder_copy;


    // Check division by zero case
    if (divisor == 0) {
        *quotient = 0;
        *remainder = 0;
        return ;
    };

    // Initialize values
    *quotient = dividend;
    *remainder = 0;
    numBits = 32;

    do {
        // Shift reminder quotient left
        shiftLeft(remainder, quotient);

        // Make a copy of reminder for restoring if required
        remainder_copy = *remainder;

        // Subtract divisor from reminder
        *remainder = (*remainder) - divisor;

        // Check msb of reminder
        remainder_msb = GETMSB(*remainder);
        if (remainder_msb == 1) {
            // Set lsb of quotient to 0
            *quotient = (*quotient) & (~( (uint32_t) 1 ));
            
            // Restore reminder
            *remainder = remainder_copy;
        }
        else {
            // Set lsb of quotient to 1
            *quotient = (*quotient) | (uint32_t) 1;
        }

        // Decrement counter
        numBits--;

    } while (numBits > 0 );         // Repeat until numBits becomes zero

    return ;
}

int main() {
    int a0, a1
    restoring_division()
}
