#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Function to compute the two's complement of a number
int twosCompliment(int a) {
    a = ~a + 1;
    return a;
}

// Function to perform an arithmetic right shift on the accumulator and multiplier
void arithmeticRightShift(int *accum, int *multiplier) {
    __int64_t temp;
    temp = (__int64_t)*accum << 32;           // Combine accumulator and multiplier
    temp = temp | (__uint32_t)*multiplier;    // into a 64-bit temporary variable
    temp = temp >> 1;                         // Perform the arithmetic right shift

    *accum = (temp >> 32) & 0xFFFFFFFF;         // Extract the upper 32 bits for the accumulator
    *multiplier = temp & 0xFFFFFFFF;          // Extract the lower 32 bits for the multiplier
}

// Function to perform multiplication using Booth's algorithm
__int64_t boothMultiplier(int multiplier, int multiplicand) {

    //Algorithm:
    // Set the Multiplicand and Multiplier binary bits as M and Q, respectively.
    // Initially, we set the AC and Qn + 1 registers value to 0.
    // SC represents the number of Multiplier bits (Q), and it is a sequence counter that is continuously decremented till equal to the number of bits (n) or reached to 0.
    // A Qn represents the last bit of the Q, and the Qn+1 shows the incremented bit of Qn by 1.
    // On each cycle of the booth algorithm, Qn and Qn + 1 bits will be checked on the following parameters as follows:
    // When two bits Qn and Qn + 1 are 00 or 11, we simply perform the arithmetic shift right operation (ashr) to the partial product AC. And the bits of Qn and Qn + 1 is incremented by 1 bit.
    //  If the bits of Qn and Qn + 1 is shows to 01, the multiplicand bits (M) will be added to the AC (Accumulator register). After that, we perform the right shift operation to the AC and QR bits by 1.
    //  If the bits of Qn and Qn + 1 is shows to 10, the multiplicand bits (M) will be subtracted from the AC (Accumulator register). After that, we perform the right shift operation to the AC and QR bits by 1.
    // The operation continuously works till we reached n - 1 bit in the booth algorithm.
    // Results of the Multiplication binary bits will be stored in the AC and QR register

    //Accumulator is the register which stores the partial product

    __int64_t product;
    int accumulator = 0;                      // Initialize the accumulator to 0
    int Q_1 = 0;                              // Initialize Q-1 to 0 (used in Booth's algorithm)
    int multiplierLSB;

    // Loop through 32 bits
    for (int count = 0; count < 32; count++) {
        multiplierLSB = multiplier & 1;       // Get the least significant bit of the multiplier

        // Apply Booth's algorithm rules
        if (multiplierLSB == 1 && Q_1 == 0) {

            accumulator = accumulator - multiplicand;   // Subtract multiplicand from accumulator
        }
        else if (multiplierLSB == 0 && Q_1 == 1) {

            accumulator = accumulator + multiplicand;   // Add multiplicand to accumulator
        }

        Q_1 = multiplierLSB;                   // Update Q-1

        arithmeticRightShift(&accumulator, &multiplier); // Perform arithmetic right shift
    }

    // Combine the accumulator and multiplier into the final product
    product = (__int64_t)accumulator << 32;
    product = product | (__uint32_t)multiplier;
    return product;
}

// Function to perform random testing of Booth's multiplication algorithm
void randomTesting(int numTests) {
    int multiplicand, multiplier;
    __int64_t boothResult, standardResult;

    srand(time(NULL));  // Seed the random number generator
    for (int i = 0; i < numTests; i++) {
        multiplicand = rand() % 100000 - 50000; // Generate random multiplicand between -50000 and 49999
        multiplier = rand() % 100000 - 50000;   // Generate random multiplier between -50000 and 49999

        boothResult = boothMultiplier(multiplier, multiplicand); // Compute result using Booth's algorithm
        standardResult = (__int64_t)multiplicand * (__int64_t)multiplier; // Compute result using standard multiplication

        // Print test results
        printf("Test %d:\n", i + 1);
        printf("Multiplicand: %d, Multiplier: %d\n", multiplicand, multiplier);
        printf("Booth Result: %ld, Standard Result: %ld\n", boothResult, standardResult);

        // Check if the results match
        if (boothResult == standardResult) {
            printf("Test passed.\n\n");
        } else {
            printf("Test failed.\n\n");
        }
    }
}

int main() {
    // Perform a test multiplication using Booth's algorithm
    int multiplicand = 66666;
    int multiplier = 66666;
    printf("Booth Multiplier Result: %ld\n", boothMultiplier(multiplier, multiplicand));

    // Start random tests
    printf("Starting random tests...\n");
    randomTesting(10); // Perform 10 random tests
    return 0;
}
