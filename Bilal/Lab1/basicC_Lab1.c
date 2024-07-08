#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define INT_MIN 0

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
    int intVar;
    float floatVar;
    double doubleVar;
    char charVar;

    printf("Size of int: %lu bytes\n", sizeof(intVar));
    printf("Size of float: %lu bytes\n", sizeof(floatVar));
    printf("Size of double: %lu bytes\n", sizeof(doubleVar));
    printf("Size of char: %lu byte\n", sizeof(charVar));

    // Type casting examples
    floatVar = 10.5;
    intVar = (int) floatVar;
    printf("After type casting, intVar: %d\n", intVar);
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement
    double num1, num2;
    char op;

    printf("Enter two numbers: ");
    scanf("%lf %lf", &num1, &num2);
    printf("Enter an operator (+, -, *, /, %%): ");
    scanf(" %c", &op);

    switch (op) {
        case '+':
            printf("Result: %lf\n", num1 + num2);
            break;
        case '-':
            printf("Result: %lf\n", num1 - num2);
            break;
        case '*':
            printf("Result: %lf\n", num1 * num2);
            break;
        case '/':
            if (num2 != 0)
                printf("Result: %lf\n", num1 / num2);
            else
                printf("Error: Division by zero\n");
            break;
        case '%':
            if ((long long) num2 == 0)
                printf("Error: Modulus by zero\n");
            else
                printf("Result: %lld\n", (long long) num1 % (long long) num2);
            break;
        default:
            printf("Error: Invalid operator\n");
    }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // TODO: Print Fibonacci sequence up to n terms
    int term1 = 0, term2 = 1, nextTerm;

    printf("Fibonacci Series: ");
    for (int i = 1; i <= n; ++i) {
        printf("%d, ", term1);
        nextTerm = term1 + term2;
        term1 = term2;
        term2 = nextTerm;
    }
    printf("\n");
}

void guessingGame() {
    // TODO: Implement a number guessing game
    int guess, number, attempts = 0;
    number = rand() % 100 + 1;

    printf("Guess the number (between 1 and 100): ");

    do {
        scanf("%d", &guess);
        attempts++;

        if (guess > number)
            printf("Lower!\n");
        else if (guess < number)
            printf("Higher!\n");
        else
            printf("Congratulations! You guessed it in %d attempts.\n", attempts);

    } while (guess != number);
}

// 0.4 Functions
int isPrime(int num) {
    // TODO: Check if a number is prime
    if (num <= 1) return 0;  // 0 and 1 are not prime numbers

    for (int i = 2; i * i <= num; ++i) {
        if (num % i == 0)
            return 0;  // not a prime number
    }
    return 1;  // prime number
}

int factorial(int n) {
    // TODO: Calculate factorial recursively
    if ((n == 0) || (n == 1))
        return 1;
    else
        return n * factorial(n - 1);
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    // TODO: Reverse a string in-place
    int length = strlen(str);
    for (int i = 0; i < length / 2; ++i) {
        char temp = str[i];
        str[i] = str[length - i - 1];
        str[length - i - 1] = temp;
    }
}

int secondLargest(int arr[], int size) {
    // TODO: Find and return the second largest element in the array
    if (size < 2) {
        printf("Array size should be at least 2.\n");
        return 0;
    }

    int first, second;
    first = second = 0;

    for (int i = 0; i < size; ++i) {
        if (arr[i] > first) {
            second = first;
            first = arr[i];
        } else if (arr[i] > second && arr[i] != first) {
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
