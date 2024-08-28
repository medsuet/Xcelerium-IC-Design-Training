#include <stdio.h>
#include <stdint.h>

void non_restoring_division(uint64_t dividend, uint64_t divisor, uint64_t* quotient, uint64_t* remainder) {
    uint64_t Q = dividend;      // Quotient 
    uint64_t M = divisor;       // Divisor
    int64_t A = 0;              // Remainder, treated as signed for comparison
    uint64_t n = 64;            // Number of bits in the dividend

    if (Q == 0) {
        *quotient = 0;
        *remainder = Q;
        return;  
    }
    if (M == 0) {
        *quotient = 0xFFFFFFFFFFFFFFFF;
        *remainder = 0xFFFFFFFFFFFFFFFF;
        return;
    }

    while (n != 0) {
        // Shift A and Q to the left as a single unit
        A = (A << 1) | ((Q >> 63) & 1);
        Q = Q << 1;

        if (A >= 0) {  // Check if A is non-negative
            A = A - M;
        } else {
            A = A + M;
        }

        if (A >= 0) {
            Q = Q | 1;
        } else {
            Q = Q & ~1;
        }

        n = n - 1;
    }

    if (A < 0) {
        A = A + M;
    }

    *quotient = Q;
    *remainder = A;
}

int main(void) {
    uint64_t dividend = 3;
    uint64_t divisor = 2;
    uint64_t quotient, remainder;
    non_restoring_division(dividend, divisor, &quotient, &remainder);


    return 0;
}
