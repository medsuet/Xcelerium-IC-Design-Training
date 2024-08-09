#include <stdio.h>
#include <stdlib.h>
int factorial(int num);
int main() {
    int number;
    printf("Enter a number:\n");
    scanf("%d",&number);
    printf("Factorial of %d=%d",number,factorial(number));
}
int factorial(int num){
    if (num==0||num==1){
        return 1;
    }
    else{
        return (num*factorial(num-1));
    }
}
