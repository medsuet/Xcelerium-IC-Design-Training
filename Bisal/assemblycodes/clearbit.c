/*
#  ============================================================================
#  Filename:    clearbit.c 
#  Description: File consists of code to set or clear a particular bit 
#  Author:      Bisal Saeed
#  Date:        7/15/2024
#  ============================================================================
*/

#include <stdio.h>

void setOrClearBit(int *num, int bitPosition, int choice) {
    int mask = 1 << bitPosition;

    if (choice == 1) {
        *num |= mask;    // Set bit at position bitPosition
    } else if (choice == 0) {
        *num &= ~mask;   // Clear bit at position bitPosition
    }
}

int main() {
    int a0 = 6;       // Initial number
    int a1 = 2;       // Bit position to set or clear
    int a2 = 0;       // Choice: 1 = set, 0 = clear

    // Check validity of bit position
    if (a1 < 0 || a1 > 31) {
        printf("Invalid bit position. It must be between 0 and 31.\n");
        return 1;   // Exit program with error
    }

    // Perform set or clear bit operation
    setOrClearBit(&a0, a1, a2);

    // Print the result after operation
    printf("Resulting number after bit operation: %d\n", a0);

    return 0;
}
