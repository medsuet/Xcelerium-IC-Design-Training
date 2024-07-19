
#include<stdio.h>
int leftshift(int *A, int *Q)
{
    *A = ((*A<<1) | (*Q >> 31) &1);
    *Q = (*Q<<1);
}

void restoringDivision(int dividend,int divisor, int *quotient, int *reminder)
{
    if (divisor == 0) {
        printf("Error: Division by zero!\n");
        return;
    }
    int A = 0;
    int n = 32;
    int Q = dividend;
    int M = divisor;
    for(int i = 0;i<n;i++)
    {
        leftshift(&A,&Q);
        A = A - M;

        //now i want to check MSB bit of A
        int msbA = ((A>>31) & 1);
        if(msbA==1)
        {
            Q = (Q & ~1) | 0; //Q[0] = 0
            A = A + M;
        }
        else if(msbA ==0)
        {
            Q = (Q & ~1) | 1; //Q[1] = 1
        }
    }
    *quotient = Q; 
    *reminder = A;
}
int main()
{
    int dividend = 9;
    int divisor = 4;
    int quotient;
    int reminder;
    restoringDivision(dividend,divisor, &quotient,&reminder);
    printf("Quotient: %d\n", quotient);
    printf("Remainder: %d\n", reminder);
    return 0;
}