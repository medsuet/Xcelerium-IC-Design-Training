#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // Declare variables of different types and print their sizes
    int a;
    char b;
    double c;
    float d;
    printf("The size of integer is %ld\n", sizeof(a));
    printf("The size of character is %ld\n", sizeof(b));
    printf("The size of double is %ld\n", sizeof(c));
    printf("The size of float is %ld\n", sizeof(d));
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // Implement a simple calculator using switch statement
    float a, b;
    char operator;
    float result;
    printf("Simple Calculator \n");
    
    printf("Enter the first operand: ");
    scanf("%f", &a);

    printf("Enter the second operand: ");
    scanf("%f", &b);

    printf("Enter the operation which you want to perform: \n '+' for addition\n, '-' for subtraction\n, '*' for multiplication\n, '/' for division\n ");
    scanf(" %s", &operator);
    
    switch (operator)
    {
    case '+':
        result = (float) a + b;
        printf("The result of addition as %f+%f is %f\n", a, b, result);
        break;
    
    case '-':
        result = (float) a - b;
        printf("The result of subtraction as %f-%f is %f\n", a, b, result);
        break;
    
    case '*':
        result = (float) a * b;
        printf("The result of multiplication as %f*%f is %f\n", a, b, result);
        break;
    
    case '/':
        result = (float) a / b;
        printf("The result of division as %f/%f is %f\n", a, b, result);
        break;
    
    default:
        printf("Invalid Operator or Operands\n");
        break;
    }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // Print Fibonacci sequence up to n terms
    int result[100];
    printf("The Fibonacci sequence up to %d terms are: \n", n);
    result[0] = 0;
    result[1] = 1;
    printf("%d, %d, ", result[0], result[1]);
    for (int i = 2; i < n; i++) {
        result[i] = result[i - 2] + result[i - 1];
        if (i == n - 1)
            printf("%d", result[i]);
        else 
            printf("%d, ", result[i]);
    }
    printf("\n");
}

void guessingGame() {
    // Implement a number guessing game
    int guessnum;
    int guesses = 10;
    char permit;
    int randnum = (rand() % 101);
    printf("-------------------------------------------------------------------------\n");
    printf("Welcome to the NUMBER GUESSING GAME\n");
    printf("I have a number between 0 and 100. Guess!\n");
    printf("You have to complete the game in %d guesses.\n", guesses);
    while (guesses > 0) {
        printf("Enter your guess: ");
        scanf("%d", &guessnum); 
        guesses--;
        if (guessnum > randnum) {
            printf("Your guess is larger than the original number.\n");
            printf("You have %d guesses left!\n", guesses);
        } else if (guessnum < randnum) {
            printf("Your guess is smaller than the original number.\n");
            printf("You have %d guesses left!\n", guesses);
        } else if (guessnum == randnum) {
            printf("Congratulations! You won the game. Also, you have %d guesses left!.\n", guesses);
            printf("-------------------------------------------------------------------------\n");
            printf("Do you want to play the game again? [Y/n] ");
            scanf(" %s", &permit);
            if (permit == 'y' || permit == 'Y') {
                guessingGame();  // Restart the game
            } else {
                printf("Good Bye! See you again.\n");
            }
            return;
        }
    }
    printf("Alas! You lose the game.\n ");
    printf("-------------------------------------------------------------------------\n\n");
    printf("Do you want to play the game again? [Y/n] ");
    scanf(" %c", &permit);
    if (permit == 'y' || permit == 'Y') {
        guessingGame();  // Restart the game
    } else {
        printf("Good Bye! See you again.\n");
    }
}

// 0.4 Functions
int isPrime(int num) {
    // Check if a number is prime
    if (num <= 1) return 0;  // Numbers less than or equal to 1 are not prime
    for (int i = 2; i <= num / 2; i++) {
        if (num % i == 0) 
            return 0;  // Not prime if divisible by any number other than 1 and itself
    }
    return 1;  // Prime number
}

int factorial(int n) {
    // Calculate factorial recursively
    if (n == 0 || n == 1)
        return 1;
    else
        return n * factorial(n - 1);
}

// 0.5 Arrays and Strings
void reverseString(char *str) {
    // Reverse a string in-place
    int start = 0;
    int end = strlen(str) - 1; // Get the length of the string and subtract 1 for the last index
    char temp;

    while (start < end) {
        // Swap the characters at start and end
        temp = str[start];
        str[start] = str[end];
        str[end] = temp;

        // Move the pointers towards each other
        start++;
        end--;
    }
}

int secondLargest(int arr[], int size) {
     // Find and return the second largest element in the array
    int large_ele = arr[0];
-   int prev_ele;
-   for (int i = 0; i < size - 1; i++){
-       if (large_ele < arr[i + 1]){
-           prev_ele = large_ele;
-           large_ele = arr[i + 1];
    return prev_ele;
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

    // Parts 1-4: Advanced Pointer Concepts
    printf("\nAdvanced Pointer Concepts\n");
    // TODO: Implement and call functions for Parts 1-4 as in the previous template

    return 0;
}

