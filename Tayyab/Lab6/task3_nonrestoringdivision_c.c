/*
    Name: task3_nonrestoringdivision_c.c
    Author: Muhammad Tayyab
    Date: 15-7-2024
    Description: Implements non restoring division algorithem for unsigned 32 bit numbers
*/

// If FOR_RISCV flag is defined, code used to run random tests on tha algorithem
// is not be compiled: only the core part algorithem running a perticular test shall be compiled.
#define FOR_RISCV

#ifndef FOR_RISCV
#include<stdio.h>
#include<stdlib.h>
#endif

/* Returns nth bit of number (lsb is bit 0) */
#define getbit(number, n) ((number >> n) & 1)

/*
    Name: myrand.c
    Author: Muhammad Tayyab
    Date: 16-7-2024
    Description: Generates pseudorandom unsiged integers.
*/

void nonRestoringDivision(unsigned int Q, unsigned int M, unsigned int *P, unsigned int *A) {
    /*
        Non restoring division algorithem for 32 bit integers
        Arguments: Q: dividend    M: divisor
                  *P: pointer to quotient
                  *A: pointer to remainder
        Outputs: Puts quotient and remainder in Q and A in place
    */
    // Division by zero case
    if (M == 0) {
        *A=0;
        *P=0;
        return;
    }

    *A = 0;
    unsigned int n = 32;
    unsigned int signbit_A, msb_Q;

    for (unsigned int i=n; i>0; i--) {
        //printf("i:%d \nQ: %x \nA: %x\n\n",i,Q,*A);

        signbit_A = getbit(*A, n-1);

        // Shift AQ left
        msb_Q = getbit(Q, n-1);
        *A = ((*A) << 1);
        Q = Q << 1;
        *A = (*A) | msb_Q;               // place msb of Q at lsb of A

        if (signbit_A == 1) {
            *A = *A + M;
        }
        else {
            *A = *A - M;
        }
        signbit_A = getbit(*A, n-1);
        if (signbit_A == 1)
            Q = Q & (~1);               // set Q[0]=0
        else
            Q = Q | 1;                  // set Q[0]=1
    }
    signbit_A = getbit(*A, n-1);
    if (signbit_A == 1)
        *A = (*A) + M;

    *P = Q;
}

#ifndef FOR_RISCV
int random_tests() {
    /*
        Runs nonRestoringDivision function a set number of times on random numbers and tests the output
        against correct values.
        
        Arguments: None
        Returns: all tests passed ? 0 : 1
    */

   // Observation: C can run 1e9 test in about same time as Python runs 1e6 tests
    unsigned int numTests = 1e9;                    // number of times test is run
    unsigned int testNumRange = __UINT32_MAX__;      // max value of random numbers used in tests

    unsigned int num1, num2;
    unsigned int test_quotient, test_remainder;
    unsigned int correct_quotient, correct_remainder;

    for (unsigned int i=0; i<numTests; i++) {
        // Get two random values for testing
        num1 = rand() % testNumRange;
        num2 = rand() % testNumRange;

        // Skip division by zero case
        if (num2 == 0) continue;

        // Run nonRestoringDivision function on test values and get results
        nonRestoringDivision(num1, num2, &test_quotient, &test_remainder);

        // Calculate correct values of quotient and remainder
        correct_quotient = num1/num2;
        correct_remainder = num1%num2;

        // Compare values genereated by test function against correct values
        if ((test_quotient != correct_quotient) || (test_remainder != correct_remainder)) {
            
            printf("Failed at %u / %u  (%uth test)\n\n", num1, num2, i);
            printf("Test:     Q: %u \t R: %u\n", test_quotient, test_remainder);
            printf("Correct:  Q: %u \t R: %u\n", correct_quotient, correct_remainder);

            return 1;
        }
    }
    
    printf("Passed all %u tests\n\n", numTests);

    return 0;
}
#endif

int main() {
    #ifndef FOR_RISCV
    random_tests();
    #endif

    unsigned int dividend=40;
    unsigned int divisor=7;
    unsigned int quotient, remainder;

    nonRestoringDivision(dividend, divisor, &quotient, &remainder);

    return 0;
}