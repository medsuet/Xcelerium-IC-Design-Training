/*
#  ============================================================================
#  Filename:    divison.c 
#  Description: File consists of code for restoring division algorithm
#  Author:      Bisal Saeed
#  Date:        7/15/2024
#  ============================================================================
*/
#include <stdio.h>
#include <stdlib.h>

void printBits(int *num){
    for (int i = sizeof(int)*8 -1 ; i>=0;i-- ){
        printf("%d", (*num >> i) & 1);
    }
    printf("\n");
}

void addBits(int *A, int *M, int n) {
    *A+=*M;
     printf("negM in add: "); 
    printBits(M);
}

void twosComplement(int *M, int n) {
    *M=~(*M);
    int one=1;
    addBits(M, &one , n);
}

void shiftValue(int *A, int *Q, int n) {
    int lsbQ=0;
    int msbQ=((*Q >> n-1) & 1);
    *Q=(*Q << 1 ) | (lsbQ);
    printf("MSB of Q: %d\n",msbQ);
    *A=(*A << 1) | (msbQ);
}

int correcting_Q(int *Q,int n){
    *Q=*Q <<(32-n);
    int answer=(*A >>(32-n)) | 0;
    return answer;
}

void division(int dividend, int divisor) {
    int n=4;
    int flag_sign=0;
    if ((dividend<0 && divisor>0) || (dividend>0 && divisor<0)){
        flag_sign=1;
    }
    else if (((dividend<0)&&(divisor<0))|| ((dividend>0 && divisor>0))){
        flag_sign=0;
    }

    int A=0;
    int Q = (dividend<0)? -dividend : dividend;
    int M= (divisor<0)? -divisor : divisor;
    int negM = M;
    int count = n;
    while (count > 0) {
        shiftValue(&A,&Q,n);
        int tempA=A;
        A-=M;
        printf("A after A<-A-M : "); 
        printBits(&A);
        int msbA=(A >> (n-1)) & 1 ;
        printf("MSB of A: %d\n",msbA);
        int lsbQ=Q;
        if (msbA == 1) {
            A=tempA;
        }
         else {
            printf("A=0 CONDITION\n");
            Q=Q | 1;
        }
        printf("A after shift : "); 
        printBits(&A);
        printf("Q after shift : "); 
        printBits(&Q);
        printf("M after shift : "); 
        printBits(&negM);
        count--;
    }
    int quotient=correcting_Q(Q,n);
    int remainder=A;
    if (flag_sign==1){
        quotient=-quotient;
        remainder=remainder;
    }
    else if (flag_sign==0){
        quotient=quotient;
        remainder=remainder;
    }
    else{
        quotient=0;
        remainder=0;
    }
    printf("Quotient is given as : %d\n", quotient);
    printf("Remainder is given as : %d\n", remainder);
}

int main() {
    int num1, num2;
    int num1=(rand()%100)+1;
    int num2=(rand()%100+1);
    printf("Enter the first number: %d",num1);
    printf("Enter the first number: %d",num2);
    division(num1, num2);
    if (originalQuotient == quotient){
        printf("PASSED..");
    }
    if (originalRemainder == remainder){
        printf("PASSED..");
    }
    return 0;
}
