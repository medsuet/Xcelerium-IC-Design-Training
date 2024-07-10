#include <stdio.h>
#include <stdlib.h>

// Function to perform addition in the accumulator
void add(int ac[], int x[], int qrn) {
    int i, c = 0;
    for (i = 0; i < qrn; i++) {
        ac[i] = ac[i] + x[i] + c;
        if (ac[i] > 1) {
            ac[i] = ac[i] % 2;
            c = 1;
        } else {
            c = 0;
        }
    }
}

// Function to find the number's complement
void complement(int a[], int n) {
    int i;
    int x[8] = {0};
    x[0] = 1;
    for (i = 0; i < n; i++) {
        a[i] = (a[i] + 1) % 2;
    }
    add(a, x, n);
}

// Function to perform right shift
void rightShift(int ac[], int qr[], int *qn, int qrn) {
    int temp, i;
    temp = ac[0];
    *qn = qr[0];
    printf("\t\trightShift\t");
    for (i = 0; i < qrn - 1; i++) {
        ac[i] = ac[i + 1];
        qr[i] = qr[i + 1];
    }
    qr[qrn - 1] = temp;
}

// Function to display operations
void display(int ac[], int qr[], int qrn) {
    int i;
    for (i = qrn - 1; i >= 0; i--)
        printf("%d", ac[i]);
    printf("\t");
    for (i = qrn - 1; i >= 0; i--)
        printf("%d", qr[i]);
}

// Function to implement Booth's algorithm
void boothAlgorithm(int br[], int qr[], int mt[], int qrn, int sc) {
    int qn = 0, ac[10] = {0};
    int temp = 0;
    printf("qn\tq[n+1]\t\tBR\t\tAC\tQR\t\tsc\n");
    printf("\t\t\tinitial\t\t");
    display(ac, qr, qrn);
    printf("\t\t%d\n", sc);
    
    while (sc != 0) {
        printf("%d\t%d", qr[0], qn);
        if ((qn + qr[0]) == 1) {
            if (temp == 0) {
                add(ac, mt, qrn);
                printf("\t\tA = A - BR\t");
                for (int i = qrn - 1; i >= 0; i--)
                    printf("%d", ac[i]);
                temp = 1;
            } else if (temp == 1) {
                add(ac, br, qrn);
                printf("\t\tA = A + BR\t");
                for (int i = qrn - 1; i >= 0; i--)
                    printf("%d", ac[i]);
                temp = 0;
            }
            printf("\n\t");
            rightShift(ac, qr, &qn, qrn);
        } else if (qn - qr[0] == 0)
            rightShift(ac, qr, &qn, qrn);
        display(ac, qr, qrn);
        printf("\t");
        sc--;
        printf("\t%d\n", sc);
    }
}

// Utility function to reverse an array
void reverse(int arr[], int n) {
    int temp, start = 0, end = n - 1;
    while (start < end) {
        temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

// Utility function to convert a signed integer to its binary representation
void intToBinary(int n, int bin[], int size) {
    for (int i = 0; i < size; i++) {
        bin[i] = n & 1;
        n >>= 1;
    }
    if (n < 0) {
        complement(bin, size);
    }
}

// Function to print a binary array
void printBinary(int bin[], int size) {
    for (int i = size - 1; i >= 0; i--) {
        printf("%d", bin[i]);
    }
    printf("\n");
}

// Function to perform Booth's multiplication and print the result
void performBoothMultiplication(int multiplicand, int multiplier, int size) {
    int br[10], qr[10], mt[10], bin[10];
    int sc = size;

    // Convert multiplicand and multiplier to binary
    intToBinary(multiplicand, br, size);
    intToBinary(multiplier, qr, size);

    // Copy multiplicand to mt and reverse arrays for proper bit order
    for (int i = 0; i < size; i++) {
        mt[i] = br[i];
    }
    reverse(br, size);
    reverse(qr, size);

    // Get the two's complement of the multiplicand
    complement(mt, size);

    printf("Multiplicand: %d, Multiplier: %d\n", multiplicand, multiplier);
    boothAlgorithm(br, qr, mt, size, sc);

    printf("Expected Result: ");
    intToBinary(multiplicand*multiplier, bin, size);
    printBinary(bin, size);
    printf("\nResult: ");
    printBinary(qr, size);
    printf("\n");
}

// Main function with test cases
int main(int argc, char **argv) {
    int size = 8; // Size of the binary numbers (8 bits)

    // Test cases
    int test_cases[][2] = {
        {5, 3},        // Positive * Positive
        {-5, 3},       // Negative * Positive
        {5, -3},       // Positive * Negative
        {-5, -3},      // Negative * Negative
        {0, 3},        // Zero * Positive
        {5, 0},        // Positive * Zero
        {1, 123},      // Multiplication by 1
        {123, 1},      // Multiplication by 1
        {127, 127},    // Edge case for potential overflow in 8-bit representation
    };

    int num_tests = sizeof(test_cases) / sizeof(test_cases[0]);

    for (int i = 0; i < num_tests; i++) {
        int multiplicand = test_cases[i][0];
        int multiplier = test_cases[i][1];
        performBoothMultiplication(multiplicand, multiplier, size);
    }

    return 0;
}
