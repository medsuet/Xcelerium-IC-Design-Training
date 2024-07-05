#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
    int a;
    float b;
    char c;
    double d;
    // Compute and print the size of each variable
    printf("Size of int datatype: %zu bytes\n", sizeof(a));
    printf("Size of float datatype: %zu bytes\n", sizeof(b));
    printf("Size of char datatype: %zu bytes\n", sizeof(c));
    printf("Size of double datatype: %zu byte\n", sizeof(d));
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement
    int number1, number2;
    char operation;

    printf("Enter two numbers: ");
    scanf("%d %d", &number1, &number2);

    printf("Enter an operator: ");
    scanf(" %c", &operation);

    switch (operation) {
        case '+':
            printf("%d + %d = %d\n", number1, number2, number1 + number2);
            break;
        case '-':
            printf("%d - %d = %d\n", number1, number2, number1 - number2);
            break;
        case '*':
            printf("%d * %d = %d\n", number1, number2, number1 * number2);
            break;
        case '/':
            if (b != 0)
                printf("%d / %d = %d\n", number1, number2, number1 / number2);
            else
                printf("undefine.\n");
            break;
        case '%':
            if (number2 != 0)
                printf("%d %% %d = %d\n", number1, number2, number1 % number2);
            else
                printf("undefine.\n");
            break;
        default:
            printf("Invalid operator\n");
    }
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // TODO: Print Fibonacci sequence up to n terms
    int firstElement = 0, secondElement = 1, nextTerm;
    printf("Fibonacci Series: ");
    for (int i = 1; i <= n; ++i) {
        printf("%d, ", firstElement);
        nextTerm = firstElement + secondElement;
        firstElement = secondElement;
        secondElement = nextTerm;
    }
    printf("\n");
}

void guessingGame() {
    // TODO: Implement a number guessing game
    // Generate a random number between 1 and 100
    int randomNumber = rand() % 101;
    int guess = 0;
    int attempts = 0;

    // Loop until the user guesses the correct number
    while (guess != randomNumber) {
        printf("Enter your guess: ");
        scanf("%d", &guess);
        attempts++;

        if (guess > randomNumber) {
            printf("Try lower\n");
        } else if (guess < randomNumber) {
            printf("Try higher\n");
        } else {
            printf("Congratulations! You guessed the correct number %d in %d attempts.\n", randomNumber, attempts);
        }
    }
}
    
// 0.4 Functions
int isPrime(int number) {
    // TODO: Check if a number is prime
    if (number <= 1) return 0;
    for (int i = 2; i <= number / 2; i++) {
        if (number % i == 0) return 0;
    }
    return 1;
}

int factorial(int n) {
    // TODO: Calculate factorial recursively
    {
    if (n == 0)
        return 1;
    else
        return n * factorial(n - 1);
}
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    // TODO: Reverse a string in-place
    char* start = str;               // Pointer to the start of the string
    char* end = str + strlen(str) - 1;  // Pointer to the end of the string
    char tempVar;                       // Temporary variable for swapping

    // Swap characters from start to end until the middle of the string
    while (start < end) {
        // Swap the characters
        tempVar = *start;
        *start = *end;
        *end = tempVar;

        // Move the start pointer forward and end pointer backward
        start++;
        end--;
    }
    
}



int secondLargest(int arr[], int size) {
    // TODO: Find and return the second largest element in the array
    int max1, max2;
    if (arr[0] > arr[1]){
        max1 = arr[0];
        max2 = arr[1];
    }
    else
    { 
        max1 = arr[1];
        max2 = arr[0];
    }
    for ( int i = 2; i < size; i++){
        if (arr[i] > max1){
            max2 = max1;
            max1 = arr[i];
        }
        else if( arr[i] > max2 && arr[i] < max1){
            max2 = arr[i];
        } 

        }

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
