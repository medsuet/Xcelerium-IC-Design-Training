#include <stdio.h>
#include <stdlib.h>
#include <time.h>


// two's complement

int twoscomplement(int number){
    return ((~number) + 1);
}

// Function to perform arithmetic right shift (signed shift)
long long arithmeticRightShift(int accumulator, int multiplier) {
    long long result;
    result = (long long)accumulator << 32;
    result = result | (unsigned int)multiplier;
    return result >> 1;
}

// Function to perform addition with debugging output
int add(int a, int b) {
    printf("Adding %d and %d\n", a, b);
    return a + b;
}

// Function to perform Booth's multiplication algorithm
long long boothMultiplier(int multiplier, int multiplicand) {
    long long product = 0;
    int bitLength = sizeof(int) * 8; // Bit length of integers, assuming 32-bit or 64-bit
    printf("The size of int is: %d bits\n", bitLength);
    // Initialize variables for Booth's algorithm
    int accumulator = 0;
    int previousBit = 0;

    // Perform Booth's algorithm
    for (int i = 0; i < bitLength; i++) {
        int multiplierLSB = multiplier & 1; // Get the LSB of multiplier

        if (multiplierLSB == 1 && previousBit == 0) {
            accumulator = accumulator + twoscomplement(multiplicand);
        } else if (multiplierLSB == 0 && previousBit == 1) {
            accumulator = accumulator+multiplicand;
        }

        // Arithmetic right shift accumulator and multiplier
        product = arithmeticRightShift(accumulator, multiplier);
        int accumulator1 = (int)(arithmeticRightShift(accumulator, multiplier) >> 32) & 0xFFFFFFFF;
        multiplier = (int)arithmeticRightShift(accumulator,multiplier) & 0xFFFFFFFF;
        accumulator = accumulator1;

        previousBit = multiplierLSB;
    }
    // cancatenating bits of accumulator and multiplier
     // Final result after Booth's algorithm
    return product;
}

int main() {
    // Run unit tests

    // Seed the random number generator
    srand(time(NULL));

    // Generate a random number between 0 and RAND_MAX
    int random_value = rand();
    int random_value2 = rand();
    // Transform the random value to get a positive or negative value
    // This will map the range [0, RAND_MAX] to [-RAND_MAX/2, RAND_MAX/2]
    int pos_neg_random_value = random_value - (RAND_MAX / 2);
    int pos_neg_random_value2 = random_value2 - (RAND_MAX / 2);

    printf("The Multiplier is: %d\n", pos_neg_random_value);
    printf("The Multiplicand is: %d\n", pos_neg_random_value2);
    for (int i = 0; i < 10; i++) {
        // Generate a random number between 0 and RAND_MAX
        int random_value = rand();
        int random_value2 = rand();
        // Transform the random value to get a positive or negative value
        // This will map the range [0, RAND_MAX] to [-RAND_MAX/2, RAND_MAX/2]
        int pos_neg_random_value = random_value - (RAND_MAX / 2);
        int pos_neg_random_value2 = random_value2 - (RAND_MAX / 2);

        printf("%d\n", pos_neg_random_value);
        printf("%d\n", pos_neg_random_value2);

        int multiplier = pos_neg_random_value;
        int multplicand = pos_neg_random_value2;
        long long result = boothMultiplier(multiplier, multplicand);
        printf("The result of %d and %d is: %lld\n", multiplier, multplicand, result);

    }
    // int multiplier = rand() % (2 * N + 1) - N;
    // int multplicand = rand() % (2 * N + 1) - N;
    // long long result = boothMultiplier(multiplier, multplicand);
    // printf("The result of %d and %d is: %lld", multiplier, multplicand, result);

    return 0;
}