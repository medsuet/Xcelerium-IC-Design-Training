
//Task 0.2 Operators and Expressions
//part(a)
#include<stdio.h>

int main() {
    int x;
    int y;
    printf("Enter two numbers: ");
    scanf("%d %d", &x, &y);

    int sum = x + y;
    int sub = x - y;
    int mul = x * y;
    float div = (float)x / y; // Typecasting to float for accurate division result
    int mod = x % y;

    printf("Addition of %d and %d is: %d\n", x, y, sum);
    printf("Subtraction of %d and %d is: %d\n", x, y, sub);
    printf("Multiplication of %d and %d is: %d\n", x, y, mul);
    printf("Division of %d and %d is: %.2f\n", x, y, div); // Displaying float result with two decimal places
    printf("Modulo of %d and %d is: %d\n", x, y, mod);

    return 0;
}

//part(b)

#include <stdio.h>

int main() {
    int x, y, choice;
    printf("Enter two numbers: ");
    scanf("%d %d", &x, &y);
    printf("Enter your choice: ");
    scanf("%d", &choice);

    switch (choice)
    {
    case 1:
        printf("Addition of %d and %d is: %d\n", x, y, x + y);
        break;
    case 2:
        printf("Subtraction  of %d and %d is: %d\n", x, y, x - y);
        break;
    case 3:
        printf("Multiplication of %d and %d is: %d\n", x, y, x * y);
        break;
    case 4:
        if(y!=0)
        {
            printf("Division of %d and %d is: %f\n", x, y, (float)x/y);
        }
        else
        {
            printf("Cannot divide by zero.\n");
        }
    
    
    default:
        printf("Invalid Choice.\n");
        break;
    }
    return 0;
}

