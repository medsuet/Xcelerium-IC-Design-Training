#include <stdio.h>
#include <stdint.h>

uint32_t set_or_clear_bit(uint32_t number, uint32_t bit_pos, int action) {
    // Create a bit mask by shifting 1 to the left by bit_pos
    uint32_t mask = 1 << bit_pos;

    if (action == 1) {
        // Set the bit
        number |= mask;
    } else {
        // Clear the bit
        number &= ~mask;
    }

    return number;
}

int main() {
    uint32_t number = 0x12345678; 
    uint32_t bit_pos = 5;         // Bit position to be set/cleared 
    int action = 1;               // Action (1 for set, 0 for clear)

    printf("Original number: 0x%08X\n", number);

    // Perform the set or clear bit operation
    number = set_or_clear_bit(number, bit_pos, action);

    printf("Modified number: 0x%08X\n", number);

    return 0;
}
