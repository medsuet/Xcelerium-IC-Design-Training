#include <stdio.h>
#include <stdlib.h>

int main() {
    int Num1,Num2;
    char Operator;
    printf("Enter Two numbers\n");
    scanf("%d %d",&Num1,&Num2);
    printf("Enter operator(+,_,*,/,percent sign):\n");
    scanf(" %c",&Operator);
    switch (Operator){
        case '+':
            printf("%d %c %d=%d\n",Num1,Operator,Num2,Num1+Num2);
            break;
        case '-':
            printf("%d %c %d=%d\n",Num1,Operator,Num2,Num1-Num2);
            break;
        case '*':
            printf("%d %c %d=%d\n",Num1,Operator,Num2,Num1*Num2);
            break;
        case '/':
            if (Num2!=0){
                printf("%d %c %d=%f\n",Num1,Operator,Num2,(float)(Num1)/(float)(Num2));
            }
            else{
                printf("%d %c %d==Undefined",Num1,Operator,Num2);
            }
            break;
        case '%':
            printf("(%d) %c (%d)=%d\n",Num1,Operator,Num2,Num1%Num2);
            break;
    }
}
