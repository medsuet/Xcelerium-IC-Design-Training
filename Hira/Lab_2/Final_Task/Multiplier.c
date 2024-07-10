/*
============================================================================
 * Filename:    Multiplier.c
 * Description: Contains the implementation of Multiplier
 * Author:      Hira Firdous
 * Date:        08/07/2024
* ===========================================================================
*/


#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>


void print_binary(int *num){
    /*Print the binary of the decimal number*/

    int *ptr;
    ptr = num;
    for (int i = sizeof(int) * 8 - 1; i >= 0; i--) {
    printf("%d", (*ptr >> i) & 1);
    }
    printf("\n");

}

void print_binary64(int *num){
    /*Print the binary of the decimal number*/

    int *ptr;
    ptr = num;
    for (int i = sizeof(int) * 8 - 1; i >= 0; i--) {
    printf("%d", (*ptr >> i) & 1);
    }
    printf("\n");

}


int binary_width(int num) {
    /*Calculate the number of bits required to represent the number, including the sign bit*/
    int width = 0;
    
    // Handle the special case when the number is 0
    if (num == 0) {
        return 1;
    }
    
    // For negative numbers, use the absolute value
    int abs_num = (num < 0) ? -num : num;
    
    while (abs_num != 0) {
        abs_num = abs_num >> 1;  // Shift right by 1 bit
        width++;
    }
    
    // Add 1 bit for the sign
    return width + 1;
}




void arithmeticRightShift(int *A, int *Q, int *Q_minus_1, int bit_width) {
    // Perform arithmetic right shift on A and Q, update Q_minus_1 with the LSB of Q
    int sign_bit_A = (*A >> (bit_width - 1)) & 1;
    int lsb_A = *A & 1;
    int lsb_Q = *Q & 1;
    *Q_minus_1 = lsb_Q;
    // Shift Q right and update its MSB with LSB of A
    *Q = (*Q >> 1) | (lsb_A << (bit_width - 1));

    // Shift A right and preserve its sign bit
    *A = (*A >> 1) | (sign_bit_A << (bit_width - 1));

    
}

int64_t combineBits(int A, int Q, int bit_width) {
    // Combine the LSB_A and MSB_Q into a single value
    /*
    int LSB_A = A <<bit_width;
    int combined = LSB_A | Q;
    */

    int64_t combined=0;
    combined=combined | A;
    combined= combined << bit_width ;
    combined=combined | Q;
    return combined;
}



int binary_addition(int *A,int *M, int width){
        /*Store the addition(A+M) in the A*/

        /*
        int carry = 0;
        for (int i = width - 1; i >= 0; i--) {
            int a_bit = (*A >> i) & 1;
            int m_bit = (*M >> i) & 1;

            int sum = a_bit + m_bit + carry;
            carry = sum >> 1;  // Extract carry (bit 2)
            sum = sum & 1;     // Extract sum (bit 1)

            // Update the bit in A
            *A = (*A & ~(1 << i)) | (sum << i);

            // Debugging output for each step
            printf("Bit %d: a_bit=%d, m_bit=%d, carry=%d, sum=%d, A=%0*X\n", 
                i, a_bit, m_bit, carry, sum, (width + 3) / 4, *A);
        }
        return carry;
        */
        *A += *M;
}

void complement(int *m, int bit_width) {
    /*arguments: takes number as pointer 
        find complement of number
      output Stores the output in M*/

    // Step 1: Invert all the bits (1's complement)
    *m = ~(*m);
    // Step 2: Add 1 to the least significant bit (2's complement)
    int one = 1;
    binary_addition(m, &one, bit_width);
}




int64_t booth_multiplication(int multiplicand, int multiplier) {
    if ((multiplier == 0) || (multiplicand == 0)) {
        return 0;
    }
    // Initialize variables
    int A = 0;
    int Q = (multiplier < 0) ? -multiplier : multiplier;  // Absolute value of multiplier
    int M = (multiplicand < 0) ? -multiplicand : multiplicand;  // Absolute value of multiplicand

    if (Q>M){
        int temp= M;
        M=Q;
        Q=temp;
    }
    int Q_minus_1 = 0;
    int width = binary_width(M);  // Bit width of multiplier (and Q)



    // Main Booth's algorithm loop
    for (int i = 0; i < width; i++) {
        int lsb_Q = Q & 1;
        int operation_code = (Q_minus_1 << 1) | lsb_Q;

        switch (operation_code) {
            case 2:  // Q_minus_1 = 1, lsb_Q = 0 -> ADD M from A
                //printf("ADD M from A\n");
                binary_addition(&A, &M, width);
                break;
            case 1:  // Q_minus_1 = 0, lsb_Q = 1 -> Subtract M to A
                int neg_M = M;
                complement(&neg_M, width);
                //printf("Subtract M to A\n");
                binary_addition(&A, &neg_M, width);
                break;
            // case 0 and 3: No operation needed
            default:
                break;
        }

        // Arithmetic right shift on A, Q, Q_minus_1
        arithmeticRightShift(&A, &Q, &Q_minus_1,binary_width(M));
    }

   

    // Final adjustment for negative multiplier
    int64_t  combined = combineBits(A, Q, width);
    if ((multiplier < 0 && multiplicand >= 0) || (multiplier >= 0 && multiplicand < 0)) {
        combined =-combined;
    }

    return combined;
}

void run_test_cases() {
    //test the code with hardcoded testcases
    struct test_case {
        int multiplicand;
        int multiplier;
        int expected_result;
    };

    struct test_case test_cases[] = {
        {3, 6, 18},
        {7, -5, -35},
        {-4, 3, -12},
        {-3, -2, 6},
        {0, 9, 0},
        {8, 0, 0},
        {0, 0, 0},
        {12345, 6789, 83810205}
    };

    int num_tests = sizeof(test_cases) / sizeof(test_cases[0]);

    for (int i = 0; i < num_tests; i++) {
        int result = booth_multiplication(test_cases[i].multiplicand, test_cases[i].multiplier);
        printf("Test case %d:\n", i + 1);
        printf("Multiplicand: %d, Multiplier: %d\n", test_cases[i].multiplicand, test_cases[i].multiplier);
        printf("Expected result: %d, Result: %d\n", test_cases[i].expected_result, result);
        printf("Result in binary: ");
        print_binary(&result);
        printf("\n");
    }
}

void testing_by_random_testcases(){
    /*Input a random number form the user and run 
    random test cases to check the valaidity of the code*/

    srand(time(NULL));
    int input_num=rand();

    int test_cases=0;

    printf("Enter the number of test cases you want to run:\n");
    scanf("%d", &test_cases);

    for (int i = 0;i <= test_cases; i++){
        //variables
        int input_number_1=rand();
        int input_number_2=rand();

        //output from my function
        int64_t booth_answer=booth_multiplication(input_number_1,input_number_2);
        //output from operator
        int64_t original_answer=((int64_t)input_number_1) * input_number_2;
        printf("Test case %d:\n", i + 1);
        printf("%d x %d \n",input_number_1,input_number_2 );
        if (booth_answer == original_answer){
            print_binary( &booth_answer);
            print_binary( &original_answer);
            printf("Passed\n");
        }
        else{
            printf("Failed\n");
            
            print_binary( &booth_answer);
            print_binary( &original_answer);
        }
    }

}


int main(){
 
    testing_by_random_testcases();
    
}




