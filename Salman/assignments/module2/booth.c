#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include <stdint.h>

#define UPPER 127
#define LOWER -127

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

    while (1)
        {
            // case: 00 or 11
            if ( ((Qn == 0) && (Qn_1 == 0)) | ((Qn == 1) && (Qn_1 == 1)) )
                { // no change in AC
                    AC = AC;
                }
            else if ( (Qn == 0) & (Qn_1 == 1) ) // case: 01
                {
                    AC = AC + M;
                }
            else if ( (Qn == 1) & (Qn_1 == 0) ) // case: 10
                {
                    AC = AC - M;
                }

            rightShiftFunc(&AC,&Q,1);

            Qn_1 = Qn; // Qn+1 is incremented by 1
            Qn = Q & 1; // Qn is incremented by 1
            SC--; // decrement in SC

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


int main(){

//    int16_t product = boothMultiplier();

//    printf("The product is: %d\n", product);
    randomCheck();
}