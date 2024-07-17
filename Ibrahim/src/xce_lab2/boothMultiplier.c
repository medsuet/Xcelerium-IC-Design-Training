#include <stdio.h>
// #include <time.h>
// #include <stdlib.h>
#include <limits.h>
#include <stdint.h>

// Function prototypes
int add(int a, int b);
int sub(int a, int b);

void shiftRight(int *Q, int *M, int *Q_1, int *A);
int boothMultiply(int multiplicand, int multiplier);

// Function to perform addition
int add(int firstNumber, int secondNumber) {
    return firstNumber + secondNumber;
}

// Function to perform addition
int sub(int firstNumber, int secondNumber) {
    return firstNumber - secondNumber;
}
// Function to find the 2's complement
int twosComplement(int num) {
    int complement = ~num + 1;
    printf("2's Complement: %d\n", complement);
    return complement;
}

__int64_t rightShifting(int multiplier, int accumulator, int* Q_1, int* lsbMultiplier) {
    __int64_t combined;
    *Q_1 = *lsbMultiplier;
    combined = ((__int64_t)accumulator << 32) | (__uint32_t)multiplier;
    combined = (combined >> 1);
    //((__int64_t)*lsbMultiplier << 63) |cd
    return combined;
} 

__int64_t boothMultiplier(int multiplicand, int multiplier) {
    int accumulator = 0;
    __int64_t product;
    int lsbMultiplier; 
    int Q_1 = 0;
    int count = sizeof(int) * 8;

    for(int i = 0; i < count; i++){
        lsbMultiplier = multiplier & 1;
        //printf("accumulator0: %d, multiplier0: %d\n", accumulator, multiplier);

        if((lsbMultiplier == 1) && (Q_1 == 0)) {
            //accumulator = add(accumulator, twosComplement(multiplicand));
            accumulator = sub(accumulator, multiplicand);
        } 
        else if((lsbMultiplier == 0) && (Q_1 == 1)) {
            accumulator = add(accumulator, multiplicand);
        }
        product = rightShifting(multiplier, accumulator, &Q_1, &lsbMultiplier);
        accumulator = ((product >> 32) & 0xFFFFFFFF);
        multiplier  = ((product) & 0xFFFFFFFF);
        // printf("accumulator: %d, multiplier: %d\n", accumulator, multiplier); 
    }

    return product;
}

// Test function
void testBoothMultiply() {
    // Test cases
    int testCases[][3] = {
        {-146, -146, 21316},
        {-5, 3, -15},
        {5, -3, -15},
        {-5, -3, 15},
        {0, 5, 0},
        {5, 0, 0},
        {INT_MAX, 1, INT_MAX},
        {1, INT_MAX, INT_MAX},
        {-1, INT_MAX, -INT_MAX},
        {1, INT_MIN, INT_MIN},
        {-1, (INT_MIN + 1), INT_MAX}
    };

    for (int i = 0; i < sizeof(testCases) / sizeof(testCases[0]); i++) {
        int multiplicand = testCases[i][0];
        int multiplier = testCases[i][1];
        __int64_t expected = testCases[i][2];
        __int64_t result = boothMultiplier(multiplicand, multiplier);
    
     // Initialize random number generator
    // srand(time(NULL));

    // // Generate random multiplier and multiplicand
    // int multiplier = rand() % 1000; 
    // int multiplicand = rand() % 1000;
    // int expected = multiplier * multiplicand;
    // __int64_t result;
        printf("Multiplicand: %d, Multiplier: %d, Expected: %ld, Result: %ld\n",
               multiplicand, multiplier, expected, result);

        if (result != expected) {
            printf("Test case failed!\n");
        } else {
            printf("Test case passed.\n");
        }
    }
}


int main() {
    testBoothMultiply();
    return 0;
}
