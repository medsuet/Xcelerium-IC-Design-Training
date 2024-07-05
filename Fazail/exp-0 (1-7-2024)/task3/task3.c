#include <stdio.h>

int main(){
 // initialize the values
 int term1 = 0; 	// 1st term
 int term2 = 1;		// 2nd term
 int next_term = term1 + term2;
 int n, i;

 printf("Type the nth term:");
 scanf("%d", &n);
 
 printf("Print the 2nd to %dth terms\n", n); 
 for (i=0; i<(n-1); i++){
     printf("%d, ", next_term);
     next_term = term1 + term2;
     term1 = term2;
     term2 = next_term;
 }
return 0;
}
