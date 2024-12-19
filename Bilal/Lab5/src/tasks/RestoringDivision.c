#include <stdint.h>
#include <stdlib.h>

// Restoring Division Function
void restoringDivision(uint32_t dividend, uint32_t divisor, uint32_t *quotient, uint32_t *remainder) {
    uint32_t Q = dividend; // Quotient
    uint32_t M = divisor;  // Divisor
    uint32_t A = 0;        // Remainder
    uint32_t n = 32;       // Number of bits in the dividend

    if (Q == 0) {
        *quotient = 0;
        *remainder = Q;
        return;
    }

    if (M == 0) {
        *quotient = 0xFFFFFFFF;  // Max value of unsigned 32-bit integer
        *remainder = 0xFFFFFFFF;
        return;
    }

    for (uint32_t i = 0; i < n; i++) {
        // Shift A and Q left as a single unit
        A = (A << 1) | ((Q >> 31) & 1);
        Q = Q << 1;

        // Subtract divisor from A
        uint32_t temp = A;
        A = A - M;

        // Check the MSB of A
        if ((A & (1 << 31)) == 0) {  // MSB is 0
            Q = Q | 1; // Set LSB of Q to 1
        } else {       // MSB is 1
            A = temp;  // Restore A
        }
    }

    *quotient = Q;
    *remainder = A;
}

// Test cases
void testCase(uint32_t dividend, uint32_t divisor, uint32_t* restoringQuotient, uint32_t* restoringRemainder, uint32_t* standardQuotient, uint32_t* standardRemainder) {
    uint32_t quotient;
    uint32_t remainder;

    restoringDivision(dividend, divisor, &quotient, &remainder);

    *restoringQuotient = quotient;
    *restoringRemainder = remainder;

    if (divisor != 0) {
        *standardQuotient = dividend / divisor;
        *standardRemainder = dividend % divisor;
    } else {
        *standardQuotient = 0xFFFFFFFF;  // undefined
        *standardRemainder = 0xFFFFFFFF; // undefined
    }
}

int main() {
    uint32_t restoringQuotient, restoringRemainder, standardQuotient, standardRemainder;

    // Run multiple test cases
    testCase(30, 3, &restoringQuotient, &restoringRemainder, &standardQuotient, &standardRemainder);
    testCase(20, 2, &restoringQuotient, &restoringRemainder, &standardQuotient, &standardRemainder);
    testCase(0, 10, &restoringQuotient, &restoringRemainder, &standardQuotient, &standardRemainder);  // Test case for zero dividend
    testCase(10, 0, &restoringQuotient, &restoringRemainder, &standardQuotient, &standardRemainder);  // Test case for zero divisor

    return 0;
}
