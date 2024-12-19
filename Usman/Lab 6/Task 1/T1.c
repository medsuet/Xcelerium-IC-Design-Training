

void shiftLeft(int *a, int *q) {
    long int combined = ((long)(*a) << 32) |(unsigned int) (*q);
    combined <<= 1;
    *a = (int)((combined >> 32) & 0xFFFFFFFF);
    *q = (int )(combined & 0xFFFFFFFF);
}

void restoringDivisionAlgorithm(int divisor, int dividend, int *quotient, int *remainder) {
    int N = 32; // Assuming 32-bit dividend and divisor
    int A = 0;
    int M = divisor;
    int Q = dividend;

    for (int n = N; n > 0; n--) {
        shiftLeft(&A, &Q);
        A = A - M;
        if (A < 0) {
            Q &= ~1; // Q[0] = 0
            A = A + M; // Restore A
        } else {
            Q |= 1; // Q[0] = 1
        }
    }

    *quotient = Q;
    *remainder = A;
}

int main() {
    int dividend = 5;
    int divisor = 2;
    int quotient=0;
    int  remainder=0;

    restoringDivisionAlgorithm(divisor, dividend, &quotient, &remainder);
//  printf("Quotient is %d and remainder is %d\n", quotient, remainder);

    return 0;
}

