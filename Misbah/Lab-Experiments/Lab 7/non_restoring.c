#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

// Function to print the bits of a decimal number given as input variable
void PrintBits(int* a, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d", a[i]);
    }
    printf("\n");
}

// Calculate the number of bits required to represent the number
int bits(int a) {
    int count = 0;
    while (a != 0) {
        a = a / 2;
        count++;
    }
    return count > 0 ? count : 1; // Ensure at least 1 bit is returned
}

// Convert decimal to binary
int* DecimalConversion(int a, int size) {
    int* binary = (int*)malloc(size * sizeof(int));
    for (int i = size - 1; i >= 0; i--) {
        binary[i] = a % 2;
        a = a / 2;
    }
    return binary;
}

// Compute 2's complement
int* TwosComplement(int* binary, int size) {
    int* twosComp = (int*)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        twosComp[i] = 1 - binary[i]; // Invert the bits
    }
    // Add 1 to the inverted binary number
    int carry = 1;
    for (int i = size - 1; i >= 0 && carry; i--) {
        int sum = twosComp[i] + carry;
        twosComp[i] = sum % 2;
        carry = sum / 2;
    }
    return twosComp;
}

// Left shift function
void LeftShift(int* a, int* q, int size) {
    for (int j = 0; j < size - 1; j++) {
        a[j] = a[j + 1];
    }
    a[size - 1] = q[0];
    for (int j = 0; j < size - 1; j++) {
        q[j] = q[j + 1];
    }
}

// Binary addition function
void Addition(int* a, int* b, int* result, int size) {
    int carry = 0;
    for (int i = size - 1; i >= 0; i--) {
        int sum = a[i] + b[i] + carry;
        result[i] = sum % 2;
        carry = sum / 2;
    }
}

// Non-Restoring division algorithm
void NonRestoringDivision(int* a, int* b, int* q, int size) {
    int* b_twos_complement = TwosComplement(b, size);
    
    // Initialize q to zero and a to dividend
    for (int i = 0; i < size; i++) {
        q[i] = 0;
    }

    for (int i = 0; i < size; i++) {
        // Left shift q and a
        LeftShift(a, q, size);
        
        // Subtract b from a
        Addition(a, b_twos_complement, a, size);
        
        // If a is non-negative (MSB is 0), set q to 1
        if (a[0] == 0) {
            q[size - 1] = 1;
        } else {
            // Restore a if it is negative
            q[size - 1] = 0;
            Addition(a, b, a, size); // Add b to a to restore it
        }
    }
    free(b_twos_complement);
}

int main(void) {
    srand(time(NULL));
    unsigned int var_dividend = 10;
    unsigned int var_divisor = 6;
    
    printf("Dividend: %u\n", var_dividend);
    printf("Divisor: %u\n", var_divisor);

    int size = bits(var_dividend);
    int* dividend = DecimalConversion(var_dividend, size);
    int* divisor = DecimalConversion(var_divisor, size);
    int* acc = (int*)malloc(size * sizeof(int));

    for (int i = 0; i < size; i++) {
        acc[i] = 0;
    }

    printf("Divisor in binary: ");
    PrintBits(divisor, size);

    printf("Dividend in binary: ");
    PrintBits(dividend, size);

    printf("\nImplementing Non-Restoring Algorithm\n");

    NonRestoringDivision(dividend, divisor, acc, size);

    printf("Quotient = ");
    PrintBits(dividend, size);
    printf(" which is equivalent to %d\n", var_dividend / var_divisor);

    printf("Remainder = ");
    PrintBits(acc, size);
    printf(" which is equivalent to %d\n", var_dividend % var_divisor);

    free(dividend);
    free(divisor);
    free(acc);

    return 0;
}
