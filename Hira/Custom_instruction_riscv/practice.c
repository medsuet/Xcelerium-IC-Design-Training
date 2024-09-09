
//#include <stdio.h>
int main() {
    int rd;
    int r1 = 2;  // Example number
    __asm__ volatile("rev %0, %1" : "=r"(rd) : "r"(r1));
    return 0;
}


