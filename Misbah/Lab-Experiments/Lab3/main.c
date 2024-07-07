#include <stdio.h>

int add(int a, int b);
int subtract(int a, int b);

int main() {
    int a = 5;
    int b = 10;
    
    printf("Sum of %d and %d is %d\n", a, b, add(a, b));
    printf("Difference of %d and %d is %d\n", a, b, subtract(a, b));
    
    return 0;
}
