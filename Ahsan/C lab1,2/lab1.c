#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
// printing differnet datatypes sizes and using typecasting
void printSizes() {
    int i;
    float f;
    double d;
    char c;

    printf("Size of int: %lu bytes\n", sizeof(i));
    printf("Size of float: %lu bytes\n", sizeof(f));
    printf("Size of double: %lu bytes\n", sizeof(d));
    printf("Size of char: %lu bytes\n", sizeof(c));

    // Demonstrate type casting
    i = 65;
    f = (float)i;
    d = (double)f;
    c = (char)i;

    printf("\nType casting:\n");
    printf("int i = %d\n", i);
    printf("float f = %.2f\n", f);
    printf("double d = %.2f\n", d);
    printf("char c = %c\n", c);
}

// 0.2 Operators and Expressions
//making simple calculator
void simpleCalculator() {
    char operator;
    double num1, num2;

    printf("Enter an operator (+, -, *, /, %%): ");
    scanf(" %c", &operator);
    printf("Enter two operands: ");
    scanf("%lf %lf", &num1, &num2);

    switch (operator) {
        case '+':
            printf("%.2lf + %.2lf = %.2lf\n", num1, num2, num1 + num2);
            break;
        case '-':
            printf("%.2lf - %.2lf = %.2lf\n", num1, num2, num1 - num2);
            break;
        case '*':
            printf("%.2lf * %.2lf = %.2lf\n", num1, num2, num1 * num2);
            break;
        case '/':
            if (num2 != 0)
                printf("%.2lf / %.2lf = %.2lf\n", num1, num2, num1 / num2);
            else
                printf("Error! Division by zero.\n");
            break;
        case '%':
            if ((int)num2 != 0)
                printf("%d %% %d = %d\n", (int)num1, (int)num2, (int)num1 % (int)num2);
            else
                printf("Error! Division by zero.\n");
            break;
        default:
            printf("Error! Operator is not correct.\n");
    }
}

// 0.3 Control Structures
//printing fibonacci series
void printFibonacci(int n) {
    int t1 = 0, t2 = 1, nextTerm;
    printf("Fibonacci Series: %d, %d, ", t1, t2);

    for (int i = 1; i <= n - 2; ++i) {
        nextTerm = t1 + t2;
        printf("%d, ", nextTerm);
        t1 = t2;
        t2 = nextTerm;
    }
    printf("\n");
}
// guessing game
void guessingGame() {
    int number, guess, attempts = 0;
    number = rand() % 100 + 1;  // random number between 1 and 100

    printf("Guess the number (1 to 100): ");
    do {
        scanf("%d", &guess);
        attempts++;
        if (guess > number)
            printf("Lower!\n");
        else if (guess < number)
            printf("Higher!\n");
        else
            printf("Congratulations! You guessed the number in %d attempts.\n", attempts);
    } while (guess != number);
}

// 0.4 Functions
int isPrime(int num) {
    if (num <= 1)
        return 0;
    for (int i = 2; i <= num / 2; i++) {
        if (num % i == 0)
            return 0;
    }
    return 1;
}

int factorial(int n) {
    if (n == 0)
        return 1;
    else
        return n * factorial(n - 1);
}

// 0.5 Arrays and Strings
//reversing the string
void reverseString(char* str) {
    int length = strlen(str);
    for (int i = 0; i < length / 2; i++) {
        char temp = str[i];
        str[i] = str[length - i - 1];
        str[length - i - 1] = temp;
    }
}

int secondLargest(int arr[], int size) {
    int second = 0;
    int largest= arr[0];
     for(int i =0;i <size;i++){
        if (arr[i] > largest)
            largest = arr[i];    
     }
     printf("%d\n",largest);
     for(int j =0; j<size;j++){
        if (arr[j] > second && arr[j]!=largest)
           second = arr[j];
     }
     return second;
}

int main() {
    srand(time(NULL));

    printf("Part 0: Quick Revision Exercises\n");

    // 0.1 Basic Syntax and Data Types
    printSizes();

    // 0.2 Operators and Expressions
    simpleCalculator();

    // 0.3 Control Structures
    int n;
    printf("Enter the number of Fibonacci terms to print: ");
    scanf("%d", &n);
    printFibonacci(n);

    guessingGame();

    // 0.4 Functions
    printf("Prime numbers between 1 and 100:\n");
    for (int i = 1; i <= 100; i++) {
        if (isPrime(i)) {
            printf("%d ", i);
        }
    }
    printf("\n");

    printf("Factorial of 5: %d\n", factorial(5));

    // 0.5 Arrays and Strings
    char str[] = "Hello, World!";
    printf("Original string: %s\n", str);
    reverseString(str);
    printf("Reversed string: %s\n", str);

    int arr[] = {99,12,17,44,77,54,5, 2, 8, 1, 9, 3, 7,10,12};
    int size = sizeof(arr) / sizeof(arr[0]);
    printf("Second largest element: %d\n", secondLargest(arr, size));

    return 0;
}
