#include <stdio.h>
#include <stdint.h>

// Function to set a bit at a specific position in a 32-bit number
void setBit(uint32_t *number, uint8_t bitPosition) {
    *number |= (1 << bitPosition);
}

// Function to clear a bit at a specific position in a 32-bit number
void clearBit(uint32_t *number, uint8_t bitPosition) {
    *number &= ~(1 << bitPosition);
}

int main() {
    uint32_t number = 0x12345678; // Example number
    uint8_t bitPosition = 3;       // Bit position to modify (0-based)

    printf("Initial number: 0x%08X\n", number);

    // Set the bit at position bitPosition
    setBit(&number, bitPosition);
    printf("After setting bit %d: 0x%08X\n", bitPosition, number);

    // Clear the bit at position bitPosition
    clearBit(&number, bitPosition);
    printf("After clearing bit %d: 0x%08X\n", bitPosition, number);

    return 0;
}
