
unsigned int set_or_clear_bit(unsigned int number, int bit_position, int control_flag) {
    if (control_flag) {
        // Set the bit
        number |= (1 << bit_position);
    } else {
        // Clear the bit
        number &= ~(1 << bit_position);
    }
    return number;
}

int main() {
    unsigned int number = 0b1010;  // Example number: 10 in decimal
    int bit_position = 2;  // Example bit position: 2
    int control_flag = 1;  // Example control flag: 1 (set bit)

    unsigned int result = set_or_clear_bit(number, bit_position, control_flag);
   // printf("Result: 0x%x\n", result);  // Print the result in hexadecimal

    return 0;
}
