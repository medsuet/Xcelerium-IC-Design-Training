/*
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
*/
/*
============================================================================
 * Filename:    template_code_Part1.c
 * Description: File consists of codes based on advanced concepts of C language
 * Author:      Hira Firdous
 * Date:        10/07/2024
 * ===========================================================================
*/


//Helper functions from the previous Multiplier lab.

void print_binary(int *num){
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




void arithmeticleftshift(int *A, int *Q, int bit_width) { 
    int MSB_Q = (*Q >> (bit_width-2)) & 1;
    // Shift A left and update its LSB with MSB of Q
    *A = (*A << 1) | (MSB_Q);
    // Shift Q left 
    *Q = (*Q << 1);    
    
}



int correcting_Q(int *A,int bit_width){
    *A=*A <<(32-bit_width+1);
    int answer=(*A >> (32-bit_width+1)) | 0;
    return answer;
}

/*
struct divison{
    int quotient;
    int remainder;
};
*/


void restoring_division(int dividend, int divisor,int *remainder ,int *quotient) {
    /*Arguments: 

    // It should take dividend and divisor as inputs and return quotient and remainder
    */

    //For special case
    if (dividend==0 || divisor==0){
        *remainder=0;
        *quotient=0;
    }


    //Variables initialization and declaration
    int MSB_A=0;
    int N=binary_width(dividend);               //loop condition
    int width=binary_width(dividend);
    int A=0;
    int M=divisor;
    int Q=dividend;
    int temp_A= A;

    while((N-1)>0){

        
        arithmeticleftshift(&A, &Q, width);


        temp_A= A;                                //For restoring A

        A-=M;
        MSB_A = (A >> (width - 1)) & 1;
        
        //check the conditions
        if (MSB_A==0){                  
            Q = Q | 1;                              //LSB_Q=1
        }else{
            A=temp_A;
        }
        N--;
    }

    //to clear the unneccessary bits in Q
    int answer= correcting_Q(&Q,width);

    if (answer<0){
        answer=-answer;
    }

    print_binary(&A);
    printf("remainder: %d \n",A);
    print_binary(&answer);
    printf("quotient: %d \n",answer);

    *remainder=A;
    *quotient=answer;
    


}

// TODO: Implement test cases
void run_test_case() {
    //srand(time(NULL));
    //int input_num=rand();

    int test_cases=0;

    //printf("Enter the number of test cases you want to run:\n");
    //scanf("%d", &test_cases);

    for (int i = 0;i <= test_cases; i++){
        //variables, mode so that they are within the range
        int input_number_1=rand() % 65536;
        int input_number_2=rand() % 65536;

        //output from my function
        
        //output from operator
        //int64_t original_answer=input_number_1 * input_number_2;
        printf("Test case %d:\n", i + 1);
        printf("%d / %d \n", input_number_1, input_number_2 );


        int rd_reminder;
        int rd_quotient;
        restoring_division(input_number_1, input_number_2, &rd_reminder, &rd_quotient);


        // % mode will give me reminder
        // / will give me the quotient
        int reminder=input_number_1 % input_number_2;
        int quotient=input_number_1 / input_number_2;


        /*
        if (booth_answer == original_answer){
            printf("Passed\n");
        }
        else{
            printf("Failed\n");
        }
        */
        
    }
}



int main() {


    // Sample Test Case
    /*
    intnum_1=11;
    intnum_2=3;
    int Q;
    int A;
    restoring_division(num_1,num_2,&A,&Q);
    printf("A: %d\n",A);
    printf("Q: %d\n",Q);
    */


    run_test_case();
    
    
   
   
}
