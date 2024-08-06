#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>


void PrintBits(int* a, int size) {
    for (int i = 0; i < size; i++) {
        printf("%d", a[i]);
    }
    printf("\n");
}

int bits(int a) {
    int count = 0;
    while (a != 0) {
        a = a / 2;
        count++;
    }
    return count > 0 ? count : 1; 
}

int* DecimalConversion(int a, int size) {
    int* binary = (int*)malloc(size * sizeof(int));
    for (int i = size - 1; i >= 0; i--) {
        binary[i] = a % 2;
        a = a / 2;
    }
    return binary;
}

int* TwosComplement(int* binary, int size) {
    int* twosComp = (int*)malloc(size * sizeof(int));
    for (int i = 0; i < size; i++) {
        twosComp[i] = 1 - binary[i]; // Invert the bits
    }
    
    int carry = 1;
    for (int i = size - 1; i >= 0 && carry; i--) {
        int sum = twosComp[i] + carry;
        twosComp[i] = sum % 2;
        carry = sum / 2;
    }
    return twosComp;
}


void LeftShift(int* a, int* q, int size) {
    for (int j = 0; j < size - 1; j++) {
        a[j] = a[j + 1];
    }
    a[size - 1] = q[0];
    for (int j = 0; j < size - 1; j++) {
        q[j] = q[j + 1];
    }
}

void Addition(int* a, int* b, int* result, int size) {
    int carry = 0;
    for (int i = size - 1; i >= 0; i--) {
        int sum = a[i] + b[i] + carry;
        result[i] = sum % 2;
        carry = sum / 2;
    }
}

void RestoringDivision(int* a, int* b, int* q, int size) {
    int* temp = (int*)malloc(size * sizeof(int));

    for (int i = 0; i < size; i++) {
        q[i] = 0;
    }

    for (int i = 0; i < size; i++) {
        LeftShift(a, q, size);

        int* b_twos_complement = TwosComplement(b, size);
        Addition(a, b_twos_complement, a, size);
        free(b_twos_complement);
        if (a[0] == 1) {
            // Restore the previous value of a
            q[size - 1] = 0;
            for (int j = 0; j < size; j++) {
                a[j] = temp[j];
            }
        } else {
            q[size - 1] = 1;
        }
        
      for (int j = 0; j < size; j++) {
            temp[j] = a[j];
        }
    }
    free(temp);
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
    int* divisor2 = TwosComplement(divisor, size);
    int* acc = (int*)malloc(size * sizeof(int));

    for (int i = 0; i < size; i++) {
        acc[i] = 0;
    }

    printf("Divisor in binary: ");
    PrintBits(divisor, size);
    printf("Its 2's Complement: ");
    PrintBits(divisor2, size);

    printf("Dividend in binary: ");
    PrintBits(dividend, size);

    printf("\nImplementing Restoring Algorithm\n");

    RestoringDivision(acc, divisor2, dividend, size);

    printf("Quotient = ");
    PrintBits(dividend, size);
    printf(" which is equivalent to %d\n", var_dividend / var_divisor);

    printf("Remainder = ");
    PrintBits(acc, size);
    printf(" which is equivalent to %d\n", var_dividend % var_divisor);

    free(dividend);
    free(divisor);
    free(divisor2);
    free(acc);

    return 0;
}
