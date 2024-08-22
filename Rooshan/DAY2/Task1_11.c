#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    int var=10;
    int * ptr=&var;
    printf("Value of variable=%d\n",var);
    printf("Value of variable=%d\n",*ptr);
    printf("Address of variable=%p\n",ptr);
    printf("Address of variable=%p\n",&var);
    *ptr=*ptr+20;
    printf("Value of variable=%d\n",var);
}
