#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <stdint.h>

//signed int64_t boothMultiplier();
/*
int bitCounter(int num){
    return ( ((int)log2(num))+1 ); // number of bits formula
}
*/

int64_t circularRightShift(int64_t number, int shift_value){ // sign is not maintained
    int64_t shifted_number =  number >> shift_value;
    return shifted_number;
}

void rightShiftFunc(signed int *a,unsigned int *b, signed int shift) {
    // Assuming int is 32 bits
    int64_t combined = ((int64_t)*a << 32) | (uint32_t)*b;

    // Perform the circular right shift
    shift = shift % 64; // Ensure shift is within the range of 0-63
    //int64_t rightShifted = (combined >> shift) | (combined << (64 - shift));
    int64_t rightShifted = combined >> shift;


    // Split the combined number back into two integers
    *a = (int)((rightShifted >> 32) & 0xFFFFFFFF);
    *b = (int)(rightShifted & 0xFFFFFFFF);
}

int64_t boothMultiplier(){
    // TODO: Create Booth Multiplier through Algorithm
    int32_t M,Q;
    printf("Enter the 1st number: ");
    scanf("%d",&M);
    printf("Enter the 2nd number: ");
    scanf("%d",&Q);

    if ((!M) || (!Q))
    {
        return 0;
    }

    int AC = 0;
    int Qn_1 = 0; // Qn+1
    int Qn = Q & 1;
//    int SC = bitCounter(Q);
    int bits = sizeof(int) * 8;
    int SC = bits;
    int64_t combined;

    while (1)
        {
            printf("Before changing values SC=%d; Q=%d; Qn =%d; Qn_1=%d; AC=%d\n",SC,Q,Qn,Qn_1,AC);
            // case: 00 or 11
            if ( ((Qn == 0) && (Qn_1 == 0)) | ((Qn == 1) && (Qn_1 == 1)) )
                { // no change in AC
                    printf("\nExecuting 1st and 2nd case\n");
                }
            else if ( (Qn == 0) & (Qn == 1) ) // case: 01
                {
                    printf("\nExecuting 3rd case\n");
                    AC = AC + M;
                }
            else // case: 10
                {
                    AC = AC - M;
                    printf("\nExecuting 4th case\n");
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
            printf("After changing values SC=%d; Q=%d; Qn =%d; Qn_1=%d; AC=%d\n",SC,Q,Qn,Qn_1,AC);

            if (SC == 0)
                {
                    break;
                }
        }

    return ( ( ((int64_t) AC) << bits) | (Q));
}

void main(){

    int64_t product = boothMultiplier();

    printf("The product is: %ld\n", product);
    return;
}