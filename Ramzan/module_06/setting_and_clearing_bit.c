#include <stdio.h>

int main() {
    int n = 3;
    int set_bits;
    int clear_bits;
    int set = 1;
    int clear = 1;

    // Set the 2nd bit (index 0)
    set_bits = n | (set << 2);

    // Clear the 3rd bit (index 2)
    clear_bits = n & ~(clear << 3);

    printf("The number after setting the 1st bit is: %d\n", set_bits);
    printf("The number after clearing the 3rd bit is: %d\n", clear_bits);

    return 0;
}
