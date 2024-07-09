#include<stdio.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

#define RANGE 1073741823
void RIGHTSHIFTFUNC(signed int *num1,unsigned *num2, int my_shift)
{
     printf("num1=%d,num2=%d\n",*num1,*num2);
     int64_t RIGHTSHIFT = ((int64_t)*num1 <<32) | (uint32_t)*num2;
     my_shift = my_shift % 64;

     printf("New_num %lu\n",RIGHTSHIFT);
     RIGHTSHIFT = RIGHTSHIFT >> my_shift;
     printf("right num %lu\n",RIGHTSHIFT);
     *num1 = ((int)(RIGHTSHIFT >> 32) & 0xFFFFFFFF);
     *num2 = (int)(RIGHTSHIFT & 0xFFFFFFFF);

}

int64_t BOOTHMULTIPLIER( int M,int Q)
{
     char number_size = sizeof(M) * 8;//it gives me size of number in bits
     char Qn;
     Qn = Q&1;//this will give LSB bit of Q
     char Qn1 = 0;
     int AC=0;
     char SC = number_size;//sequence counter
     printf("ok\n");
     printf("Q=%d,AC=%d\n",Q,AC);

     while(1)
     {    //printf("SC = %d\n", SC);
          if((Qn == 0 & Qn1==0) | (Qn == 1 & Qn1 == 1))
          {
               //perform rifgt shift
               printf("111num1=%d,num2=%d\n",AC,Q);
               RIGHTSHIFTFUNC(&AC,&Q,1);
               printf("a111num1=%d,num2=%d\n",AC,Q);
               SC--;
          }
          else if(Qn==1 & Qn1==0)
          {
               AC = AC-M;
               printf("222num1=%d,num2=%d\n",AC,Q);
               RIGHTSHIFTFUNC(&AC,&Q,1);
               printf("a222num1=%d,num2=%d\n",AC,Q);
               SC--;
          }
          else if(Qn==0 & Qn1==1)
          {
               AC = AC+M;
               printf("333num1=%d,num2=%d\n",AC,Q);
               RIGHTSHIFTFUNC(&AC,&Q,1);
               printf("a333num1=%d,num2=%d\n",AC,Q);
               SC--;
          }
          if(SC==0)
          {
               break;
          }
          else{
               Qn1 = Qn;
               Qn = Q &1;
          }
     }
     printf("Q=%d,AC=%d\n",Q,AC);
     int64_t my_product = ((int64_t)AC<<32) | (uint32_t)Q;
     return my_product;
}   

void CHECKFUNNCTION(int test_cases)
{
     int pass_test = 0;
    // int test_number = test_cases;
     while(test_cases)
     {
          int n1 = (rand() % (2 * RANGE + 1)) - RANGE;
          int n2 = (rand() % (2 * RANGE + 1)) - RANGE;
          int64_t booth_test_result = BOOTHMULTIPLIER(n1,n2);
          int64_t simple_test_result = (int64_t)n1 * (int64_t)n2;
          if(booth_test_result == simple_test_result )
          {
               pass_test++;
          }
          else
          {
               printf("Booth Multiplication Algorithm failed!\n");
               printf("Booth Multiplier Results: n1 %d * n2 %d =  %ld \n", n1, n2, booth_test_result);
               printf("Simple Multiplier Results: n1 %d * n2 %d =  %ld \n", n1, n2, simple_test_result);
               break;
          }
          test_cases--;

     }
     //printf("Total Pass Test: %d, Passed Failed Test: %d\n",test_cases, pass_test);
}

int main()
{
     srand(time(NULL));
     int multiplier;
     int multiplicant;
     int test_cases = 0;
     printf("Enter an multiplier Integer:");
     scanf("%d",&multiplier);
     printf("Enter an multplicant Integer:");
     scanf("%d",&multiplicant);
     //printf("Enter number of test cases:");
     //scanf("%d",&test_cases);

     printf("the Product of %d and %d is equal to %ld\n",multiplier,multiplicant,BOOTHMULTIPLIER(multiplicant, multiplier));
     CHECKFUNNCTION(test_cases);
     return 0;

}
