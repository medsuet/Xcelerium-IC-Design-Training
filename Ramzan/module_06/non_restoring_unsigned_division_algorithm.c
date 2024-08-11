#include<stdio.h>

void leftshif( int *A, int *Q)
{
    *A = (*A << 1) | ((*Q >> 31)&1);
    *Q = (*Q << 1);
}
void nonRestoringDivision( int dividend,int divisor,int *quotient, int *remainder)
{
    int A = 0;
    int n = 32;
    int M = divisor;
    int Q = dividend;
    int signA;
    for(int i = 0;i<n;i++)
    {
        signA = ((A >> 31) & 1);
        if ( signA == 1 )
        {
            leftshif( &A,&Q );
            A = A + M;
        }
        else if ( signA == 0 )
        {
            leftshif( &A,&Q );
            A = A - M;
        }
        //now I want to agin check sign bit of A
        signA = (( A>>31 ) & 1);

        if ( signA == 1)
        {
            Q = ( Q & ~1 ) | 0; //this shows that Q[0]=0
        }
        else if( signA == 0 )
        {
            Q = ( Q & ~1) | 1; //this shows that Q[1]=1
        }
    }
        n = n-1;
    if ( signA == 1)
    {
        A = A + M;

    }
    *quotient = Q;
    *remainder = A;
}
int main()
{
    int dividend;
    int divisor;
    int quotient;
    int remainder;
    printf("Enter a dividend:");
    scanf("%d",&dividend);
    printf("Enter a divisor:");
    scanf("%d",&divisor);
    nonRestoringDivision( dividend,divisor,&quotient, &remainder);
    printf("Quotient: %d\n", quotient);
    printf("Remainder: %d\n", remainder);
    return 0;
}