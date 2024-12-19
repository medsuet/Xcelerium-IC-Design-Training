/*
#include <stdio.h>
#include <stdint.h>

*/
void divisionAlgorithm(int32_t dividend, int32_t divisor) {
    int A = 0;
    int Q = dividend;
    int M = divisor;
    int n = sizeof(int32_t) * 8; // Number of bits in dividend

    for (int i = 0; i < n; i++) {
        // Step 2: Shift left A and Q
        A = (A << 1) | ((Q & (1 << (n - 1))) >> (n - 1));
        Q <<= 1;

        // Step 3: Check sign bit and add/subtract M
        if (A < 0) {
            A += M; // A = A + M
        } else {
            A -= M; // A = A - M
        }

        // Step 5: Set Q[0]
        if (A < 0) {
            Q &= ~1; // Q[0] = 0
        } else {
            Q |= 1;  // Q[0] = 1
        }
    }

    // Step 8: Check sign bit of A
    if (A < 0) {
        A += M; // A = A + M
    }

    // Result
    //printf("Quotient: %d\n", Q);
    //printf("Remainder: %d\n", A);
}

int main() {
    int dividend = 25;
    int divisor = 3;

    divisionAlgorithm(dividend, divisor);

    return 0;
}
