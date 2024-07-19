//***********Author: Masooma Zia***********
//***********Description: Implement the restoring_division function***********
//***********Date: 17-07-2024***********
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void restoring_division(uint32_t dividend, uint32_t divisor) {
    uint32_t A = 0;
    uint32_t quotient = 0;
    int n = 32;

    while (n > 0) {
        A = (A << 1) | (dividend >> 31); //A after left shift of AQ as a single unit
        dividend <<= 1; //dividend after left shift of AQ as a single unit
        A = A - divisor;
        // Check if MSB of A is set
        if (A & (1 << 31)) {
            // Restore A and set LSB of quotient to 0
            A = A + divisor;
            dividend &= ~(1);
        } else {
            dividend |= 1; //to set lsb of dividend equal to 1
        }

        n--;
    }

    printf("Quotient is: %u\n", dividend);
    printf("Remainder is: %u\n", A);
}


int main() {
    restoring_division(20, 3);
    restoring_division(4, 2);  
    return 0;
}
