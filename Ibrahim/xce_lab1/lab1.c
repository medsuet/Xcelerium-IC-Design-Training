#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // Declare variables of different data types
    int i = 10;
    float f = 5.5;
    double d = 15.55;
    char c = 'A';

    // Print the sizes of each data type
    printf("Size of int: %zu bytes\n", sizeof(i));
    printf("Size of float: %zu bytes\n", sizeof(f));
    printf("Size of double: %zu bytes\n", sizeof(d));
    printf("Size of char: %zu bytes\n", sizeof(c));

    // Demonstrate type casting
    // Cast int to float
    float intToFloat = (float)i;
    printf("int to float: %f\n", intToFloat);

    // Cast float to int
    int floatToInt = (int)f;
    printf("float to int: %d\n", floatToInt);

    // Cast double to int
    int doubleToInt = (int)d;
    printf("double to int: %d\n", doubleToInt);

    // Cast char to int
    int charToInt = (int)c;
    printf("char to int: %d\n", charToInt);

    // Cast int to char
    char intToChar = (char)i;
    printf("int to char: %c\n", intToChar);
    // TODO: Declare variables of different types and print their sizes
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    char operator;
    double num1, num2, result;

    // Take user input for the operator and numbers
    printf("Enter an operator (+, -, *, /): ");
    scanf(" %c", &operator);

    printf("Enter two numbers: ");
    scanf("%lf %lf", &num1, &num2);

    // Perform the operation based on the operator
    switch (operator) {
        case '+':
            result = num1 + num2;
            printf("%.2lf + %.2lf = %.2lf\n", num1, num2, result);
            break;
        case '-':
            result = num1 - num2;
            printf("%.2lf - %.2lf = %.2lf\n", num1, num2, result);
            break;
        case '*':
            result = num1 * num2;
            printf("%.2lf * %.2lf = %.2lf\n", num1, num2, result);
            break;
        case '/':
            if (num2 != 0) {
                result = num1 / num2;
                printf("%.2lf / %.2lf = %.2lf\n", num1, num2, result);
            } else {
                printf("Error! Division by zero.\n");
            }
            break;
        case '%':
            // For modulo operation, both numbers need to be integers
            if ((int)num2 != 0) {
                result = (int)num1 % (int)num2;
                printf("%d %% %d = %d\n", (int)num1, (int)num2, (int)result);
            } else {
                printf("Error! Division by zero.\n");
            }
            break;
        default:
            printf("Error! Operator is not correct\n");
            break;
    }
    // TODO: Implement a simple calculator using switch statement
}

// 0.3 Control Structures
void printFibonacci(int n) {
    int t1 = 0, t2 = 1, nextTerm;

    // Get the number of terms from the user
    printf("Enter the number of terms: ");
    scanf("%d", &n);

    printf("Fibonacci Sequence: ");

    for (int i = 1; i <= n; ++i) {
        printf("%d, ", t1);
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
    }
    printf("\n");
    // TODO: Print Fibonacci sequence up to n terms
}

void guessingGame() {
    int number, guess, attempts = 0;
    
    // Seed the random number generator
    srand(time(0));
    number = rand() % 100 + 1; // Generates a random number between 1 and 100

    printf("Guess the number (between 1 and 100):\n");

    // Loop until the user guesses the number
    do {
        printf("Enter your guess: ");
        scanf("%d", &guess);
        attempts++;

        if (guess > number) {
            printf("Lower\n");
        } else if (guess < number) {
            printf("Higher\n");
        } else {
            printf("Congratulations! You guessed the number in %d attempts.\n", attempts);
        }
    } while (guess != number);
    // TODO: Implement a number guessing game
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

// Function to find the second largest element in array
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
    printf("The Prime numbers between 1 and 100 are:\n");
    for (int i = 1; i <= 100; i++) {
        if (isPrime(i)) {
            printf("%d ", i);
        }
    }
    printf("\n");

    printf("Factorial of 5 is: %d\n", factorial(5));

    // 0.5 Arrays and Strings
    char string[] = "Hello, World!";
    printf("Original string: %s\n", string);
    reverseString(str);
    printf("Reversed string: %s\n", string);

    // initialize an array of elements
    int arr[] = {5, 2, 8, 1, 9, 3, 7};
    int size = sizeof(arr) / sizeof(arr[0]);
    printf("Second largest element: %d\n", secondLargest(arr, size));

    // TODO: Implement and call functions for Parts 1-4 as in the previous template

    return 0;
}
