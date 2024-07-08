#include <stdio.h>

// Function to take 2's complement of a number
int compliment(int a) {
    a = (~a) + 1; // Bitwise NOT operation followed by addition of 1
    return a;
}

// Function to perform arithmetic right shift on combined multiplier and accumulator
__int64_t arithmeticRightshift(int multiplier, int accumulator) {
    __int64_t value;
    value = (__int64_t)accumulator << 32; // Shift accumulator left by 32 bits
    value = value | (__uint32_t)multiplier; // Combine multiplier and shifted accumulator
    value = value >> 1; // Perform arithmetic right shift by 1
    return value;
}

// Function to perform Booth's multiplication algorithm
__int64_t boothMultiplier(int multiplier, int multiplicant) {
    int n = 8 * sizeof(int); // Determine the number of bits in an integer
    int Q_1 = 0; // Initialize Q-1 (previous LSB of multiplier)
    int multiplier_lsb; // Least significant bit of multiplier
    int accumalator1; // Temporary variable for accumulator
    int accumulator = 0; // Initialize accumulator to 0
    
    for (int i = 0; i < n - 1; i++) {
        // Print current state for debugging
        printf("%d, %d, %d, %d, %d, %d\n", accumulator, accumalator1, multiplier, Q_1, multiplier_lsb, multiplicant);
        
        multiplier_lsb = multiplier & 1; // Get LSB of multiplier
  
        // Apply Booth's algorithm rules
        if ((multiplier_lsb == 0) && (Q_1 == 1)) {
            accumulator = accumulator + multiplicant; // Add multiplicant to accumulator
        } else if ((multiplier_lsb == 1) && (Q_1 == 0)) {
            accumulator = accumulator + compliment(multiplicant); // Add 2's complement of multiplicant to accumulator
        }

        Q_1 = multiplier_lsb; // Update Q-1 with current LSB of multiplier
        accumalator1 = (int)(arithmeticRightshift(multiplier, accumulator) >> 32) & 0xFFFFFFFF; // Perform arithmetic right shift and get updated accumulator
        multiplier = (int)arithmeticRightshift(multiplier, accumulator) & 0xFFFFFFFF; // Update multiplier with shifted value
        accumulator = accumalator1; // Set accumulator to updated value
    }

    return arithmeticRightshift(multiplier, accumulator); // Final arithmetic right shift
}

int main() {
    // Perform Booth's multiplication on the given multiplier and multiplicant
    printf("%ld\n", boothMultiplier(-58000, 0));
}
