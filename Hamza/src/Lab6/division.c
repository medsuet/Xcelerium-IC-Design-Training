// Author: Hamza
// Date: 10 July 2024
// Division.c for calculating dividend and divsior of two numbers


// Implement the restoring_division function
void restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder) {
    // Step 1: Intializing the Registers
    unsigned int Q = dividend;   
    unsigned int M = divisor;    
    unsigned int A = 0;       
    unsigned int n = sizeof(dividend) * 8;  

    for (unsigned int i = 0; i < n; i++) {
        // Step-2: Shifting A and Q to left
        A = (A << 1) | ((Q >> (n - 1)) & 1);
        Q = Q << 1;


        // Step-3: Subtracting M from A
        unsigned int original_A = A;  // Storing original A for step-4 
        A = A - M;

        // Step-4: Checking the most significant bit of A
        if (A & (1 << (n - 1))) {  // If MSB of A is 1
            Q = Q & (~1);  // Setting LSB of Q to 0
            A = original_A;  // Restoring A to its original value
        } else {
            Q = Q | 1;  // Setting the LSB of Q to 1
        }
    }

    // Step-7: Extracting Quotient
    *quotient = Q;
    *remainder = A;
}

// Implement test cases
void run_test_case(unsigned int dividend, unsigned int divisor) {
    // Initializing unsigned 32 bit ints
    unsigned int quotient = 0;
    unsigned int remainder = 0;
    unsigned int testQuotient = 0;
    unsigned int testRemainder = 0;

    // Checking if the divisor is equal to 0
    if (divisor == 0){
        return;
    }

    // Calculating the quotient and remainder using operators
    testQuotient = dividend / divisor;
    testRemainder = dividend % divisor;

    restoring_division(dividend, divisor, &quotient, &remainder);

}

int main() {
    run_test_case(10, 5);
    run_test_case(15, 5);
    run_test_case(12, 5);
    run_test_case(10, 3);

    return 0;
}
