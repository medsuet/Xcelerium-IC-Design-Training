#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void RIGHTSHIFTFUNC(signed int *num1, unsigned *num2, int my_shift) {
    int64_t RIGHTSHIFT = ((int64_t)*num1 << 32) | (uint32_t)*num2;
    my_shift = my_shift % 64;
    RIGHTSHIFT = RIGHTSHIFT >> my_shift;
    *num1 = ((int)(RIGHTSHIFT >> 32) & 0xFFFFFFFF);
    *num2 = (int)(RIGHTSHIFT & 0xFFFFFFFF);
}

int64_t BOOTHMULTIPLIER(int M, int Q) {
    char number_size = sizeof(M) * 8;
    char Qn;
    Qn = Q & 1;
    char Qn1 = 0;
    int AC = 0;
    char SC = number_size;

    while (1) {
        if ((Qn == 0 && Qn1 == 0) || (Qn == 1 && Qn1 == 1)) {
            RIGHTSHIFTFUNC(&AC, &Q, 1);
            SC--;
        } else if (Qn == 1 && Qn1 == 0) {
            AC = AC - M;
            RIGHTSHIFTFUNC(&AC, &Q, 1);
            SC--;
        } else if (Qn == 0 && Qn1 == 1) {
            AC = AC + M;
            RIGHTSHIFTFUNC(&AC, &Q, 1);
            SC--;
        }
        if (SC == 0) {
            break;
        } else {
            Qn1 = Qn;
            Qn = Q & 1;
        }
    }
    int64_t my_product = ((int64_t)AC << 32) | (uint32_t)Q;
    return my_product;
}

int main() {
    int multiplier;
    int multiplicand;

    printf("Enter a multiplier Integer: ");
    scanf("%d", &multiplier);
    printf("Enter a multiplicand Integer: ");
    scanf("%d", &multiplicand);

    printf("The Product of %d and %d is equal to %ld\n", multiplier, multiplicand, BOOTHMULTIPLIER(multiplicand, multiplier));

    return 0;
}
