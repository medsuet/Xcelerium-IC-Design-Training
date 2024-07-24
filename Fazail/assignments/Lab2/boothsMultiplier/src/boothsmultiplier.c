#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

void printBinary(uint16_t number) {
    for (int i = 15; i >= 0; i--) {
        printf("%d", (number >> i) & 1);
    }
    printf("\n");
}

int16_t boothsMultiplier(int8_t multiplier, int8_t multiplicand){
    int8_t bit_1 = 0;
    int8_t accum = 0;
    int16_t temp = 0;
    int8_t mult_lsb;
    int8_t mult_p = multiplier;
    int8_t mult_c = multiplicand;

    int int_size = (sizeof(multiplier) * 8);

    for (int i=0; i<int_size; i++){
        mult_lsb = multiplier & 1;
        //mult_lsb = multiplier % 2;

        // printf("multi Lsb %d",mult_lsb);
        if ((mult_lsb == 0) && (bit_1 == 1)) {
            accum = accum + multiplicand;
        }
        else if ((mult_lsb == 1) && (bit_1 == 0)) {
            accum = accum - multiplicand;
        }
        else {
            accum = accum;
        }
        temp = ((int16_t)accum << 8) | (uint8_t)multiplier;
        //printBinary(temp);
        bit_1 = mult_lsb;
        temp = temp >> 1;
        accum = (temp >> 8) & 0xFF;
        multiplier = temp & 0xFF;
    }

    if ( mult_c == -128){
             temp = ~temp + 1;
         }
    else {
        return temp;
        }
}

void checker ( short int booth_ans, short int multiply, int8_t multiplier, int8_t multiplicand ) {
    if (booth_ans == multiply)
    {
        printf("\nYour Booth Multiplier is correct.\n");
    }
    else {
        printf("multiplier %d , multiplicand = %d, %d %d",multiplier, multiplicand, multiply, booth_ans);
        printf("\nYour Booth Multiplier is not correct.\n");
    }
}

void random_test() {
    //srand(time(NULL));
    int8_t multiplier;
    int8_t multiplicand;
    int16_t booth_ans;
    int16_t multiply;

    for (int i=0; i<10000; i++){
        multiplier = (rand() % 257) - 128;
        multiplicand = (rand() % 257)- 128;
        // multiplier = -1;
        // multiplicand = 0;
        booth_ans = boothsMultiplier(multiplier, multiplicand);
        multiply = multiplier * multiplicand;

        //if ( multiplier == -128 || multiplicand == -128){
        //    booth_ans = booth_ans * (-1);
        //}
        //printf("\n");

       // printf("Multiplier = %d, Multiplicand = %d, booth = %d, multiply = %d ", multiplier, multiplicand, booth_ans, multiply);
        
        checker( booth_ans, multiply, multiplier, multiplicand);
    }
}

int main()
{
    //srand(time(NULL));
    
    random_test();
    
    return 0;
}
