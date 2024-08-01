#include <stdio.h>

int array_multiplier(short int multiplier, short int multiplicand) {
    int partial_product = 0;
    short int multiplier_bit;

    for (int i = 0; i < 15; i++) {
        multiplier_bit = (multiplier & (1 << i));

        if (multiplier_bit != 0) {
            partial_product += (multiplicand << i);
        }
   
    }

    // Check if the MSB of the multiplier is 1 for signed multiplication
    if (multiplier & (1 << 15)) {
        short int twos_compliment = (~multiplicand + 1);
        partial_product += (twos_compliment << 15);
    }

    return partial_product;
}

int main(void) {
    int result = array_multiplier(7, -3);
    printf("%d \n", result);
    return 0;
}
