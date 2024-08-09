// Define the number of bits in a uint32_t integer
#define BITS_IN_UINT32 32
/*
 * Function: restoring_division
 * Implements the restoring division algorithm.
 */
void restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder);
/*
  Function: run_test_case
  Runs a test case to verify the restoring division algorithm.
 */
void run_test_case(unsigned int dividend, unsigned int divisor);

// It should take dividend and divisor as inputs and return quotient and remainder
void restoring_division(unsigned int dividend, unsigned int divisor, unsigned int *quotient, unsigned int *remainder) {
    // TODO: Implement the non-restoring division algorithm
    // Remember to handle division by zero

    // Step 1: Initializing Q: Dividend, M: Divisor, n: No of bits in dividend and A: remainder
    unsigned int Q = dividend;        
    unsigned int M = divisor; 

    // Initialize Remainder A to 0        
    unsigned int A = 0;               
    unsigned int n = BITS_IN_UINT32;  

    // This will hold A and Q combined for the purpose of shifting
    // To keep two 32 bit integer together we require a 64 bit integer 
    unsigned long long combinedAQ;


    // Handling division by zero
    if (divisor == 0) {
        // Print error and return 
        // printf("Error: Division by zero.\n");
        *quotient = 0;
        *remainder = 0;
        return;
    }

    // Initialize quotient and remainder
    *quotient = 0;
    *remainder = 0;

    // Set the value for counter
    unsigned int i = n;

    // Step 6: If the value of n becomes zero, we get of the loop otherwise we repeat from step 2 
    while (i > 0){
        // Step 2: The content of register A and Q is shifted left as if they are a single unit 
        combinedAQ = ((unsigned long long)A << 32) | Q;
        combinedAQ = (combinedAQ << 1);
        Q = combinedAQ & 0xFFFFFFFF;
        A = (combinedAQ >> 32) & 0xFFFFFFFF;

        // Part 3: Subtract M from A
        A -= M;

        // Part 4: Check the most significant bit of A
        if (A & 0x80000000) {
            // MSB of A is 1, so set the LSB of Q to 0 and restore A
            Q &= 0xFFFFFFFE;
            A += M;
        } else {
            // MSB of A is 0, so set the LSB of Q to 1
            Q |= 1;
        }

    // Step 5: decrement n
        i = i - 1;
    }

    // Step 7: Finally, the register Q contains the quotient and A contains remainder
    *quotient = Q;
    *remainder = A;

}


// TODO: Implement test cases
void run_test_case(unsigned int dividend, unsigned int divisor) {
    // TODO: Call restoring_division and verify the results
    unsigned int quotient, remainder;
    unsigned int actualQ, actualR;

    // Call restoring_division
    restoring_division(dividend, divisor, &quotient, &remainder);

    // Compare with standard division
    actualQ = dividend / divisor;
    actualR = dividend % divisor;

    // Print both the restored values and actual values
    // printf("Test Case:\n");
    // printf("Dividend: %u, Divisor: %u\n", dividend, divisor);
    // printf("Restored Quotient: %u, Restored Remainder: %u\n", quotient, remainder);
    // printf("Operator Quotient: %u, Operator Remainder: %u\n", actualQ, actualR);

    // Validate results
    // If restored values are equal to actual, print results matched.
    if (quotient == actualQ && remainder == actualR) {
        // printf("Results match!\n\n");
    } else {
        // printf("Results do not match.\n\n");
    }
}

int main() {
    // TODO: Implement multiple test cases
    // Example:
    //run_test_case(20, 5);

    // Seed the random number generator
    // srand(time(NULL));

    // // Implement multiple test cases
    // for (int i = 0; i < 10; i++) {
    //     // Random dividend
    //     uint32_t dividend = rand() % 1000;

    //     // Random divisor 
    //     uint32_t divisor = rand() % 1000; 

    //     // Ensure we don't divide by zero
    //     if (divisor == 0) {
    //         divisor = 1; 
    //     }

    //     run_test_case(dividend, divisor);
    // }
    run_test_case(122, 6);
    run_test_case(12, 9);
    run_test_case(443, 722);
    run_test_case(122, 222);
    run_test_case(10000, 2000);
    // run_test_case(0, 1);
    // //run_test_case(1000000, 0);
    // run_test_case(99999999, 100000000);
    return 0;
}