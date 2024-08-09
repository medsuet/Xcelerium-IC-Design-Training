#include <stdio.h>

int main() {
    int int_val=103;
    float float_val=6.5;
    double double_val=102.5;
    char text='A';
    printf("Size of integer value= %zu bytes\n",sizeof(int_val));
    printf("Size of float value= %zu bytes\n",sizeof(float_val));
    printf("Size of double value= %zu bytes\n",sizeof(double_val));
    printf("Size of char text = %zu bytes\n",sizeof(text));
//Type Casting Examples
    printf("int to float example: %.1f\n",(float)int_val);
    printf("float to int example: %d\n",(int)float_val);
    printf("int to char example: %c\n",(char)(int_val));
    printf("char to int example: %d\n",(int)text);
    printf("double to char example: %c\n",(char)double_val);
    printf("char to double example: %.1f\n",(double)(text));

    return 0;
}