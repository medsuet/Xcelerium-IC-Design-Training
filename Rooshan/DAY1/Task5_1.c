#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main() {
    char String[]="abcdefg";
    int n=strlen(String);
    char String_reversed[n];
    for (int i=0;i<n;++i)
    {
        String_reversed[i]=String[n-i-1];
        printf("%c",String_reversed[i]);
    }
    
}
