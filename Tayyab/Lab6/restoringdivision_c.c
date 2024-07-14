/*
    Name: division.c
    Author: Muhammad Tayyab
    Date: 10-7-2024
    Description: Implements restoring division algorithem for uint32 numbers
*/

// Returns msb of num shifted to lsb position
#define GETMSB(num) (num & (1<<31)) >> 31

// TODO: Implement the restoring_division function
// It should take dividend and divisor as inputs and return quotient and remainder
void restoring_division(int dividend, int divisor, int *quotient, int *remainder) {
    // TODO: Implement the non-restoring division algorithm
    // Remember to handle division by zero
    // Returns quotient = remainder = 0 if divisor = 0

    // Q = quotient; A = remainder; M = Divisor

    int numBits;
    int remainder_msb;
    int remainder_copy;
    int quotient_msb;


    // Check division by zero case
    if (divisor == 0) {
        *quotient = 0;
        *remainder = 0;
        return ;
    };

    // Initialize values
    *quotient = dividend;
    *remainder = 0;
    numBits = 32;

    do {
        // Shift reminder and quotient one place left as a single block
    
        // Store msb of quotient
        quotient_msb = GETMSB(*quotient);

        // Shift reminder and quotient one place left
        *remainder = (*remainder) << 1;
        *quotient = (*quotient) << 1;
    
        // Place msb of quotient at lsb of reminder
        *remainder = (quotient_msb == 1) ? (*remainder | quotient_msb) : (*remainder & (~quotient_msb));

        // Make a copy of reminder for restoring if required
        remainder_copy = *remainder;

        // Subtract divisor from reminder
        *remainder = (*remainder) - divisor;

        // Check msb of reminder
        remainder_msb = GETMSB(*remainder);
        if (remainder_msb == 1) {
            // Set lsb of quotient to 0
            *quotient = (*quotient) & (~( (int) 1 ));
            
            // Restore reminder
            *remainder = remainder_copy;
        }
        else {
            // Set lsb of quotient to 1
            *quotient = (*quotient) | (int) 1;
        }

        // Decrement counter
        numBits--;

    } while (numBits > 0 );         // Repeat until numBits becomes zero

    return ;
}

int main() {
    int dividend, divisor, quotient, remainder;
    
    dividend = 5;
    divisor = 3;

    restoring_division(dividend, divisor, &quotient, &remainder);
}
