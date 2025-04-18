#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
void  shiftLeft(int *A, int *Q){
 int64_t combined = ((int64_t)*A<<32) | (uint32_t)*Q;
 combined = combined<<1;
 *A = (combined >>32) & 0xFFFFFFFF;
 *Q =  combined & 0xFFFFFFFF;
}
void divisionAlgorithm(int dividend, int divisor, int *quotient, int *remainder){
   
	int N = 32;
	int A = 0;
	int M = divisor;
	int Q = dividend;
    while(N!=0){
	shiftLeft(&A,&Q);    

	if(A<0) A = A+M;
	else A =A-M;    	

        if(A<0)  Q &= ~1;
	else Q |= 1;

        N=N-1;
   }	
   if(A<0) A =A+M;
   
     *quotient = Q;
     *remainder = A;
   
}

int main(){
int quotient;
int remainder;
divisionAlgorithm(5,2,&quotient, &remainder);
printf("quorient is %d and remainder is %d\n", quotient,remainder);

return 0;
}
