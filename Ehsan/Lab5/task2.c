//file description : this code perform setting or clearing any bit in a 32-bit number
int main() {
    unsigned int number = 8;
    unsigned int position = 2;
    unsigned int change_bit = 1; //change_bit = 0 for clear bit(0) and change_bit = 1 for set bit(1) or 
    unsigned int i;

    if (change_bit == 0) {
        i = ~(1 << position);
        number = number & i;  

    } else if (change_bit == 1) {
        i = 1 << position;
        number = number | i;     
    }
    return 0;
}
