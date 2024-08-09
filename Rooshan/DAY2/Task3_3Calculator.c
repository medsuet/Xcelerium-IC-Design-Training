#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int add(int a,int b);
int subtract(int a,int b);
int multiply(int a,int b);
float divide(int a,int b);
int main() {
    int num1,num2;
    char Operator;
    printf("Enter the two numbers: ");
    scanf("%d %d",&num1,&num2);
    printf("Enter the operator(+,-,*,/)");
    scanf(" %c",&Operator);
    int (* add_ptr)(int,int)=&add;
    int (* subtract_ptr)(int,int)=&subtract;
    int (* multiply_ptr)(int,int)=&multiply;
    float (* divide_ptr)(int,int)=&divide;
    switch (Operator){
        case '+':
            printf("%d + %d = %d",num1,num2,add_ptr(num1,num2));
        case '-':
            printf("%d - %d = %d",num1,num2,subtract_ptr(num1,num2));
        case '*':
            printf("%d * %d = %d",num1,num2,multiply_ptr(num1,num2));
        case '/':
            printf("%d / %d = %f",num1,num2,divide_ptr(num1,num2));
    }
}
int add(int a,int b){return a+b;}
int subtract(int a,int b){return a-b;}
int multiply(int a,int b){return a*b;}
float divide(int a,int b){return b!=0?(float)a/(float)b:0;}
