#include <stdio.h>
#include <stdlib.h>

#define NUMBITS 32

#define GETLSB(a) (a & 1)

int SequentialSignedMultiplier(short numA, short numB) {
    int int_numB = (int) numB;
    int product;

    for (int n=0; n<(NUMBITS); n++) {
        if (n==0) { 
                product = 0;
                int_numB = (int) numB;
            }

        if (GETLSB(numA) == 1) {
            product += int_numB;
        }
        
        int_numB = int_numB << 1;
        numA = numA >> 1;
    }

    return product;
}

int test(int numTests) {
    short numA, numB;
    int test_product, ref_product;

    for (int i=0; i<numTests; i++) {
        numA = rand();
        numB = rand();

        ref_product = numA * numB;
        test_product = SequentialSignedMultiplier(numA, numB);
        
        if (test_product != ref_product) {
            printf("Test failed at %d * %d\n\n", numA, numB);
            return 1;
        }
    }
    printf("All %d tests passed successfully\n\n", numTests);
    return 0;
}

int main() {
    int test_product;
    int error = 0;

    //test_product = SequentialSignedMultiplier(-4,3);
    //printf("\n %d \n",test_product);

    error = test(1e6);

    return error;
}