#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    int i;
    float f;
    double d;
    char c;

    printf("Size of int: %zu bytes\n", sizeof(i));
    printf("Size of float: %zu bytes\n", sizeof(f));
    printf("Size of double: %zu bytes\n", sizeof(d));
    printf("Size of char: %zu bytes\n", sizeof(c));

    // Demonstrating type casting
    f = (float) i; // int to float
    d = (double) f; // float to double
    i = (int) d; // double to int
    c = (char) i; // int to char

    printf("After type casting:\n");
    printf("Float value: %f\n", f);
    printf("Double value: %lf\n", d);
    printf("Int value: %d\n", i);
    printf("Char value: %c\n", c);
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    double num1, num2;
    char operator;

    printf("Enter two numbers: ");
    scanf("%lf %lf", &num1, &num2);

    printf("Enter an operator (+, -, *, /): ");
    scanf(" %c", &operator);

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
            if (num2 != 0) {
                printf("%.2lf / %.2lf = %.2lf\n", num1, num2, num1 / num2);
            } else {
                printf("Error: Division by zero is not allowed.\n");
            }
            break;
        case '%':
            if ((int)num2 != 0) {
                printf("%d %% %d = %d\n", (int)num1, (int)num2, (int)num1 % (int)num2);
            } else {
                printf("Error: Division by zero is not allowed.\n");
            }
            break;
        default:
            printf("Invalid operator.\n");
            break;
    }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    int a = 0, b = 1, next;
    for (int i = 1; i <= n; ++i) {
        printf("%d ", a);
        next = a + b;
        a = b;
        b = next;
    }
    printf("\n");
}

void guessingGame() {
    int number, guess;
    const int MAX_ATTEMPTS = 10;

    number = rand() % 100 + 1; // Random number between 1 and 100

    printf("Guess the number between 1 and 100 (You have %d attempts):\n", MAX_ATTEMPTS);

    for (int attempts = 0; attempts < MAX_ATTEMPTS; ++attempts) {
        printf("Attempt %d: ", attempts + 1);
        scanf("%d", &guess);

        if (guess == number) {
            printf("Congratulations! You guessed the correct number.\n");
            return;
        } else if (guess < number) {
            printf("Higher\n");
        } else {
            printf("Lower\n");
        }
    }

    printf("Sorry, you've used all your attempts. The number was %d.\n", number);
}

// 0.4 Functions
int isPrime(int num) {
    if (num <= 1) return 0;
    for (int i = 2; i * i <= num; ++i) {
        if (num % i == 0) return 0;
    }
    return 1;
}

int factorial(int n) {
    if (n == 0) return 1;
    return n * factorial(n - 1);
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; ++i) {
        char temp = str[i];
        str[i] = str[len - 1 - i];
        str[len - 1 - i] = temp;
    }
}

int secondLargest(int arr[], int size) {
    int largest = arr[0], second = -1;

    for (int i = 1; i < size; ++i) {
        if (arr[i] > largest) {
            second = largest;
            largest = arr[i];
        } else if (arr[i] > second && arr[i] != largest) {
            second = arr[i];
        }
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

    int arr[] = {5, 2, 8, 1, 9, 3, 7};
    int size = sizeof(arr) / sizeof(arr[0]);
    printf("Second largest element: %d\n", secondLargest(arr, size));

    return 0;
}
