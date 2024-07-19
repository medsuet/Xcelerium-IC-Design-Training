//file description : this code perform non restoring division algorithm

// Function to perform a left shift on A and Q
void leftShift(unsigned int * A, unsigned int * Q) {
    unsigned long long  temp = ((unsigned long long )(*A) << 32) | *Q;
    temp = temp << 1;
    *A = (unsigned int )((temp >> 32) & 0xFFFFFFFF);
    *Q = (unsigned int )(temp & 0xFFFFFFFF);
}

// Function to perform non-restoring division
void non_restoring_division(unsigned int  dividend, unsigned int  divisor, unsigned int  *quotient, unsigned int  *remainder) {
    unsigned int  A = 0; 
    unsigned int  Q = dividend; 
    unsigned int  M = divisor; 
    int N = 8 * sizeof(unsigned int );
    
    for (int i = 0; i < N; i++) {
        leftShift(&A, &Q);
        
        if ((A & 0x80000000) == 0x80000000) { // If A is negative
            A = A + M;
        } else { 
            A = A - M;
        }

        if ((A & 0x80000000) == 0x80000000) {
            Q = Q & (0xfffffffe);
        } else {
            Q = Q | 1;
        }

    }
    //last check on msb    
    if ((A & 0x80000000) == 0x80000000) { 
        A = A + M;    
    }
    
    *quotient = Q;
    *remainder = A;
}

int main() {
    unsigned int  dividend = 6;
    unsigned int  divisor = 2;
    unsigned int  quotient, remainder;
    non_restoring_division(dividend, divisor, &quotient, &remainder);
    return 0;
}
