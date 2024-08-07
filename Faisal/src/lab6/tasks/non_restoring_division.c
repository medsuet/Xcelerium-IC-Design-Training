#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

// division by zero 

void divisionByZero(){
    // handling division by zero 
    printf("Error: Division by zero.\n");
    // exit from program
    exit(1);
    return;
}

// TODO: Implement the restoringDivision function

uint64_t shiftLeft(uint32_t remainder, uint32_t dividend){
    uint64_t result;
    result = (uint64_t)remainder << 32;
    result = result | dividend;
    result = result << 1;
    return result;
}

// It should take dividend and divisor as inputs and return quotient and remainder
void restoringDivision(uint32_t dividend, uint32_t divisor, uint32_t *quotient, uint32_t *remainder) {
    // TODO: Implement the non-restoring division algorithm
    // Remember to handle division by zero
    // initialization 
    // *remainder = 0;
    // *quotient = 0;

    // handling division by zero 
    if (divisor == 0){
        divisionByZero();
    }
    int bitLength = sizeof(uint32_t) * 8;

    for (int i = 0; i < bitLength; i++){
        // shift left remainder and divided
        uint64_t remainderDividendBound = shiftLeft(*remainder, dividend);
        // extracting remainder from remainder-divided remainderDividendBound
        *remainder = (uint32_t)(remainderDividendBound >> 32);
        // extracting divided from remainder-divided remainderDividendBound
        dividend = (uint32_t)(remainderDividendBound & 0xFFFFFFFF);
        // update remainder
        // *remainder = remainder1;
        // save it another variable
        uint32_t restoredRemainder = *remainder;
        // a-m - remainder - dividend
        *remainder = *remainder - divisor;
        // exttracting MSB of remainder
        // int remainderMsb = (*remainder >> (bitLength-1)) & 1;
        // if MSB = 1 restored remainder
        if (*remainder & (1 << 31)){
            *quotient  <<= 1;
            *remainder = restoredRemainder;
        }
        else {
            *quotient = (*quotient << 1)  | 1;
        }
    }
    printf("The Remainder is: %u\n", *remainder );
    printf("The quotient is: %u\n", *quotient);
}


// TODO: Implement test cases
// Function to run a test case
void runTestCase(uint32_t dividend, uint32_t divisor) {
    // TODO: Call restoringDivision and verify the results
    uint32_t quotient = 0;
    uint32_t remainder = 0;
    restoringDivision(dividend, divisor, &quotient, &remainder);
    // handling division by zero 
    // if (divisor == 0){
    //     divisionByZero();
    // }

    uint32_t expected_quotient = dividend / divisor;
    uint32_t expected_remainder = dividend % divisor;

    printf("Dividend: %u, Divisor: %u\n", dividend, divisor);
    printf("Computed Quotient: %u, Computed Remainder: %u\n", quotient, remainder);
    printf("Expected Quotient: %u, Expected Remainder: %u\n", expected_quotient, expected_remainder);

    if (quotient == expected_quotient && remainder == expected_remainder) {
        printf("Test case passed.\n");
    } else {
        printf("Test case failed.\n");
    }
    printf("\n");
}

// Main function to run multiple test cases
int main() {
    // TODO: Implement multiple test cases
    // Seed the random number generator
    srand(time(NULL));
    // runTestCase(dividend, divisor)
    runTestCase(0, 15);
    runTestCase(20, 3);
    runTestCase(1, 20);
    runTestCase(100, 10);
    runTestCase(4294967295, 1);
    runTestCase(1234567890, 987654321);
    runTestCase(11, 3);  // Added the original test case you provided
    runTestCase(( rand() % 100000 ), ( rand() % 1000 ) );
    // division by zero
    runTestCase(20, 0);
    // runTestCase(0, 0);
    return 0;
}