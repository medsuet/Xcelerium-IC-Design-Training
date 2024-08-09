// #include <stdio.h>
// #include <stdint.h>
// #include <limits.h>

// Define the number of bits in a 32-bit unsigned integer
#define BITS_IN_UINT32 32

// Function prototypes

void non_restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder);
void run_test_case(unsigned int dividend, unsigned int divisor);

// Implement the non-restoring division algorithm
void non_restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder) {
    // Initialize registers
    unsigned int Q = dividend;        // Dividend
    unsigned int M = divisor;         // Divisor
    unsigned int A = 0;               // Accumulator
    unsigned int n = BITS_IN_UINT32;  // Number of bits
    unsigned int Q0;                  // Least significant bit of Q
    unsigned long long combinedAQ;          // Combined A and Q for shifting

    // Handle division by zero
    if (divisor == 0) {
        // printf("Error: Division by zero.\n");
        *quotient = 0;
        *remainder = 0;
        return;
    }

    // Initialize quotient and remainder
    *quotient = 0;
    *remainder = 0;

    while(n != 0){
        if(A & 0x80000000) {
            combinedAQ = ((unsigned long long)A << 32) | Q;
            combinedAQ = (combinedAQ << 1);
            Q = combinedAQ & 0xFFFFFFFF;
            A = (combinedAQ >> 32) & 0xFFFFFFFF;
            A = A + M;
        }
        else {
            combinedAQ = ((unsigned long long)A << 32) | Q;
            combinedAQ = (combinedAQ << 1);
            Q = combinedAQ & 0xFFFFFFFF;
            A = (combinedAQ >> 32) & 0xFFFFFFFF;
            A = A - M;
        }

        if(A & 0x80000000) {
            // MSB of A is 1, so set the LSB of Q to 0 and restore A
            Q &= 0xFFFFFFFE;
        }
        else {
            // MSB of A is 0, so set the LSB of Q to 1
            Q |= 1;
        }
        
        n = n - 1;
    }
    if(A & 0x80000000) {
        A = A + M;
    }
    // Step 9: Finally, the register Q contains the quotient and A contains remainder
    *quotient = Q;
    *remainder = A;
}

// TODO: Implement test cases
void run_test_case(unsigned int dividend, unsigned int divisor) {
    // TODO: Call restoring_division and verify the results
    unsigned int quotient, remainder;
    unsigned int actualQ, actualR;

    // Call restoring_division
    non_restoring_division(dividend, divisor, &quotient, &remainder);

    // Compare with standard division
    actualQ = dividend / divisor;
    actualR = dividend % divisor;
    // Print both the restored values and actual values
    // printf("Test Case:\n");
    // printf("Dividend: %u, Divisor: %u\n", dividend, divisor);
    // printf("Restored Quotient: %u, Restored Remainder: %u\n", quotient, remainder);
    // printf("Operator Quotient: %u, Operator Remainder: %u\n", actualQ, actualR);


    // Validate results
    // If restored values are equal to actual, print results matched.
    // if (quotient == actualQ && remainder == actualR) {
        // printf("Results match!\n\n");
    // } else {
        // printf("Results do not match.\n\n");

    // }
}

int main() {
    // TODO: Implement multiple test cases
    // Example:
    //run_test_case(20, 5);

    // Seed the random number generator
    // srand(time(NULL));

    // // Implement multiple test cases
    // for (int i = 0; i < 10; i++) {
    //     // Random dividend
    //     uint32_t dividend = rand() % 1000;

    //     // Random divisor 
    //     uint32_t divisor = rand() % 1000; 

    //     // Ensure we don't divide by zero
    //     if (divisor == 0) {
    //         divisor = 1; 
    //     }

    //     run_test_case(dividend, divisor);
    // }
    run_test_case(122, 6);
    run_test_case(12, 9);
    run_test_case(443, 722);
    run_test_case(122, 222);
    run_test_case(10000, 2000);
    return 0;
}