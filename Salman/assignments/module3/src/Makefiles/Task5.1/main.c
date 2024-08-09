#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int main() {
    void test(); // function declaration before function use

    printf("This is statement from the main function\n");

    test();

    return 0;
}
