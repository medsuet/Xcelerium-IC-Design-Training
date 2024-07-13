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