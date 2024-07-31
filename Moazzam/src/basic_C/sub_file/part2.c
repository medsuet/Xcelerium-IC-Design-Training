#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int main() {
    int x,y;
    char operation;

    //inputs
    printf("which Operation do you want to do: ");
    scanf("%c", &operation);
    printf("Enter 1st Number: ");
    scanf("%d", &x);
    printf("Enter 2nd Number: ");
    scanf("%d", &y);
    
    //part1
    printf("Addition of number is:       %d\n", x+y);
    printf("Subtraction of number is:    %d\n", x-y);
    printf("Multiplication of number is: %d\n", x*y);
    printf("Division of number is:       %d\n", x/y);
    printf("\n");

    //part2
    switch (operation)
    {
    case '+':
        printf("Addition of number is:       %d\n", x+y);
        break;

    case '-':
        printf("Subtraction of number is:    %d\n", x-y);
        break;

    case '*':
        printf("Multiplication of number is: %d\n", x*y);
        break;

    case '/':
        printf("Division of number is:       %d\n", x/y);
        break;
    
    default:
        printf("input operation is invalide.\n");
        break;
    }
    return 0;
}
