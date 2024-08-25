#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

// Function to calculate 2's complement of a number
int complement(int a) {
    return (~a) + 1;
}

void restoring_division(uint32_t dividend, uint32_t divisor, uint32_t *quotient, uint32_t *remainder) {
    
    // step-1: initalize the Q and A register
    uint64_t quotientQ = dividend; // Q register
    uint64_t remainderA = 0; // A register initialize with zero represent remainder
    int n = 8 * sizeof(uint32_t); // Number of bits in dividend
    

    for (int i = 0; i < n; i++) {
        // Step-2: Shift left A and Q as a single unit
        // left shift on A and take MCB from Q and inserts it into the LSB of A
        remainderA = (remainderA << 1) | ((quotientQ >> (n - 1)) & 1);
        quotientQ = quotientQ << 1; 
    

        // Step-3: Subtract divisor from A
        remainderA = remainderA + complement(divisor);

        // Step-4: Check MSB of A --> bit at the (n - 1) position in A is 0
        if ((remainderA & ((uint64_t)1 << (n - 1))) == 0) {
            quotientQ |= 1; // Set LSB of Q to 1
        } else {
            remainderA = remainderA + divisor; // Restore A
        }
    }

    *quotient = (uint32_t)quotientQ;
    *remainder = (uint32_t)remainderA;
}

// Function to run test cases
void run_test_case(uint32_t dividend, uint32_t divisor) {
    uint32_t quotient, remainder;
    if (divisor == 0){
        printf("Division is imposible. Undefine\n");
    }
    else{
        restoring_division(dividend, divisor, &quotient, &remainder);
        printf("%u / %u Quotient: %u, Remainder: %u\n", dividend, divisor, quotient, remainder);

    }
    
}

int main() {

    // Initialize random number generator
    srand(time(NULL));

    // Test using random numbers
    int dividend = rand() % 1000;
    int divisor = rand() % 1000;
    run_test_case(dividend, divisor);

    // Multiple test cases
    run_test_case(7, 3);
    run_test_case(100, 25);
    run_test_case(1234, 432);
    run_test_case(0, 3);
    run_test_case(3, 0); // Special case 
    
    return 0;
}
