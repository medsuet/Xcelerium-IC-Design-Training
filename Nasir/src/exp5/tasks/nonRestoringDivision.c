// including header files
#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include<time.h>

// function prototypes
uint64_t shiftLeft(uint32_t remainder, uint32_t dividend);

void nonRestoringDivision(uint32_t dividend, uint32_t divisor, uint32_t *remainder, uint32_t *quotient);

uint64_t shiftLeft(uint32_t remainder, uint32_t dividend){
    uint64_t result;
    result = (uint64_t)remainder << 32;
    result = result | dividend;
    result <<= 1;
    return result;
}

void nonRestoringDivision(uint32_t dividend, uint32_t divisor, uint32_t *remainder, uint32_t *quotient){
    if (divisor == 0){
        return;
    }
    for (int shift = 0; shift < 32; shift++){
        // extracting remainder sign bit
        int remainderSignBit = *remainder & (1 << 31);
        // shift remainder and dividend by 1
        uint64_t remainderDividendComb = shiftLeft(*remainder, dividend);
        // update remainder
        *remainder = (uint32_t)(remainderDividendComb >> 32);
        // update dividend
        dividend = (uint32_t)(remainderDividendComb & 0xFFFFFFFF);
        // checking sign of remainder
        // if 1 a = a+m = r = r+divisor
        if (remainderSignBit) {
            *remainder += divisor;
        }
        else{
            *remainder -= divisor;
        }

        // checking signbit if 1 q[0] = 0
        if(*remainder & (1 << 31)){
            // update quotient lsb
            *quotient <<= 1;
        }
        // else q[0] = 1
        else{
            *quotient = (*quotient << 1) | 1;
        }

    if (*remainder & (1 << 31)){
        *remainder +=  divisor;
    }
    
    }
}

// TODO: Implement test cases
// Function to run a test case
void runTestCase(uint32_t dividend, uint32_t divisor) {
    // TODO: Call restoringDivision and verify the results
    uint32_t quotient = 0;
    uint32_t remainder = 0;
    nonRestoringDivision(dividend, divisor, &remainder, &quotient);
    // handling division by zero 
    if (divisor == 0){
        printf("Division by Zero Handled correctly \n");
        return;
    }

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


