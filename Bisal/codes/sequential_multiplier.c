/*
 * ============================================================================
 * Filename:    sequential_multiplier.c 
 * Description: File consists of Booth multiplication algorithm implementation
 * Author:      Bisal Saeed
 * Date:        7/5/2024
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>

#define MAX_BITS 32

//Defined for using only one bit for integer
struct oneBitField {
    unsigned int bit : 1;
};

// Function to add A and M arrays with a carry and save it in A
//--> let carry be 0 last bit of A=1 and M=1
void addBits(int *A, int *M, int n) {
    int carry = 0;
    for (int i = n-1 ; i >= 0 ; i--) {
        int sum = A[i] + M[i] + carry;
        A[i] = sum % 2;
        carry = sum / 2;
    }
    carry = 0;
}

// Function to calculate the 2's complement of an array (M -> -M) 
void twosComplement(int *M, int n) {
    //reversing 1 to 0 and 0 to 1 
    for (int i = 0; i < n; i++) {
        M[i] = M[i] == 0 ? 1 : 0;
    }
    // Add 1 to the least significant bit (LSB) of M
    int carry = 1;
    for (int i = n-1; i >=0; i--) {
        int sum = M[i] + carry;
        M[i] = sum % 2;
        carry = sum / 2;
    }

}

// Function to shift A and Q to right and updating q1
void shiftValue(int *A, int *Q, struct oneBitField *q1, int n) {
    //keep the sign bit "MSB" of A which is used in place of first bit after shift
    int signBitA = A[n - 1]; 
    //update value of q1 with value of  LSB of Q 
    q1->bit = Q[n-1]; 
    //store the LSB of A before shift to replace MSB for Q properly
    int temp=A[0];
    // Shift A to the right
    for (int i = 0; i < n - 1; i++) {
        A[i] = A[i + 1];
    }
    //replace the MSB with signbit
    A[n - 1] = signBitA; 

    // Shift Q to the right
    for (int i =n-1; i >= 0; i--) {
        Q[i] = Q[i-1];
    }
    //Move the saved LSB of A to MSB of Q
    Q[0] = temp;

}

// Function to reverse array elements
void reverseArray(int *arr, int n) {
    for (int i = 0; i < n / 2; i++) {
        //use the swap technique to reverse array
        int temp = arr[i];
        arr[i] = arr[n - i - 1];
        arr[n - i - 1] = temp;
    }
}

// Function to perform Booth's multiplication algorithm using arrays and pointers
void sequenceMultiplier(int multiplicand, int multiplier, int n) {
    // Initialize arrays for A, Q, and M
    int A[MAX_BITS] = {0};
    int Q[MAX_BITS] = {0};
    int M[MAX_BITS] = {0};
    int neg_m[MAX_BITS] = {0};
    int index = 0;

    //testcase conditions on multiplier and multiplicand
    int flag_sign=0;
    if ((multiplicand<0 && multiplier>0) || (multiplicand>0 && multiplier<0)){
        //if one negative and positive number are multiplied so let flag_sign be 1
        flag_sign=1;
    }
    else if (((multiplicand<0)&&(multiplier<0))|| ((multiplicand>0 && multiplier>0))){
        //if two negative numbers or teo positive numbers are multiplied so let flag_sign be 0
        flag_sign=0;
    }
    //ZERO MULTIPLICATION CASE
    /*else if ((multiplicand=0) || (multiplier=0)){
        result=0;
        printf("Product is %d",);
        exit(1);
    } --> works fine without this case so excluded 
    */
    //take absolute values of multiplicand and ,multiplier in case of negative numbers to simplify computation
    multiplicand= (multiplicand<0)? -multiplicand : multiplicand;
    multiplier= (multiplier<0)? -multiplier : multiplier;

    // Initialize arrays from integers, focusing on bits following the first non-zero bit
    while (multiplicand > 0) {
        //lets say if multiplicand is 3 so 3 % 2=1>on M[0]=1 and then multiplicand becomes
        //quotient of previosu computation that is 1 --> 1%2 = 1 so array as 110 is formed
        M[index++] = multiplicand % 2;
        multiplicand /= 2;
    }
    //reverse array to store the bits in correct order lets say as 011
    reverseArray(M, n);
    
    //initialize another array with same values as M -->used during compliment to avoid 
    //overwriting the M in normal addition caase
    for (int i=0;i<n;i++){
        neg_m[i]=M[i];
    }
    //repeat same for multiplier
    index = 0;
    while (multiplier > 0) {
        Q[index++] = multiplier % 2;
        multiplier /= 2;
    }
    reverseArray(Q, n);

    //make array of A upto n bits with zeros
    for (int i = 0; i < n; i++) {
        A[i] = 0; 
    }

    // Initialize q1 as a struct to store the LSB of Q with intial value of 0 
    struct oneBitField q1 = {0};

    // Print initial values 
    printf("Initial values:\n");
    printf("A: ");
    for (int i = 0; i < n; i++) {
        printf("%d", A[i]);
    }
    printf("\nQ: ");
    for (int i = 0; i < n; i++) {
        printf("%d", Q[i]);
    }
    printf("\nM: ");
    for (int i = 0; i < n; i++) {
        printf("%d", M[i]);
    }
    printf("\nq1: %d\n", q1.bit);

    // Iterate through each bit of multiplier or multiplicant using a while loop
    int count = n;
    while (count > 0) {
        // Check Booth's algorithm conditions and perform operations on arrays
        //01 CASE
        if (q1.bit == 1 && Q[n-1] == 0) {
            //reverse the array A for proper addition so both added from LSB towards MSB 
            reverseArray(A,n);
            addBits(A, M, n);
            //reverse the bits of A again to print proper values of A 
            reverseArray(A,n);  
        }
         //10 CASE
         else if (q1.bit == 0 && Q[n-1] == 1) {
            //takes M=-M 
            twosComplement(neg_m,n);
            //perform A<-A-M
            addBits(A, neg_m, n);
        }

        //print values for debugging

        printf("A Before shift: ");
        for (int i = n-1; i >=0; i--) {
            printf("%d", A[i]);
        }
        printf("\n");

         printf("Q before shift: ");
        for (int i = 0; i <n ; i++) {
            printf("%d", Q[i]);
        }
        printf("\n");

        shiftValue(A, Q, &q1, n);

        printf("A after shift: ");
        for (int i = n-1; i >=0; i--) {
            printf("%d", A[i]);
        }
        printf("\nQ after shift: ");
        for (int i = 0; i <n; i++) {
            printf("%d", Q[i]);
        }
        printf("\nq1 after shift: %d\n", q1.bit);

        count--;
    }

    // Calculate the final result from concatenated A and Q arrays
    int result = 0;
    // Concatenate A bits
    reverseArray(A,n);
    for (int i = 0; i < n; i++) {
        result = (result << 1) | A[i];
    }
    // Concatenate Q bits
    for (int i = 0; i < n; i++) {
        result = (result << 1) | Q[i];
    }
    //if neg * pos then just add negative sign to result
    if (flag_sign==1){
    result=-result;
    }
    else if (flag_sign==0){
    result=result;
    }
    /*else {
        result = 0;
    }*/

    // Print the final result
    printf("Product (integer): %d\n", result);
}

int main() {
    int num1, num2, n;
    /*n=3;
    num1=3;
    num2=-2;
    */
    printf("Enter the number of bits for multiplicand and multiplier: ");
    scanf("%d", &n);

    printf("Enter the first number: ");
    scanf("%d", &num1);
    printf("Enter the second number: ");
    scanf("%d", &num2);

    sequenceMultiplier(num1, num2, n);
    return 0;
}
