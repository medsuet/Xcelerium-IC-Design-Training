/*
 * File: bit_edit.c
 * Author: Misbah Rani
 * Date: 2024-07-20
 * Description: This file contains the implementation of set or clear bits
 *              in C language.
 */
#include <stdio.h>

int manipulateBit(char operation, int bit_position, int number) {
    int result;
    int bit_mask = (1 << (bit_position - 1));
    int lower_bits_mask = (1 << (bit_position - 1)) - 1;
    int combined_mask = bit_mask | lower_bits_mask;

    if (operation == 'c') {
        result = number & ~combined_mask;
    } else if (operation == 's') {
        result = number | combined_mask;
    } else {
        result = number;
    }

    return result;
}

int main() {
    printf("%d\n", manipulateBit('c', 3, 17));
    printf("%d\n", manipulateBit('s', 1, 17));

    return 0;
}
