#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <math.h>
// Part 0: Quick Revision Exercises

// 0.1 Basic Syntax and Data Types
void printSizes() {
    // TODO: Declare variables of different types and print their sizes
int a=10; 
int b=3;
float f;
char c;
double d=202175;

f = (float) a/b;
c = (char) d/(float)6;
printf("size of int,float and char and double  is %zu, %zu, %zu, %zu\n",sizeof(a),sizeof(b),sizeof(c),sizeof(d));	
printf("size of %f and %c after type casting is  %zu and %zu\n",f,c,sizeof(f),sizeof(c));
}
// 0.2 Operators and Expressions
void simpleCalculator(int a,int b,char c) {
    // TODO: Implement a simple calculator using switch statement
switch (c){
  

	case 'A': printf("sum of  %d and %d is %d\n",a,b,a+b);
	break;
	case 'M': printf("multiply of  %d and %d is %d\n",a,b,a*b);
	break;
	case 'S': printf("subtract of  %d and %d is %d\n",a,b,a-b);
	break;
	case 'D': if(b!=0) printf("division of %d and %d is %d\n",a,b,a/b);
		  else printf("not possible\n");	  
	break;
	case 'o':if(b!=0) printf("remainder of %d and %d is %d\n",a,b,a%b);
		 else printf("not possible\n");	 
        break;
        case 'a': printf("sum %d ,multiply %d, subtract %d, division %d and remainder %d\n",a+b,a*b,a-b,a/b,a%b);
	break;  	  
}
}

// 0.3 Control Structures
void printFibonacci(int n) {
    // TODO: Print Fibonacci sequence up to n terms

    int f[n];
    f[0] = 0;
    printf("0 ");
    f[1] = 1;
    printf("1 ");
    for(int i=2;i<=n;i++){
        f[i] =f[i-1] +f[i-2]; 
	printf("%d ",f[i]);
       
 }
}

void guessingGame() {
    // TODO: Implement a number guessing game
    int a= rand();
    int b;
    printf("Guess any number: ");
    scanf("%d",&b);
    if(a==b) printf("You won\n");
    else printf("%d is the correct number\n", a );
}

// 0.4 Functions
int isPrime(int num) {
    if(num<2) return 0;
    else if(num==2) return 1;
   
    for(int i=2;i<num;i++) {if(num%i==0) return 0;  }
    return 1;
}

int factorial(int n) {
    // TODO: Calculate factorial recursively
    int f;
    if(n==0){ f=1;}
    else {f=n*factorial(n-1); }
    return f;
}

// 0.5 Arrays and Strings
void reverseString(char* str) {
    // TODO: Reverse a string in-place
   char string[strlen(str)];
   for(int i=0;i<strlen(str);i++){
       int rev = (strlen(str)-1)-i;
       string[i]=str[rev];      
   }
   string[strlen(str)] = '\0';  
   printf("reverse string is %s\n",string);
}

int secondLargest(int arr[], int size) {
   // TODO: Find and return the second largest element in the array
   int secLar=arr[0];
   int index;
   int largest =arr[0];
   // printf("size of arr is %d",size);
   for(int i=0;i<=size;i++){
           if(arr[i]>largest){
	       largest=arr[i];
	       index = i;
    }
  }
  
  // int ind;
  // printf("largest element is %d",secLar);
  for(int i=0;i<=size;i++){
      if(arr[i]>secLar && arr[i]<largest){
         
           secLar=arr[i];
         
      }

  }   
  return secLar;
 
}
int main(){
 printSizes();
 
 simpleCalculator(2,4,'A');
 simpleCalculator(2,4,'M');
 simpleCalculator(2,0,'o');
 simpleCalculator(11,16,'a');

 printFibonacci(5);
 printf("\n");
 guessingGame();

 for(int i=1;i<=100;i++){
 if(isPrime(i)){
 printf("%d ",i);
 }
 }
 printf("\n");

 printf("%d\n",factorial(3));
 

 reverseString("xclerium");
 
int arr[] = {5, 2, 8, 1, 9, 3, 7};
int size = sizeof(arr) / sizeof(arr[0]);
printf("Second largest element: %d\n", secondLargest(arr, size));
 
 return 0;
}
