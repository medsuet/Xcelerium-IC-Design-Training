#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

// Non Restoring Algorithm
void nonRestoringDivision ( uint32_t divisor, uint32_t dividend,\
                         uint32_t *quotient, uint32_t *remainder )
{
    // Initialize all the registers/variables
    uint32_t Q = dividend;
    uint32_t M = divisor;
    uint32_t A = 0;
    uint32_t N = 32;            // Number of bits in the dividend
    uint32_t i = 1;
    uint64_t combinedAQ = 0;    // Combined value of A and Q

    for (int j = 0; j<N; j++) {
        combinedAQ = ((uint64_t)A << 32 ) | Q;

        // Check the sign-bit of A and then decide to subtract or add A with divisor
        if ( (A & (i << (N-1))) == (i << (N-1)) ) {
            combinedAQ = combinedAQ << 1;

            A = ((uint64_t) combinedAQ >> 32) & (-1);
            Q = (uint64_t) combinedAQ & (-1);

            A = A + M;
        }
        else {
            combinedAQ = combinedAQ << 1;

            A = ((uint64_t) combinedAQ >> 32) & (-1);
            Q = (uint64_t) combinedAQ & (-1);

            A = A - M;
        }

        // Check the sign-bit of A and then decide the LSB of dividend
        if ( (A & (i << (N-1))) == (i << (N-1)) ) {
            Q = Q & (-1 ^ 1);
        }
        else {
            Q = Q | 1;
        }
    }

    // Check the sign-bit of A for adding with divisor or Not
    if ( (A & (i << (N-1))) == (i << (N-1)) ) {
        A = A + M;
    }
    else {
        A = A;
    }

    // Final values of Quotient and Remainder
    *quotient = Q;
    *remainder = A;
}

int main() {
    uint32_t quotient;
    uint32_t remainder;
    uint32_t divisor = 1000;
    uint32_t dividend = 1002;

    nonRestoringDivision (divisor, dividend, &quotient, &remainder);

    printf ("Divisor = %d, Dividend = %d\n",divisor, dividend);
    printf ("Quotient = %d, Remainder = %d\n", quotient, remainder);

    return 0;
}
