#include<stdio.h>
#include<stdlib.h>

// Number of bits of multipler and multipliand
#define NUMBITS 15

int printBin(int num);

int getbit(int num, int n) {
    // Returns nth bit of number, where lsb is 1st bit
    return (num>>(n-1)) & 1;
}

void setbit(int *num, int n, int bit) {
    // Sets nth bit of number to bit (0 or 1), where lsb is 1st bit
    if (bit==0) *num = (*num) & ~((1<<(n-1)));
    if (bit==1) *num = (*num) | ((1<<(n-1)));
}

int printBin(int num) {
    // prints binary representation of num
    for (int i=32; i>0; i--) {
        int bit = getbit(num, i);
        printf("%d",bit);
    }
    printf("\n");
}

void ashr(int *num) {
    // Arthematic shift right 1 bit, 
    // cycling LSB to left and keeping MSB
    int lsb = getbit(*num,1);
    int msb = getbit(*num,32);
    *num =  (lsb << (32-1)) | (msb << (32-1)) | (*num >> 1);
}

int boothMult(int BR/*multiplicand*/, int QR/*multiplier*/) {
    /* BR and QR must not be more than 31 bit
    */
    int AC=0;                   /*result accumulator*/
    int SC=NUMBITS;                  /*counts number of bits set*/
    int n=NUMBITS;
    setbit(&QR, n+1, 0);         /*Set Q(n+1) to 0*/

    printf("AC: "); printBin(AC); printf("Q:  "); printBin(QR); printf("Qn: %d\n",getbit(QR,n)); printf("Qn1:%d\n",getbit(QR,n+1)); printf("SC: %d\n\n",SC);

    do {
        if (getbit(QR,n)==1 && getbit(QR,n+1)==0) {
            AC = AC + ~BR + 1;
            printf("A\n");
        }
        else if (getbit(QR,n)==0 && getbit(QR,n+1)==1) {
            AC = AC + BR;
            printf("B\n");
        }
        ashr(&QR);
        ashr(&AC);
        SC = SC-1;
        printf("AC: "); printBin(AC); printf("Q:  "); printBin(QR); printf("Qn: %d\n",getbit(QR,n)); printf("Qn1:%d\n",getbit(QR,n+1)); printf("SC: %d\n\n",SC);


    } while (SC != 0);

    return QR | AC<<NUMBITS;
}

int wikiBoothMult(int m/*multiplicand*/, int r/*multiplier*/) {
    // Implemented by wikipedia algorithem
    int A=0, S=0, P=0;
    A=m<<(NUMBITS+1);
    S=((~m)+1) << (NUMBITS+2);
    P= (r & 0x0000FFFF)<<1;

    printf("A:");printBin(A); printf("S:");printBin(S);printf("P:");printBin(P); printf("\n");

    int i=0;
    do {
        if ((P & 3) == 1) {     // 2 LSBs are 01
                P = P+A;
                printf("  A  ");
        }
        else if ((P & 3) == 2) {    // 2 LSBs are 10
                P = P+S;
                printf("  B  ");
        }
        ashr(&P);
        printf("A:");printBin(A); printf("S:");printBin(S);printf("P:");printBin(P); printf("\n");
        i++;
    } while (i<NUMBITS);

    printf("A:");printBin(A); printf("S:");printBin(S);printf("P:");printBin(P>>2); printf("\n");
    return P>>2;
    
}

int main(void) {
    system("clear");
    
    int r = wikiBoothMult(3,-4);
    printf("%d\n\n", r);

    return 0;
}
