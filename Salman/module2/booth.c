#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <stdint.h>

#define UPPER 127
#define LOWER -127

//signed int64_t boothMultiplier();
/*
int bitCounter(int num){
    return ( ((int)log2(num))+1 ); // number of bits formula
}
*/

// Function to print the binary representation of an integer
void printBits(size_t const size, void const * const ptr) {
    unsigned char *b = (unsigned char*) ptr;
    unsigned char byte;
    int i, j;

    for (i = size-1; i >= 0; i--) {
        for (j = 7; j >= 0; j--) {
            byte = (b[i] >> j) & 1;
            printf("%u", byte);
        }
    }
}


// Function to print the bits of AC, Q, Qn, Qn_1, and SC
void check(int8_t AC, int8_t M, int8_t Q, int Qn, int Qn_1, int SC) {
    printf("AC: ");
    printBits(sizeof(AC), &AC);
    printf(" (dec: %d); ", AC);

    int8_t M_neg = -M;

    printf("M: ");
    printBits(sizeof(M), &M);
    printf(" (dec: %d); ", M);

    printf("-M: ");
    printBits(sizeof(M_neg), &M_neg);
    printf(" (dec: %hhd); \n", M_neg);


    printf("Q: ");
    printBits(sizeof(Q), &Q);
    printf(" (dec: %d); ", Q);

    printf("Qn: %d; ", Qn);

    printf("Qn_1: %d; ", Qn_1);

    printf("SC: ");
//    printBits(sizeof(SC), &SC);
    printf(" (dec: %d)\n", SC);
}


void rightShiftFunc(int8_t *a,int8_t *b, signed int shift) {
    // Assuming int is 32 bits
    int16_t combined = ((int8_t)*a << 8) | (uint8_t)*b;

    // Perform the circular right shift
    // Ensure shift is within the range of 0-63
    //int64_t rightShifted = (combined >> shift) | (combined << (64 - shift));
    int16_t rightShifted = combined >> shift;


    // Split the combined number back into two integers
    *a = (int8_t)((rightShifted >> 8) & 0x00FF);
    *b = (int8_t)(rightShifted & 0x00FF);
}

int16_t boothMultiplier(int8_t M, int8_t Q){
    // TODO: Create Booth Multiplier through Algorithm
/*    int8_t M,Q;
    printf("Enter the 1st number: ");
    scanf("%hhd",&M);
    printf("Enter the 2nd number: ");
    scanf("%hhd",&Q);

    printf("\nValue of M = %hhd and -M = %hhd and (~M+1) = %hhd\n",M,-M,(~M + 1));
    printf("\nValue of Q = %hhd and -Q = %hhd\n",Q,-Q);
    printf("\n-1 + 1 = %hhd",-1+1);
*/
    if ((!M) || (!Q))
    {
        return 0;
    }

    if ((M > 127) | (Q > 127) | (M < -127) | (Q < -127))
    {
        printf("Invalid input! Enter between -127 to 127");
        exit(0);
    }

    int8_t AC = 0;
    int Qn_1 = 0; // Qn+1
    int Qn = Q & 1;
//    int SC = bitCounter(Q);
    int bits = sizeof(int8_t) * 8;
    int8_t SC = bits;
    int16_t combined;

    while (1)
        {
//            printf("\nBefore changing values\n"); //SC=%d; Q=%hhd; Qn =%d; Qn_1=%d; AC=%hhd\n",SC,Q,Qn,Qn_1,AC);
//            check(AC,M,Q,Qn,Qn_1,SC);
            // case: 00 or 11
            if ( ((Qn == 0) && (Qn_1 == 0)) | ((Qn == 1) && (Qn_1 == 1)) )
                { // no change in AC
//                    printf("Executing 1st and 2nd case\n");
                    AC = AC;
//                    printf("AC = \n");
//                    printBits(sizeof(AC),&AC);
                }
            else if ( (Qn == 0) & (Qn_1 == 1) ) // case: 01
                {
//                    printf("Executing 3rd case: AC = AC + M\n");
                    AC = AC + M;
//                    printf("AC + M = \n");
//                    printBits(sizeof(AC),&AC);
                }
            else if ( (Qn == 1) & (Qn_1 == 0) ) // case: 10
                {
                    AC = AC - M;
//                    printf("Executing 4th case: AC = AC - M\n");
//                    printf("AC - M = \n");
//                    printBits(sizeof(AC),&AC);
                }

//            combined = ( ( ((int64_t)AC) << bits) | (uint32_t) Q); // 32 AC + 32 Q bits
//            printf("Before changing, combined = %ld\n",combined);

//            combined = circularRightShift(combined,1);
//            printf("After changing, combined = %ld\n",combined);

//            AC = (int32_t) ((combined >> bits) & 0xffffffff); // right shift by 32

//            Q =  (int32_t) (combined & 0xffffffff); // 0 to 31 bits


            rightShiftFunc(&AC,&Q,1);

            Qn_1 = Qn; // Qn+1 is incremented by 1
            Qn = Q & 1; // Qn is incremented by 1
            SC--; // decrement in SC
//            printf("\nAfter changing values\n"); //SC=%d; Q=%hhd; Qn =%d; Qn_1=%d; AC=%hhd\n",SC,Q,Qn,Qn_1,AC);
//            check(AC,M,Q,Qn,Qn_1,SC);

            if (SC == 0)
                {
                    break;
                }
        }

    return (((int16_t) AC) << bits) + (Q & 0x00FF);
}

//Function to randomly check output through random inputs
void randomCheck(){
    int8_t M,Q;
    int count,i;
    int fail_counter = 0;
    int16_t product;

    printf("Enter the number of times you want to test randomly: ");
    scanf("%d",&count);

    for (i=0; i<count; i++)
    {
        M = ( rand() % (UPPER-LOWER+1)) + LOWER;
        Q = ( rand() % (UPPER-LOWER+1)) + LOWER;
        product = boothMultiplier(M,Q);

        if (product == (M*Q))
        {
            printf("Test #%d Passed\n",i+1);
        }
        else
        {
            printf("Test #%d Failed; %hhd, %hhd\n",i+1,M,Q);
            fail_counter++;
        }
    }

    if (fail_counter>0)
    {
        printf("Total Tests Failed: %d\n",fail_counter);
    }
    else
    {
        printf("All tests passed!\n");
    }
}


void main(){

//    int16_t product = boothMultiplier();

//    printf("The product is: %d\n", product);
    randomCheck();
    return;
}