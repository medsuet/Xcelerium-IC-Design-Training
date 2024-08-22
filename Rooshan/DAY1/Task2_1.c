#include <stdio.h>
#include <stdlib.h>

int main() {
    int Num1,Num2;
    printf("Enter Two numbers\n");
    scanf("%d %d",&Num1,&Num2);
    printf("%d+%d=%d\n",Num1,Num2,Num1+Num2);
    printf("%d-%d=%d\n",Num1,Num2,Num1-Num2);
    printf("%d*%d=%d\n",Num1,Num2,Num1*Num2);
    if (Num2!=0){
        printf("%d/%d=%f\n",Num1,Num2,(float)(Num1)/(float)(Num2));
    }
    else{
        printf("%d/%d==Undefined",Num1,Num2);
    }
    printf("(%d) % (%d)=%d\n",Num1,Num2,Num1%Num2);
}
