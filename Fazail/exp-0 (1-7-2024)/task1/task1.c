#include <stdio.h>

int main() 
{
	int x = 10;
	char y = (char) x;
	float z = (float) x;
	double w = (double) x;
	printf("Size of x = %zu, Value of x = %i\n", sizeof(x), x);
	printf("Size of y = %zu, Value of y = %d\n", sizeof(y), y);
	printf("Size of z = %zu, Value of z = %f\n", sizeof(z), z);
	printf("Size of w = %zu, Value of w = %f\n", sizeof(w), w);
	return 0;
}
