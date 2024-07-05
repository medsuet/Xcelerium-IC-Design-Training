#include <stdio.h>
#include <stdint.h>

// Function prototypes
void arithmeticShiftRight(int32_t *accumulator, int32_t *multiplier, int *leastSignificantBitQ, int numBits);
void add(int32_t *accumulator, int32_t multiplicand);
void subtract(int32_t *accumulator, int32_t multiplicand);
int32_t boothMultiplication(int32_t multiplicand, int32_t multiplier);

// Function to perform arithmetic shift right
void arithmeticShiftRight(int32_t *accumulator, int32_t *multiplier, int *leastSignificantBitQ, int numBits) {
    int32_t sign = (*accumulator >> (numBits - 1)) & 1;
    *leastSignificantBitQ = *multiplier & 1;
    *multiplier >>= 1;
    *multiplier |= ((*accumulator & 1) << (numBits - 1));
    *accumulator >>= 1;
    if (sign) {
        *accumulator |= (1 << (numBits - 1));
    } else {
        *accumulator &= ~(1 << (numBits - 1));
    }
}

// Function to add multiplicand to accumulator
void add(int32_t *accumulator, int32_t multiplicand) {
    *accumulator += multiplicand;
    
}

// Function to subtract multiplicand from accumulator using 2's complement
void subtract(int32_t *accumulator, int32_t multiplicand) {
    add(accumulator, ~multiplicand + 1);  // Adding the 2's complement of multiplicand
}

// Function implementing Booth's multiplication algorithm
int32_t boothMultiplication(int32_t multiplicand, int32_t multiplier) {
    int32_t accumulator = 0;
    int leastSignificantBitQ = 0;// Qn+1 initailize with zero
    int numBits = sizeof(int32_t) * 8;
    
    for (int i = 0; i < numBits; ++i) {
        // ((multiplier & 1) check if LSB of multiplier is 0 or 1 If the LSB is 0, this evaluates to true. otherwise false
        if ((multiplier & 1) == 0 && leastSignificantBitQ == 1) {// if Q = 0, Qn+1 = 1 
            add(&accumulator, multiplicand);
        } else if ((multiplier & 1) == 1 && leastSignificantBitQ == 0) {
            subtract(&accumulator, multiplicand);
        }
        arithmeticShiftRight(&accumulator, &multiplier, &leastSignificantBitQ, numBits);
    }
    
    return (accumulator << numBits) | (multiplier & ((1 << numBits) - 1));
}

void testBoothMultiplication() {
    // Test cases
    int32_t testCases[10][3] = {
        {7, 3, 21},       // Positive * Positive
        {-3, 2, -6},     // Negative * Positive
        {3, -2, -6},     // Positive * Negative
        {-3, -2, 6},     // Negative * Negative
        {0, 2, 0},       // Zero * Positive
        {2, 0, 0},       // Positive * Zero
        {0, 0, 0},       // Zero * Zero
        {1, 2, 2},       // One * Positive
        {2, 1, 2},       // Positive * One
        {INT32_MAX, 1, INT32_MAX}, // Large number * One
    };
    
    for (int i = 0; i < 10; ++i) {
        int32_t multiplicand = testCases[i][0];
        int32_t multiplier = testCases[i][1];
        int32_t expected = testCases[i][2];
        int32_t result = boothMultiplication(multiplicand, multiplier);
        
        if (result == expected) {
            printf("Test case %d passed: %d * %d = %d\n", i+1, multiplicand, multiplier, result);
        } else {
            printf("Test case %d failed: %d * %d = %d, expected %d\n", i+1, multiplicand, multiplier, result, expected);
        }
    }
}

int main() {
    testBoothMultiplication();
    return 0;
}
