//Name : M.Ehsan
//File_description : implementing restoring division algorithm
// #include <stdio.h>
// #include <stdint.h>
// #include <stdlib.h>
// #include <time.h>

void restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder) {
    //handle division by zero
    if (divisor == 0) {
        //printf("Not_divisible_by_zero\n");
        return;
    }
    unsigned int A = 0;      
    unsigned int Q = dividend;  
    unsigned int M = divisor;
    int N = 8 * sizeof(unsigned int);
    unsigned long long  temp = (unsigned long long )A ;
    unsigned long long  QA_combined = temp << 32 | Q; 
    unsigned int msb_A;

    for (int i = 0; i < N; i++) {
        QA_combined = (unsigned long long )A << 32 ;     //combine shifting accumulator and dividend as single unit
        QA_combined = QA_combined| Q;         
        QA_combined = QA_combined << 1;       //left shifting 1 bit 
        A = (QA_combined >> 32) & 0xffffffff; //makeing accumulator after shift
        Q = QA_combined & 0xffffffff;         //makeing dividend after shift
        A = A + ((~M) + 1);
        msb_A = (A >> 31) & 1;                //checking msb of accumulator
        if (msb_A == 1) {                     //if masb is 1 perform A = A + M and change lsb of Q with 0 
            Q = Q & 0xFFFFFFFE;               
            A = A + M;                        
        } else if (msb_A == 0) {              //if msb is 0 changing lsb of Q with 1
            Q = Q | 0x00000001;
        }
    }

    *quotient = Q;
    *remainder = A;

}

// TODO: Implement test cases
void run_test_case(unsigned int dividend, unsigned int divisor) {
    unsigned int quotient;
    unsigned int remainder;
    //testing using random numbers 
    unsigned int temp_quotient, temp_remainder;
    temp_quotient = dividend / divisor;
    temp_remainder = dividend % divisor;

    restoring_division(dividend, divisor, &quotient, &remainder);
    if (temp_quotient==quotient && temp_remainder==remainder) {
        //printf("Passed\n");
    } else {
        //printf("Failed\n");
    } 
    
} 

int main() {
//testing using random numbers
    run_test_case(1,1);
    run_test_case(2,2);
    run_test_case(4,2);
    run_test_case(7,2);
    return 0;

}