/******************************************************************************
*	Evaluation-01
*	File name: division.c
*	Author: Moazzam Ali
*	Date: 10/07/24
*   Description: Implement restoring_division which divide unsign int numbers
                 and check on random cases and also user can give input and take output 

 ******************************************************************************/

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

#define U_L 4294967295
#define L_L 0

//Implement the left Shift in function
void leftShiftFunc(uint32_t *a,uint32_t *b, int shift) {
    // Assuming int is 32 bits
    uint64_t combined = ((uint64_t)*a << 32) | (uint32_t)*b;

    // Perform the circular right shift
    shift = shift % 64; // Ensure shift is within the range of 0-63
    uint64_t leftShifted = combined << shift;


    // Split the combined number back into two integers
    *a = (uint32_t)((leftShifted >> 32) & 0xFFFFFFFF);
    *b = (uint32_t)(leftShifted & 0xFFFFFFFF);
}


// TODO: Implement the restoring_division function
// It should take dividend and divisor as inputs and return quotient and remainder
void restoring_division(uint32_t dividend, uint32_t divisor, uint32_t *quotient, uint32_t *remainder) {
    // TODO: Implement the non-restoring division algorithm

    //initialization
    uint32_t Q = dividend;
    uint32_t M = divisor;
    uint32_t A = 0;
    uint32_t A_msb ;

    //Number of bits in number or dividend
    char n = sizeof(dividend)*8;        

    // Remember to handle division by zero
    if(divisor == 0){
        //printf("Math error!\n");
        //printf("Any number can not divisible by Zero\n");
        
    }

    //Start Algo of restoring_division
    while (1) {

        leftShiftFunc(&A, &Q, 1);   // shifted left Q and A single unit and shift by 1

        A = A-M;
        A_msb = A >> 31;            // for MSB of A shift it right 31

        if(A_msb){
            Q = Q & 0xfffffffe;     // for making Q(0) = 0
            A = A+M;
        }
        else{
            Q = Q | 0x00000001;     // for making Q(0) = 1
        }

        n--;                    //decrement number of bit

        if(n==0){               //if bits are end break while loop
            break;
        }
    }

    //assignment of quotient and remainder
    *quotient = Q;    
    *remainder = A;

}

// TODO: Implement test cases
void run_test_case(uint32_t dividend, uint32_t divisor) {
    // TODO: Call restoring_division and verify the results
    uint32_t quotient;
    uint32_t remainder;
    restoring_division(dividend, divisor, &quotient, &remainder);

//    if(divisor == 0)
  //      return;
    
    uint32_t test_qu = dividend/divisor;
    uint32_t test_rm = dividend%divisor;

    //checks
    if((test_qu == quotient) && (test_rm == remainder)){
        
        //printf("Division of Dividend = %d and divisor = %d is Quotient = %d and Remainder = %d.\n", dividend, divisor, quotient, remainder);
        //printf("test pass\n");
        //test_pass++;
    }
    else{
        //printf("\nfailed pass\n");
        //printf(" Restore_Division of Dividend = %d and divisor = %d is Quotient = %d and Remainder = %d.\n", dividend, divisor, quotient, remainder);
        //printf(" Build-in_Division of Dividend = %d and divisor = %d is Quotient = %d and Remainder = %d.\n", dividend, divisor, test_qu, test_rm);
        
    }
    
}

int main() {
    // TODO: Implement multiple test cases
    // Example:
    srand(time(NULL));
    int test_run;
    int what_do = 0;
    int test_pass=0;
    uint32_t dd = 10 ;
    uint32_t dr = 3 ;

   
   run_test_case(dd, dr);
    //if(what_do == 3){
    //    printf("Enter:1 (for test on your own inputs) Enter:2 (for test of random numbers) ");
    //    scanf("%d", &what_do);
    //}
/*
    if (what_do == 1){
        printf("Enter Dividend:");
        scanf("%d", &dd);
        printf("Enter Divisor:");
        scanf("%d", &dr);
        run_test_case(dd, dr);
    }
    else if(what_do == 2){
        printf("Enter the number you want to test: ");
        scanf("%d", &test_run);
        while (test_run){
            dd = ((rand() % (U_L - L_L + 1)) + L_L);
            dr = ((rand() % (U_L - L_L + 1)) + L_L);
            run_test_case(dd, dr);
            test_run--;
            test_pass++;
        }
        printf("total test pass: %d\n", test_pass);
    }
    else{
        run_test_case(dd, dr);
    }
*/
    
    return 0;
}
