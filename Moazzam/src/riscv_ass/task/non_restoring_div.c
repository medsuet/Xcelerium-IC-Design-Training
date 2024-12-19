#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define RANGE 1073741823

// Function to perform the arithmetic right-left shift
void right_left_func(unsigned int *A, unsigned int *Q) {
    unsigned long long combined = ((unsigned long long)(*A) << 32) | (*Q & 0xffffffff);
    combined <<= 1;
    *A = (combined >> 32) & 0xffffffff;
    *Q = combined & 0xffffffff;
}

// Function to perform non-restoring division
void non_restoring_division(unsigned int Dividend, unsigned int Divisior, unsigned int *Quotient, unsigned int *Remainder) {
    unsigned int M = Divisior & 0xffffffff;
    unsigned int Q = Dividend & 0xffffffff;
    unsigned int A = 0 & 0xffffffff;
    int n = 32;

    // Check for division by zero
    if (M == 0) {
        printf("Maths error\n");
        *Quotient = 0;
        *Remainder = 0;
        return;
    }

    while (n > 0) {
        if ((A & 0x80000000) == 0) {
            right_left_func(&A, &Q);
            A = (A - M) & 0xffffffff;
        } else {
            right_left_func(&A, &Q);
            A = (A + M) & 0xffffffff;
        }

        if ((A & 0x80000000) == 0) {
            Q = Q | 0x00000001;
        } else {
            Q = Q & 0xfffffffe;
        }

        n--;
    }

    if ((A & 0x80000000) != 0) {
        A = (A + M) & 0xffffffff;
    }

    *Quotient = Q;
    *Remainder = A;
}



int main() {
    unsigned int Dividend, Divisior;
    unsigned int Quotient, Remainder;


    // Perform non-restoring division
    non_restoring_division(Dividend, Divisior, &Quotient, &Remainder);


    return 0;
}
