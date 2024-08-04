// Function to perform non-restoring division
void non_restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder) {
    unsigned int A = 0; // Remainder
    unsigned int Q = dividend; // Quotient
    unsigned int M = divisor; // Divisor
    int i;

    for (i = 0; i < 32; ++i) {
        // Shift A and Q left by 1
        A = (A << 1) | (Q >> 31);
        Q = Q << 1;

        // Subtract M from A
        A = A - M;

        // If A is negative, restore A and set Q[0] to 0
        if ((unsigned int)A < 0) {
            A = A + M;
        } else {
            // If A is positive, set Q[0] to 1
            Q = Q | 1;
        }
    }

    // Store the quotient and remainder
    *quotient = Q;
    *remainder = A;
}

int main() {
    unsigned int dividend = 123;
    unsigned int divisor = 5;
    unsigned int quotient = 0;
    unsigned int remainder = 0;

    non_restoring_division(dividend, divisor, &quotient, &remainder);

    return 0;
}
