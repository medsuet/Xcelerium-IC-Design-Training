#include <stdio.h>
#include <limits.h>

// Function prototypes
int boothMultiplier(int x, int y);
void add(int *acc, int value);
void arithmeticRightShift(int *acc, int *mq, int *q1);
void testBoothMultiplier();

// Booth's multiplication algorithm
int boothMultiplier(int x, int y) {
    int acc = 0; // Accumulator
    int q = y;   // Multiplier
    int q1 = 0;  // q-1 initialized to 0
    int m = x;   // Multiplicand
    int count = sizeof(int) * CHAR_BIT; // Number of bits in an int

    while (count > 0) {
        // Check the last two bits of q and q1
        if ((q & 1) == 1 && q1 == 0) {
            add(&acc, -m);
        } else if ((q & 1) == 0 && q1 == 1) {
            add(&acc, m);
        }
        // Arithmetic right shift
        arithmeticRightShift(&acc, &q, &q1);
        count--;
    }

    return acc; // The final value of acc is the product
}

// Function to add value to the accumulator
void add(int *acc, int value) {
    *acc += value;
}

// Function to perform arithmetic right shift
void arithmeticRightShift(int *acc, int *mq, int *q1) {
    int msb_acc = *acc & (1 << (sizeof(int) * CHAR_BIT - 1)); // Get the most significant bit of acc

    // Perform the shift
    *q1 = *mq & 1; // Save the least significant bit of mq
    *mq = (*mq >> 1) | (*acc << (sizeof(int) * CHAR_BIT - 1)); // Shift mq and take MSB of acc
    *acc = (*acc >> 1) | msb_acc; // Arithmetic right shift acc
}

// Function to test Booth's multiplier
void testBoothMultiplier() {
    // Test cases
    int testCases[][2] = {
        {0, 0},
        {1, 0},
        {0, 1},
        {1, 1},
        {2, 3},
        {-2, 3},
        {2, -3},
        {-2, -3},
        {INT_MAX, 1},
        {INT_MIN, 1},
        {INT_MAX, INT_MAX},
        {INT_MIN, INT_MIN},
        {INT_MAX, -1},
        {-1, INT_MAX},
        {-1, -1},
    };

    int numCases = sizeof(testCases) / sizeof(testCases[0]);
    for (int i = 0; i < numCases; i++) {
        int x = testCases[i][0];
        int y = testCases[i][1];
        int result = boothMultiplier(x, y);
        printf("boothMultiplier(%d, %d) = %d\n", x, y, result);
    }
}

int main() {
    testBoothMultiplier();
    return 0;
}
