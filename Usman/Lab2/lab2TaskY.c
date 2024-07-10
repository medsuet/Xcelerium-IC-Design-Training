#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Function to perform arithmetic right shift
void arithmeticRightShift(int *mcand, int *acc, int *q, int *q_1) {
    *q_1 = *q & 1;
    *q = (*q >> 1) | ((*acc & 1) << 31);
    *acc = *acc >> 1;
}

// Function to add two integers
void add(int *acc, int mcand) {
    *acc += mcand;
}

// Booth's Multiplication Algorithm
int boothMultiplication(int multiplicand, int multiplier) {
    int mcand = multiplicand;
    int acc = 0;
    int q = multiplier;
    int q_1 = 0;
    int count = 32;

    while (count > 0) {
        if ((q & 1) == 1 && q_1 == 0) {
            add(&acc, -mcand);
        } else if ((q & 1) == 0 && q_1 == 1) {
            add(&acc, mcand);
        }
        arithmeticRightShift(&mcand, &acc, &q, &q_1);
        count--;
    }

    return acc;
}


int main() {
    int num1 = 7;
    int num2 = 3;
    printf("7 x 3 = %d\n", boothMultiplication(num1, num2));

    return 0;
}

