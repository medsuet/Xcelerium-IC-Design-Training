#include <stdio.h>
#include <assert.h>

// Function Prototypes
int BoothMultiplier(int multiplicand, int multiplier);
void intToBinary(int n, int res[], int sc);
void printBinary(int sc, int bin[]);
void ShiftRight(int sc, int bin[]);
void addBinary(int A[], int B[], int res[], int size);
void TwosComplement(int A[], int res[], int size);
int BinToInt(int bin[], int size);


// Implement the Booth Multiplier Algorithm
int BoothMultiplier(int multiplicand, int multiplier){
    // Width of Registers
    int sc = 32;
    // Registers
    int A[sc];
    int M[sc];
    int Q[sc];
    // Varaibles
    int Q_1 = 0;
    int msb;
    // Initialize A Register to 0
    for (int i=0; i<sc; i++){
        A[i] = 0;
    }
    // Covert the Integer Format to Binary Format
    intToBinary(multiplicand, M, sc);
    intToBinary(multiplier, Q, sc);
    // Print the Initial values of Registers
    printf("Initial values: \n");
    printf("Multiplicand: ");
    printBinary(sc, M);
    printf("Multiplier:   ");
    printBinary(sc, Q);
    printf("A:            ");
    printBinary(sc, A);
    // Implementing the Booth Algorithm to multiply the two signed numbes
    for (int i=0; i<sc; i++){

        if ((Q[0] == 0 && Q_1 == 0) || (Q[0] == 1 && Q_1 == 1)){
            // Arithmetic Shift Right Logic
            msb = A[sc-1];
            int qmsb = A[0];
            Q_1 = Q[0];
            ShiftRight(sc, A);
            A[sc-1] = msb;
            ShiftRight(sc, Q);
            Q[sc-1] = qmsb;
        } else if (Q[0] == 0 && Q_1 == 1){
            // A = A + M
            addBinary(A, M, A, sc);
            // Arithmetic Shift Right Logic
            msb = A[sc-1];
            int qmsb = A[0];
            Q_1 = Q[0];
            ShiftRight(sc, A);
            A[sc-1] = msb;
            ShiftRight(sc, Q);
            Q[sc-1] = qmsb;
        } else if (Q[0] == 1 && Q_1 == 0){
            // A = A - M
            int comM[sc];
            TwosComplement(M, comM, sc);
            addBinary(A, comM, A, sc);
            // Arithmetic Shift Right Logic
            msb = A[sc-1];
            int qmsb = A[0];
            Q_1 = Q[0];
            ShiftRight(sc, A);
            A[sc-1] = msb;
            ShiftRight(sc, Q);
            Q[sc-1] = qmsb;
        }
    }
    // Priting the Final values of Registers
    printf("\nFinal values: \n");
    printf("Multiplicand: ");
    printBinary(sc, M);
    printf("Mutiplier:    ");
    intToBinary(multiplier, M, sc);
    printBinary(sc, M); 
    printf("M Reg:        ");
    printBinary(sc, Q);
    printf("A:            ");
    printBinary(sc, A);
    // Priting the Product which results after the Booth Mutliplication 
    printf("\nProdBin:     ");
    printBinary(sc, Q);
    int prod = BinToInt(Q, sc);
    return prod;

}

void intToBinary(int n, int res[], int sc){
    for (int i=0; i<sc; i++){
        res[i] =  (n>>i) & 1;
    }
}

void printBinary(int sc, int bin[]){
    for (int i=sc-1; i>=0; i--){
        printf("%d", bin[i]);
    }
    printf("\n");
}

void ShiftRight(int sc, int bin[]){
    for (int i=0; i<sc-1; i++){
        bin [i] = bin[i+1];
    }
    bin[sc-1] = 0;
}

void addBinary(int A[], int B[], int res[], int size){
    int carry = 0;
    int sum = 0;
    for (int i=0; i<size; i++){
        sum = A[i] + B[i] + carry;
        carry = sum / 2;
        res[i] = sum % 2;
    }
}


void TwosComplement(int A[], int res[], int size){
    int B[size];
    for (int i=0; i<size; i++){
        res[i] = !A[i];
        B[i] = 0;
    }
    B[0] = 1;
    addBinary(res, B, res, size);    
}

int BinToInt(int bin[], int size){
    int n = 0;
    for (int i=0; i<size; i++){
        n |= (bin[i]<<i);
    }
    return n;
}

void testBoothMultiplication() {
    // Test cases for Booth's multiplication algorithm

    // Positive x Positive
    assert(BoothMultiplier(3, 4) == 12);
    // Negative x Positive
    assert(BoothMultiplier(-3, 4) == -12);
    // Positive x Negative
    assert(BoothMultiplier(3, -4) == -12);
    // Negative x Negative
    assert(BoothMultiplier(-3, -4) == 12);
    // Multiplication by zero
    assert(BoothMultiplier(0, 4) == 0);
    assert(BoothMultiplier(3, 0) == 0);
    // Multiplication by one
    assert(BoothMultiplier(1, 4) == 4);
    assert(BoothMultiplier(3, 1) == 3);
    // Edge cases
    assert(BoothMultiplier(__INT32_MAX__, 1) == __INT32_MAX__);
    assert(BoothMultiplier(-__INT32_MAX__, 1) == -__INT32_MAX__);
    assert(BoothMultiplier(__INT32_MAX__, -1) == -__INT32_MAX__);
    assert(BoothMultiplier(-__INT32_MAX__, -1) == __INT32_MAX__);

    printf("All test cases passed!\n");
}

int main(void){
    testBoothMultiplication();
}
