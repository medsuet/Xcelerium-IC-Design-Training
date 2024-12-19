#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void say_hello();
void f2_f();

int main() {
    int x,y;
    //char operation;
    x = 6;
    y = 9;

    //inputs
    //printf("which Operation do you want to do: ");
    //scanf("%c", &operation);
    //printf("Enter 1st Number: ");
    //scanf("%d", &x);
    //printf("Enter 2nd Number: ");
    //scanf("%d", &y);
    
    //part1
    printf("Addition of number is:       %d\n", x+y);
    printf("Subtraction of number is:    %d\n", x-y);
    printf("Multiplication of number is: %d\n", x*y);
    printf("Division of number is:       %d\n", x/y);
    printf("\n");
    say_hello();

    f2_f();

    return 0;
}
