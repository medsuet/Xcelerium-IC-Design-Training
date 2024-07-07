============================================================================
 * Filename:    template_code_Part0.c
 * Description: File consists of codes of Simple operations in C
 * Author:      Hira Firdous
 * Date:        7/2024
 * ===========================================================================
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
	char character_variable;
	int integer_variable;
	double double_variable;
	float float_variable;
	long long_variable;
	short short_variable;
	unsigned int unsigned_integer;

	printf("This function shows datatypes and size of these datatypes \n");
	printf("This is the size of character: %zu \n", sizeof(character_variable));
	printf("This is the size of Integer: %zu \n", sizeof(integer_variable));
	printf("This is the size of double: %zu \n", sizeof(double_variable));
	printf("This is the size of float: %zu \n", sizeof(float_variable));
	printf("This is the size of long: %zu \n", sizeof(long_variable));
	printf("This is the size of short: %zu \n", sizeof(short_variable));
	printf("This is the size of unsigned integer: %zu \n", sizeof(unsigned_integer));
}

// 0.2 Operators and Expressions
void simpleCalculator() {
    // TODO: Implement a simple calculator using switch statement.
	printf("Following program will contain the calculator code ");

	char operator;
	//i have used double instead of int because
	// in case of addition, multiplication size 
	// and in case of division can encounter float.
	double num1,num2;

	//assigning the operator
	printf("Enter the operation you want to perform on the numbers (+, -, *, /) :");
	scanf("%c", &operator);

	//declaring the operands
	printf("Enter the two numbers:");
	scanf("%lf %lf", &num1, &num2);
	printf("%lf %c %lf \n", num1,operator,num2);
	switch(operator){
		case '+':
		    num1=num1+num2;
		    printf("Result: %.2lf\n",num1);
		    break;
		case '-':
		    num1=num1-num2;
		    printf("Result: %.2lf \n",num1);
			break;
		case '*':
			num1=num1*num2;
			printf("Result: %.2lf \n",num1);
			break;
		case '/':
			if(num2==0){printf("Divison by zero is invalid/n");}
			else{
			num1=num1/num2;
			printf("Result: %.2lf \n",num1);
			break;
				}
		
		default:
			printf("invalid operator");
	}
	
	
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // TODO: Print Fibonacci sequence up to n terms
	// TODO: Print Fibonacci sequence up to n terms
	/*
	so we know that for fibonacci its always
	fib(n-1)+fib(n-2)
	resursion will be a better option
	but we will have to change the return type to execute it.
	
	if (n<=1){
		return n;
	}else{
		return(printFibonacci(n-1) +printFibonacci(int n-2));
	}
	*/
	
	int first=0;
	int second=1;
	int answer=0;
	for (int i=0; i<n; i++){
		printf("%d ",first);
		answer=first+second;
		first=second;
		second=answer;
	}

}

void guessingGame() {
    // TODO: Implement a number guessing game
	printf("Lets play the number guessing game : \n So i will give you hints and you have to guess it \n");
	/*
	initializing the seed,
	 seed is use because if i want to generate a number using random function
	within sime range i get the same number each time we access it
		to keep the consistensy*/ 

	srand(time(0));
	int original=rand()%101;
	int guess;
	printf("Think of number and tell me: %d ", original);
	scanf("%d",&guess);

	//for playing the game, loop will iterate until user guess the word.
	while (guess!=original){
	if (guess>original){printf("your guess is greater than my number\n");}
	else{printf("your guess is less than my number\n");}
	printf("Try again");
	scanf("%d",&guess);
	}
	printf("Congratulations you have guessed the number\n the number was %d",guess);
}



// 0.4 Functions
int isPrime(int n) {
    // TODO: Check if a number is prime
	if (n <= 1) {
        	return 0;  // Not prime if less than or equal to 1
    	}
    
    	if (n <= 3) {
        	return 1;  // 2 and 3 are prime numbers
    	}

    	if (n % 2 == 0 || n % 3 == 0) {
        	return 0;  // Not prime if divisible by 2 or 3
    	}

    // Checking for divisibility from 5 to sqrt(n)
    	for (int i = 5; i * i <= n; i += 6) {
        	if (n % i == 0 || n % (i + 2) == 0) {
            		return 0; 
        	}
    	}

    return 1;  // If no divisors found, n is prime
}

int factorial(int n) {
    // TODO: Calculate factorial recursively
	if (n == 0) {
        	return 1;
    	}
    else {
        return n * factorial(n - 1);
    }
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    int temp_first = 0;
    int temp_last = strlen(str) - 1;
    char temp_var;

    while (temp_first < temp_last) {
        temp_var = str[temp_last];
        str[temp_last] = str[temp_first];
        str[temp_first] = temp_var;
        temp_first++;
        temp_last--;
    }
}

int secondLargest(int arr[], int size) {
    // TODO: Find and return the second largest element in the array
	if (size < 2) {
        printf("Array size should be at least 2.\n");
        return -1;  // Error condition: array size is less than 2
    }
    
    int firstLargest = arr[0];
    int secondLargest = arr[1];
    
    // Ensure firstLargest and secondLargest are correctly assigned
    if (secondLargest > firstLargest) {
        int temp = firstLargest;
        firstLargest = secondLargest;
        secondLargest = temp;
    }
    
    for (int i = 2; i < size; i++) {
        if (arr[i] > firstLargest) {
            secondLargest = firstLargest;
            firstLargest = arr[i];
        } else if (arr[i] > secondLargest && arr[i] != firstLargest) {
            secondLargest = arr[i];
        }
    }
    
    return secondLargest;
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
