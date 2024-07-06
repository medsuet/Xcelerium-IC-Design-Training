#include<stdio.h>
#include<stdlib.h>

/*
    Mutliples 15 bit values using Booth's algorithem.
    (Intended values in range -16384:16383)

    Implemented wikipedia version of algorithem:
    https://en.wikipedia.org/wiki/Booth%27s_multiplication_algorithm
    
    Known bugs:
    1. Correct result for -16384<= r <=16383 but -32767<= m <=32767
    2. Correct result even for overflow cases if one of operands is 0

    Explaination:
    1. Booth multiplier assumes width of multiplier(m) and multiplicand(r) (operands) to be x and y bits,
    and width of A, S and P to be x+y+1 bits. In this implementation, all these numbers are 
    represented in integer (32 bits), but operands are assumed to be 15 bits wide. Therefore, only
    31 bits in A, S and P are used and one bit is free. However, this extra 1 bit allows multiplier to
    hold 1 extra bit, which the program uses accurately without being designed for it. This could have
    been resolved by applying a mask, but that was condsidered to be unnecessary.

*/

// Number of bits of multipler and multipliand
#define NUMBITS 15

// By turning this to 1, binary operations performed can be printed to console.
// Set to 0 to hide.
#define PRINTON 0

int printBin(int num) {
    // prints binary representation of num
    int bit;
    for (int i=32; i>0; i--) {
        bit = (num>>(i-1)) & 1;
        printf("%d",bit);
    }
    printf("\n");
}

int boothMult(int m/*multiplicand*/, int r/*multiplier*/) {
    int A=0, S=0, P=0;
    A =   m  << (NUMBITS+1);
    S = (-m) << (NUMBITS+1);
    P = (r& 0x00007FFF) << 1;

    if (PRINTON) { printf("A:");printBin(A); printf("S:");printBin(S);printf("P:");printBin(P); printf("\n"); }

    int i=0;
    do {
        if ((P & 3) == 1) {     // 2 LSBs are 01
                P = P+A;
                if (PRINTON) { printf("  P+A  \n"); }
        }
        else if ((P & 3) == 2) {    // 2 LSBs are 10
                P = P+S;
                if (PRINTON) { printf("  P+S  \n"); }
        }
        P = P >> 1;
        if (PRINTON) { printf("A:");printBin(A); printf("S:");printBin(S);printf("P:");printBin(P); printf("\n"); }
        i++;
    } while (i<NUMBITS);

    P = P>>1;
    if (PRINTON) { printf("A:");printBin(A); printf("S:");printBin(S);printf("P:");printBin(P); printf("\n"); }
    return P; 
}

int testBoothMultiplier(int m, int r){
    // tests *testfunction for correct multiplication with operands a, b
    
    int (*testfunction)(int,int) = boothMult;

    if (testfunction(m,r) != (m*r)) {
        printf("Failed at %d * %d\n", m, r);
        return 1;
    }
    else {
        printf("Passed at %d * %d\n", m, r);
        return 0;
    }
    
}
void testRangeBoothMultiplier(int min, int max){
    // tests *testfunction for correct multiplication for all integers in range min:max
    
    int (*testfunction)(int,int) = boothMult;

    int failure = 0;        // flag to store if test fails on any operands
    int m,r;
    for (m=min; m<=max; m++) {
        for (r=min; r<=max; r++) {
            if (testfunction(m,r) != (m*r)) {
                printf("Failed at %d * %d\n", m, r);
                failure = 1;
                return;
            }
    
        }
    }
    if (! failure) {
        printf("Passed for all integers in range: %d to %d\n", min, max);
        return;
    }
    
}

int main(void) {
    system("clear");

    /*
    Testing scheme:     (all combinations of these)
    overflow+ve    edge+ve(fail)    edge+ve(pass)     +ve     1   0
    overflow-ve    edge-ve(fail)    edge-ve(pass)     -ve    -1
    */
    int testValues[12] = {40000,16384,16383,27,1,0,-1,-999,-16384,-16385,-52000};

    for (int i=0; i<12; i++) {
        for (int j=0; j<12; j++) {
            testBoothMultiplier(testValues[i], testValues[j]);
        }
        printf("\n");
    }
    
    /* 
        Run this to test for every integer in provided range.
        (Remember to set PRINTON to 0 to stop flooding console)

        *the author has run this and verified for all integers 
        in the range -16384, 16383
     */
    //testRangeBoothMultiplier(-16384, 16383);

    printf("\n");
    return 0;
}
