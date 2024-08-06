/*
    Name: task2_setclearbit_c.c
    Author: Muhammad Tayyab
    Date: 12-7-2024
    Description: Set or clear any bit in a 32 bit number
*/
int setbit(int a0, int a1) {
    return (a0) | (1 << (a1));
}
int clearbit(int a0, int a1) {
    return (a0) & ~(1 << (a1));
}

int main(void) {
    int a0, a1;
    a0 = 8;
    a1 = 1;
    a0 = setbit(a0, a1);
    a1 = 3;
    a0 = clearbit(a0, a1);
    return 0;
}