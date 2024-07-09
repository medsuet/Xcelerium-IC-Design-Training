#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h> // Include limits.h for INT_MAX and INT_MIN

// Function to calculate the total bits in a number
int calculateBitCount(int number) {
    int count = 0;
    
    // Counting bits until the number is zero
    while (number != 0) {
        count++;
        number >>= 1; // Right Shift the number by 1 bit 
    }

    return count;
}

// Function to calculate 2's complement of a number
int complement(int a) {
    return (~a) + 1;
}

// Function to perform arithmetic right shift on combined multiplier and accumulator
long long arithmeticRightshift(int multiplier, int accumulator) {
    long long value;
    value = (long long)accumulator << 32; 
    value = value | (unsigned int)multiplier; 
    value = value >> 1; 
    return value;
}

// Function to perform Booth's multiplication algorithm
long long boothMultiplier(int multiplier, int multiplicand) {
    int n = 8 * sizeof(int); 
    int Q1 = 0; 
    int multiplierLsb; 
    int accumulator = 0; 
    
    for (int i = 0; i < n - 1; i++) {
        
        multiplierLsb = multiplier & 1;
  
        if ((multiplierLsb == 0) && (Q1 == 1)) {
            accumulator = accumulator + multiplicand; 
        } 
        else if ((multiplierLsb == 1) && (Q1 == 0)) {
            accumulator = accumulator + complement(multiplicand);
        }

        Q1 = multiplierLsb; 
        int accumalator1 = (int)(arithmeticRightshift(multiplier, accumulator) >> 32) & 0xFFFFFFFF; // Perform arithmetic right shift and get updated accumulator
        multiplier = (int)arithmeticRightshift(multiplier, accumulator) & 0xFFFFFFFF; // Update multiplier with shifted value
        accumulator = accumalator1;
    }

    return arithmeticRightshift(multiplier, accumulator);
}

// Function to run a single test case
void runTestCase(int multiplier, int multiplicand, long long expected) {
    if(multiplier >= 2147483647 || multiplier<= -2147483648 || multiplicand >= 2147483647 || multiplicand<= -2147483648){
        printf("The numebers are higher than 32 bits. Overfolw\n");
    }
    else{
        long long result = boothMultiplier(multiplier, multiplicand);
    if (result == expected) {
        printf("PASS: %d * %d = %lld\n", multiplier, multiplicand, result);
    }

    }
}

// Test function
//test cases including positive, negative, zero inputs,multiplication by zero, multiplication by 1, and edge cases (e.g., overflow)
void testBoothMultiplier() {
    // Positive cases
    runTestCase(10, 5, 10LL * 5);
    runTestCase(123, 456, 123LL * 456);

    // Negative cases
    runTestCase(-10, 5, -10LL * 5);
    runTestCase(10, -5, 10LL * -5);
    runTestCase(-123, -456, -123LL * -456);

    // Zero cases
    runTestCase(0, 0, 0LL);
    runTestCase(0, 123, 0LL);
    runTestCase(123, 0, 123LL * 0);

    // Multiplication by one
    runTestCase(1, 123, 1LL * 123);
    runTestCase(123, 1, 123LL * 1);

    // Edge cases
    runTestCase(INT_MAX, INT_MAX, (long long)INT_MAX * INT_MAX);
    runTestCase(INT_MIN, INT_MIN, (long long)INT_MIN * INT_MIN);
    runTestCase(INT_MAX, INT_MIN, (long long)INT_MAX * INT_MIN);
    runTestCase(INT_MIN, INT_MAX, (long long)INT_MIN * INT_MAX);
}

int main() {

    // Task Y

    // Initialize random number generator
    srand(time(NULL));

    // Generate random multiplier and multiplicand
    int multiplier = rand() % 1000; 
    int multiplicand = rand() % 1000;
    
    // Perform Booth's multiplication on the generated multiplier and multiplicand
    printf("Multiplier: %d, Multiplicand: %d\n", multiplier, multiplicand);
    long long result = boothMultiplier(multiplier, multiplicand);
    long long expected = (long long)multiplier * multiplicand;
    printf("Result: %lld\n", result);
    if(result == expected) {
        printf("Actual Result %lld and Expected Result %lld Test Pass\n", result, expected);
    } else {
        printf("Actual Result %lld and Expected Result %lld Test Fail\n", result, expected);
    }

    // Run predefined test cases
    //test function to verify the correctness of your Booth multiplier function
    testBoothMultiplier();
    return 0;
}
