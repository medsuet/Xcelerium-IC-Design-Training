

unsigned int modify_bit(unsigned int number, unsigned int bit_position, int action) {
    if (action == 1) {
        // Set the bit
        number |= (1 << bit_position);
    } else {
        // Clear the bit
        number &= ~(1 << bit_position);
    }
    return number;
}

int main() {
    unsigned int number = 156;  
    unsigned int bit_position = 5;
    int action = 1;        

    unsigned int modified_number = modify_bit(number, bit_position, action);
    
    
    return 0;
}
