#include <stdio.h>

int main()
{
  // user inputs
    int x;
    int y;
    printf("Input x = ");
    scanf("%d", &x);
    printf("Input y = ");
    scanf("%d", &y);
    
  // switch operatoion variable 
    int opr;
    printf("Values of operator\n");
    printf(" add      => 1\n subtract => 2\n");
    printf(" multiply => 3\n divide   => 4\n");
    printf(" mod      => 5\n");
    printf("Type the value of operator: ");
    scanf("%d", &opr);
    
  // switch statement
    switch (opr) { 
       case (1):
       	   printf("Add the user inputs = %d\n", x+y);
       	   break;
       case (2):
       	   printf("Subtract the user inputs = %d\n", x-y);
       	   break;
       case (3):
           printf("Multiply the user inputs = %d\n", x*y);
           break;
       case (4):
       	   printf("Divide the user inputs = %d\n", x / y);
       	   break;
       case (5):
       	   printf("Mod of the user inputs = %d\n", x % y);
       	   break;
    }
} 
