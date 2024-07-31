#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

void reverseString(char* str) {
    // TODO: Reverse a string in-place
    //printf("%ld \n", strlen(str));
    char cstr[] =  "";
    int len = strlen(str);
    strcpy(cstr, 'str[len-1]');
    for(int i=len-2 ; i<0 ; i--){
        strcat(cstr, str[i]);
    }
    str = cstr;
}

int main(){

    char str[] = "   Hello, World!";
    printf("Original string: %s\n", str);
    reverseString(str);
    //printf("Reversed string: %s\n", str);


    return 0;
}