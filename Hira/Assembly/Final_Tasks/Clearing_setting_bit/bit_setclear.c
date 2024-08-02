/*#include <stdio.h>
#include <stdint.h>
*/
// Function to set a specific bit in a 32-bit number
int set_bit(int number, int bit_position) {
    return number|(1<<bit_position);
}

// Function to clear a specific bit in a 32-bit number
int clear_bit(int number, int bit_position) {
    return number & ~(1 << bit_position);
}

int main() {
    int number;
    int bit_position;
    int flag; // 1 to set the bit, 0 to clear the bit

    // Get user input
    /*
    printf("Enter a 32-bit number: ");
    scanf("%x", &number);
    printf("Enter the bit position to set or clear (0-31): ");
    scanf("%d", &bit_position);
    printf("Enter 1 to set the bit, 0 to clear the bit: ");
    scanf("%d", &flag);
	*/


    // Perform the set or clear operation
    if (flag == 1) {
        number = set_bit(number, bit_position);
    } else if (flag == 0) {
        number = clear_bit(number, bit_position);
    } else {
	    /*
        printf("Invalid flag value. Enter 1 to set the bit or 0 to clear the bit.\n");
        return 1;
	*/
    }

    // Print the result
    //printf("Resulting number:", number);

    return 0;
}

