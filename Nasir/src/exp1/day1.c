#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes

    // Declare variables of different types
    int var1;
    char var2;
    float var3;
    double var4;
    
    // Print their sizes using %zu for size_t
    printf("Size of int: %zu bytes\n", sizeof(var1));
    printf("Size of char: %zu bytes\n", sizeof(var2));
    printf("Size of float: %zu bytes\n", sizeof(var3));
    printf("Size of double: %zu bytes\n", sizeof(var4));


}
// function for typecasting of variables
void demonstrateTypeCasting() {
    int intValue = 10;
    float floatValue = 5.5;
    double doubleValue = 20.25;
    char charValue = 'A';

    // Demonstrate type casting
    printf("int to float: %f\n", (float)intValue);
    printf("float to int: %d\n", (int)floatValue);
    printf("double to int: %d\n", (int)doubleValue);
    printf("char to int: %d\n", (int)charValue);
}

// 0.2 Operators and Expressions

// Function to perform arithmetic operations
void performArithmeticOperations(int num1, int num2) {
    printf("Arithmetic Operations:\n");
    printf("%d + %d = %d\n", num1, num2, num1 + num2);
    printf("%d - %d = %d\n", num1, num2, num1 - num2);
    printf("%d * %d = %d\n", num1, num2, num1 * num2);
    if (num2 != 0) {
        printf("%d / %d = %f\n", num1, num2, (float)num1 / num2);
        printf("%d %% %d = %d\n", num1, num2, num1 % num2);
    } else {
        printf("Division and modulus operations are not possible with divisor 0.\n");
    }
}

// Function to implement a simple calculator
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement
    int num1, num2;
    char operator;
    
    printf("\nSimple Calculator:\n");
    printf("Enter first number: ");
    scanf("%d", &num1);
    printf("Enter an operator (+, -, *, /, %%): ");
    scanf(" %c", &operator);  // Notice the space before %c to consume any trailing newline character
    printf("Enter second number: ");
    scanf("%d", &num2);
    
    switch (operator) {
        case '+':
            printf("%d + %d = %d\n", num1, num2, num1 + num2);
            break;
        case '-':
            printf("%d - %d = %d\n", num1, num2, num1 - num2);
            break;
        case '*':
            printf("%d * %d = %d\n", num1, num2, num1 * num2);
            break;
        case '/':
            if (num2 != 0) {
                printf("%d / %d = %f\n", num1, num2, (float)num1 / num2);
            } else {
                printf("Error: Division by zero is not allowed.\n");
            }
            break;
        case '%':
            if (num2 != 0) {
                printf("%d %% %d = %d\n", num1, num2, num1 % num2);
            } else {
                printf("Error: Modulus by zero is not allowed.\n");
            }
            break;
        default:
            printf("Error: Invalid operator.\n");
            break;
    }
}



// 0.3 Control Structures
void printFibonacci(int n) {
    // TODO: Print Fibonacci sequence up to n terms
    int t1 = 0, t2 = 1, nextTerm;

    printf("Fibonacci Sequence: ");
    for (int i = 1; i <= n; ++i) {
        printf("%d, ", t1);
        nextTerm = t1 + t2;
        t1 = t2;
        t2 = nextTerm;
    }
    printf("\n");
    
}

void guessingGame() {
    // TODO: Implement a number guessing game
    int number, guess;
    int attempts = 0;

    // Seed the random number generator
    srand(time(0));
    number = rand() % 100 + 1;  // Generate a random number between 1 and 100

    printf("Guess the number (between 1 and 100): \n");

    // Loop until the user guesses the correct number
    do {
        scanf("%d", &guess);
        attempts++;

        if (guess > number) {
            printf("Lower!\n");
        } else if (guess < number) {
            printf("Higher!\n");
        } else {
            printf("Congratulations! You guessed the number in %d attempts.\n", attempts);
        }
    } while (guess != number);
}

// 0.4 Functions
int isPrime(int num) {
    // TODO: Check if a number is prime
    if (num <= 1) {
        return 0;
    }
    for (int i = 2; i * i <= num; ++i) {
        if (num % i == 0) {
            return 0;
        }
    }
    return 1;
}

int factorial(int n) {
    // TODO: Calculate factorial recursively
    // base case
    if (n == 0) {
        return 1;
    } 
    // recursive step 
    else {
        return n * factorial(n - 1);
    }
}

// 0.5 Arrays and Strings

// // Function to calculate the length of a string
// int stringLength(const char* str) {
//     int length = 0;

//     // Iterate through the string until the null terminator is encountered
//     while (str[length] != '\0') {
//         length++;
//     }

//     return length;
// }


void reverseString(char* str) {
    // TODO: Reverse a string in-place
    int lengthString = strlen(str);
    int endString = lengthString - 1;

    // Iterate only till the middle of the string
    for (int stringIndex = 0; stringIndex < endString; stringIndex++, endString--) {
        // Swap characters at stringIndex and endString
        char temporaryVariable = str[stringIndex];
        str[stringIndex] = str[endString];
        str[endString] = temporaryVariable;
    }
}


// Function to find the second largest element in an array
int secondLargest(int array[], int size) {
    // TODO: Find and return the second largest element in the array

    if (size < 2) {
        printf("Array needs to have at least two elements.\n");
        return ; //  indicate error
    }

    int firstLargest, secondLargest;
    // initialize first and second largest to zero
    firstLargest = secondLargest = 0;

    for (int i = 0; i < size; i++) {
        if (array[i] > firstLargest) {
            secondLargest = firstLargest;
            firstLargest = array[i];
        } else if (array[i] > secondLargest && array[i] != firstLargest) {
            secondLargest = array[i];
        }
    }

    if (secondLargest == 0) {
        printf("There is no second largest element (all elements might be equal).\n");
        return ;
    }

    return secondLargest;
}



int main() {
    srand(time(NULL));

    printf("Part 0: Quick Revision Exercises\n");

    // 0.1 Basic Syntax and Data Types
    // calling functions
    printSizes();
    demonstrateTypeCasting();

    // 0.2 Operators and Expressions
    int num1, num2;
    
    // Taking input from the user
    printf("Enter first number: ");
    scanf("%d", &num1);
    printf("Enter second number: ");
    scanf("%d", &num2);
    
    // Perform all arithmetic operations
    performArithmeticOperations(num1, num2);
    
    // Simple calculator
    simpleCalculator();

    // 0.3 Control Structures
    int n;
    printf("Enter the number of Fibonacci terms to print: ");
    scanf("%d", &n);
    printFibonacci(n);
    // calling guessing game function
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