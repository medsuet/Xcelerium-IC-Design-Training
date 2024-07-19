#include <stdio.h>
#include <math.h>
unsigned int BitChecking_31=(1<<31);
unsigned int one=1;
void Restoring_Division(unsigned int Dividend,unsigned int Divisor);
int main(){
    //Test case 1 Dividend>Divisor
    printf("Test case 1: Dividend>Divisor\n");
    unsigned int Dividend1=113;
    unsigned int Divisor1=100;
    Restoring_Division(Dividend1,Divisor1);
    //Test case 2 Dividend<Divisor
    printf("Test case 2: Dividend<Divisor\n");
    unsigned int Dividend2=49;
    unsigned int Divisor2=100;
    Restoring_Division(Dividend2,Divisor2);
    //Test case 3 Dividend=Divisor
    printf("Test case 3: Dividend=Divisor\n");
    unsigned int Dividend3=49;
    unsigned int Divisor3=49;
    Restoring_Division(Dividend3,Divisor3);
    //Test case 4 Divisor=0
    printf("Test case 4: Divisor=0\n");
    unsigned int Dividend4=49;
    unsigned int Divisor4=0;
    Restoring_Division(Dividend4,Divisor4);
}
void Restoring_Division(unsigned int Dividend,unsigned int Divisor){
    unsigned int BitsChecking_1_to_31=~one;
    unsigned int Q=Dividend;
    unsigned int M=Divisor;
    unsigned int A=0;
    unsigned int A_res=0;
    int N=32;
    while(N!=0){
        if ((A&BitChecking_31)!=0){
            A=A<<1;
            if ((Q&BitChecking_31)!=0){
                A=(A|one);
            }
            else{
                A=(A&(~one)); 
            }
            Q=Q<<1;
            A=A+M;
        }
        else{
            A=A<<1;
            if ((Q&BitChecking_31)!=0){
                A=(A|one);
            }
            else{
                A=(A&(~one)); 
            }
            Q=Q<<1;
            A=A-M;
        }
        if ((A&BitChecking_31)!=0){
            Q=(Q&BitsChecking_1_to_31);
        }
        else{
            Q=(Q|one);
        }
        N=N-1;
    }
    while ((A&BitChecking_31)!=0){
        A=A+M;
    }
    if (Q!=4294967295){
        printf("Quotient = %u\n",Q);
        printf("Remainder = %u\n",A);
    }
    else{
        printf("DIVISION BY ZERO");
    }
}
