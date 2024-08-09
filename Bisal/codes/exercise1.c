/*
 * ============================================================================
 * Filename:    exercise1.c 
 * Description: File consists of codes based on basic concepts of C language
 * Author:      Bisal Saeed
 * Date:        7/1/2024
 * ============================================================================
 */

//NOTE: run using command : cd codes && gcc -o day1 exercise1.c
//                          ./day1

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <limits.h>

// 0.1 Basic Syntax and Data Types
void printSizes() {
    //Datatypes are ddefined and their sizes are found by sizof() fucntion
    int intVar;
    float floatVar;
    double doubleVar;
    char charVar;

    printf("Size of int: %ld \n", sizeof(intVar));
    printf("Size of float: %ld bytes\n", sizeof(floatVar));
    printf("Size of double: %ld bytes\n", sizeof(doubleVar));
    printf("Size of char: %ld bytes\n", sizeof(charVar));

    // Type casting demonstration : Conversion of one datatype to other
    int a = 5;
    //(dataype) used as cast operato9r before variable,temporarily treating a 
    //as double during compilation and assigned to value of b which is double
    double b = (double)a;
    printf("Original int value: %d, Type casted to double: %f\n", a, b);
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    //LOGIC: Take two numbers num1 and num2 and allow user to choose what function to perform on them
    // used a switch case for choice as it was to make decision between multiple cases
    int num1, num2, choice;
    printf("Enter two numbers: ");
    scanf("%d %d", &num1, &num2);

    printf("Choose an operation (1:+, 2:-, 3:*, 4:/, 5:%%): ");
    scanf("%d", &choice);
    //swtch is value entered which is to be compared
    switch (choice) {
        // case which has value which will be comapred with switch  to execute commands
        case 1:
            printf("Result: %d\n", num1 + num2);
            break;
        case 2:
            printf("Result: %d\n", num1 - num2);
            break;
        case 3:
            printf("Result: %d\n", num1 * num2);
            break;
        case 4:
        //KEEP CHECK IF NUMBER IS NOT DIVIDED BY 0
            if (num2 != 0)
                printf("Result: %d\n", num1 / num2);
            else
                printf("Error: Division by zero\n");
            break;
        case 5:
        //KEEP CHECK IF NUMBER IS NOT DIVIDED BY 0
            if (num2 != 0)
                printf("Result: %d\n", num1 % num2);
            else
                printf("Error: Division by zero\n");
            break;
        default:
            printf("Invalid choice\n");
    }
}

// 0.3 Control Structures
//LOGIC: This starts off with logic of 2nd term of sequence .We will first print prev number which starts
//with zero .As fibonacci sequence has no neg number so we will not consider those and start from 0 so prev=0
//similarly current as 1 then we compute the sum for next fibonacci 
//sequence number and loop runs upto n numbers entered by user 
void printFibonacci(int n) {
    int prev = 0, current = 1, nextTerm;
    printf("Fibonacci sequence: ");

    for (int i = 1; i <= n; ++i) {
        printf("%d ", prev);
        nextTerm =  prev + current;
        prev = current;
        current = nextTerm;
    }
    printf("\n");
}

void guessingGame() {
    int guess, number, attempts = 0;
    srand(time(0));
    //random numbers between 0-9
    number = rand() % 10 ; 
    //take guess from user 
    printf("Guess the number (between 1 and 100): ");
    //do while used as it checks condition after alll statements are executed once so case 
    //will not be false as we need to compare guess with number taken within loop from user
    do {
        scanf("%d", &guess);
        //increase number of attempts based on how many times canf runs(user enters guess)
        attempts++;
        //higher and lower value hints 
        if (guess > number)
            printf("Lower\n");
        else if (guess < number)
            printf("Higher\n");
        else
            printf("You guessed it in %d attempts!\n", attempts);
    } while (guess != number);
}

// 0.4 Functions
int isPrime(int num) {
    //any number less than or equal to one cannot be prime number 
    if (num <= 1) {
        return 0;
        }
    // if not a prime number then has atleast one factor at value num/2 or less than that   
    for (int i = 2; i <= num / 2; ++i) {
        if (num % i == 0)
            return 0;
    }
    //if find no factors then the loop returns 1 showing it is prime number
    return 1; 
}

int factorial(int n) {
    //check if n==0 then factorial of 0 is 1 ,base case
    if (n == 0)
        return 1;
    else
    //recursively call the function to compute till n==0
        return n * factorial(n - 1);
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    int n = strlen(str);
    //swap till half of string
    for (int i = 0; i < n / 2; i++) {
        //reverse string by swaping
        char temp = str[i];
        str[i] = str[n - i - 1];
        str[n - i - 1] = temp;
    }
}

int secondLargest(int arr[], int size) {
    int first, second;
    if (size < 2) {
        //as we have to find second largest element
        printf("Array should have at least two elements.\n");
        return 1;
    }
    //INT_MIN is smallest possible value for an integer
    first = second = INT_MIN;
    for (int i = 0; i < size; i++) {
        if (arr[i] > first) {
            second = first;
            first = arr[i];
        } else if (arr[i] > second && arr[i] != first) {
            second = arr[i];
        }
    }
    if (second == INT_MIN)
        return 1;
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
    int result = secondLargest(arr, size);
    if (result != -1)
        printf("Second largest element: %d\n", result);
    else
        printf("There is no second largest element.\n");

    return 0;
}
