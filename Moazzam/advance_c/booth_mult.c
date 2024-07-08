#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

#define RANGE 32767


void rightShiftFunc(signed int *a,unsigned int *b, signed int shift) {
    // Assuming int is 32 bits
    int64_t combined = ((int64_t)*a << 32) | (uint32_t)*b;

    // Perform the circular right shift
    shift = shift % 64; // Ensure shift is within the range of 0-63
    int64_t rightShifted = (combined >> shift) | (combined << (64 - shift));

    // Split the combined number back into two integers
    *a = (signed int)(rightShifted >> 32);
    *b = (unsigned int)(rightShifted & 0xFFFFFFFF);
}

uint64_t booth_mult(int M, int Q){
    //M = Multiplicant      Q = Multiplier
    char n = sizeof(M) * 8; //to find number to bits of input number

    char Q_n;
    Q_n = Q & 1;            //for LSb for Q
    char Q_n1 = 0;
    char SC = n;            //work like counter 
    int AC = 0;
    

    if ((Q == 0 || M == 0) ) //special case multiply be ZERO
    {
        return 0;
    }

    while (1)
    {
        
        if ((Q_n == 0 & Q_n1 == 0) | (Q_n == 1 & Q_n1 == 1)) 
        {
            rightShiftFunc(&AC, &Q, 1);
            SC --;
        }
        else if ((Q_n == 1 & Q_n1 == 0)) 
        {   
            AC = AC-M;
            //printf("AC = AC-M; = %d\n", AC);
            rightShiftFunc(&AC, &Q, 1);
            SC --;
        }
        else if ((Q_n == 0 & Q_n1 == 1)) 
        {   
            AC = AC+M;
            //printf("AC = AC+M; = %d\n", AC);
            rightShiftFunc(&AC, &Q, 1);
            SC --;
        }
        
        if (SC == 0)
        {
            break;
        }
        else
        {
            Q_n1 = Q_n;
            Q_n = Q & 1;
        }
        
        
    }

    //printf("AC = %d, Q = %d\n",AC,Q);
    // Assuming int is 32 bits((int64_t) AC << 32) |
    //int64_t product =  ((int64_t) AC << 32) |(int32_t) Q;
    int64_t product =  (int32_t) Q;

    return product;
}

void CheckFunc(int test_n){
    int pass = 0;
    int copy_n= test_n;
    while (test_n)
    {
        // Generate a random number between -range and +range
        int a = (rand() % (2 * RANGE + 1)) - RANGE;
        int b = (rand() % (2 * RANGE + 1)) - RANGE;
        int64_t booth_result = booth_mult(a, b);
        int64_t simple_result = a*b;
        if (booth_result == simple_result) {pass++;}
        else
        {
            printf("Booth Multiplication failed!\n");
            printf("Booth Multiplier: a %d * b %d =  %ld \n", a, b, booth_result);
            printf("Simple Multiplier: a %d * b %d =  %ld \n", a, b, simple_result);
            break;
        }
        test_n--;
    }
    printf("Total test: %d, Passed Test: %d\n",copy_n, pass);
}


int main() {
    
    srand(time(NULL));
    int a, b;
    int test_n = 0;

    //a = (rand() % (RANGE - LOW_NUM)) + LOW_NUM;
    //b = (rand() % (RANGE - LOW_NUM)) + LOW_NUM;
    // Read two integers from the user
    printf("Enter first integer: ");
    scanf("%d", &a);
    printf("Enter second integer: ");
    scanf("%d", &b);
    printf("Enter number of test for Booth_Multi.: ");
    scanf("%d", &test_n);

   
    printf("the Product of %d and %d is equal to %ld\n",a,b,booth_mult(a,b));
    CheckFunc(test_n);


    return 0;
}
