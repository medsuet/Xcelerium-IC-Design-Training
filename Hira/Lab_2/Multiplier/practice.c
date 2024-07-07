#include <stdio.h>
#include <stdint.h>



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






void arithmeticRightShift(int *A, int *Q, int *Q_minus_1) {
    /*Perform arithmetic right shift on A and Q, update Q_minus_1 with the LSB of Q*/
    int sign_bit_A = (*A >> (sizeof(int) * 8 - 1)) & 1;
    int lsb_Q = *Q & 1;
    *Q_minus_1 = lsb_Q;

    *Q = (*Q >> 1) | ((*A & 1) << (sizeof(int) * 8 - 1));
    *A = (*A >> 1) | (sign_bit_A << (sizeof(int) * 8 - 1));
}

int binary_addition(int *A,int *M, int width){
        /*Store the addition(A+M) in the A*/
    int carry = 0;
        for (int i = width - 1; i >= 0; i--) {
            int a_bit = (*A >> i) & 1;
            int m_bit = (*M >> i) & 1;

            int sum = a_bit + m_bit + carry;
            carry = (sum >> 1) & 1;
            sum = sum & 1;

            // Update the bit in A
            *A = (*A & ~(1 << i)) | (sum << i);
        }
        return carry;
}

void complement(int *m, int bit_width) {
    // Step 1: Invert all the bits (1's complement)
    *m = ~(*m);
    // Step 2: Add 1 to the least significant bit (2's complement)
    int one = 1;
    binary_addition(m, &one, bit_width);
}




int booth_multiplication(int multiplicand, int multiplier) {
    // Initialize variables
    int A = 0;
    int Q = (multiplier < 0) ? -multiplier : multiplier;  // Absolute value of multiplier
    int M = (multiplicand < 0) ? -multiplicand : multiplicand;  // Absolute value of multiplicand
    int Q_minus_1 = 0;
    int width = binary_width(Q);  // Bit width of multiplier (and Q)

    // Main Booth's algorithm loop
    for (int i = 0; i < width; i++) {
        int lsb_Q = Q & 1;
        int operation_code = (Q_minus_1 << 1) | lsb_Q;

        switch (operation_code) {
            case 2:  // Q_minus_1 = 1, lsb_Q = 0 -> Subtract M from A
                binary_addition(&A, &M, width);
                break;
            case 1:  // Q_minus_1 = 0, lsb_Q = 1 -> Add M to A
                int neg_M = M;
                complement(&neg_M, width);
                binary_addition(&A, &neg_M, width);
                break;
            // case 0 and 3: No operation needed
            default:
                break;
        }

        // Arithmetic right shift on A, Q, Q_minus_1
        arithmeticRightShift(&A, &Q, &Q_minus_1);
    }

    // Final adjustment for negative multiplier
    if ((multiplier < 0 && multiplicand >= 0) || (multiplier >= 0 && multiplicand < 0)) {
        complement(&Q, width);
    }

    return Q;
}




int main(){
    int num1 = 5; 
    int num2 = 10; 
    print_binary(&num1);
    print_binary(&num2);
    printf("The width of number is %d is %d",num1,binary_width(num1));
    printf("\n");
    printf("The width of number is %d is %d",num2,binary_width(num2));
    printf("\n");
    int carry=binary_addition(&num1,&num2, binary_width(num2));
    printf("carry: %d", carry);
    printf("\n");
    print_binary(&num1);


    int m = -5; // Example number
    printf("Original number (m): %d",m);
    print_binary(&m);
    
    printf("The width of number is %d is %d \n",num1,binary_width(m));
    complement(&m, binary_width(m));

    printf("2's complement (m):%d \n",m);
    print_binary(&m);

//-----------------------------------------------------------------------------------------------------------------------

    int multiplicand = 5; // Example multiplicand
    int multiplier = -3; // Example multiplier

    printf("Multiplicand (M): ");
    print_binary(&multiplicand);

    printf("Multiplier (Q): ");
    print_binary(&multiplier);

    int result = booth_multiplication(multiplicand, multiplier);

    printf("Result: %d\n", result);
    printf("Result in binary: ");
    print_binary(&result);

    return 0;


//-------------------------------------------------------Test case for Shift-----------------------------------------------
/*     
    int A = 5, M = 3, width;
    width = sizeof(int) * 8;
    
    printf("Binary representation of A: ");
    print_binary(&A);
    
    printf("Binary representation of M: ");
    print_binary(&M);
    
    printf("Binary width of A: %d\n", binary_width(A));
    printf("Binary width of M: %d\n", binary_width(M));
    
    binary_addition(&A, &M, width);
    printf("Binary representation of A after addition: ");
    print_binary(&A);
    
    int Q = 3, Q_minus_1 = 0;
    printf("Binary representation of A before shift: ");
    print_binary(&A);
    printf("Binary representation of Q before shift: ");
    print_binary(&Q);
    printf("Value of Q_minus_1 before shift: %d\n", Q_minus_1);
    
    arithmeticRightShift(&A, &Q, &Q_minus_1);
    
    printf("Binary representation of A after shift: ");
    print_binary(&A);
    printf("Binary representation of Q after shift: ");
    print_binary(&Q);
    printf("Value of Q_minus_1 after shift: %d\n", Q_minus_1);

    return 0;
    */
}




