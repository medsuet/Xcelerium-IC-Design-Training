#include <stdio.h>
#include <stdint.h>


int complement(int a){
    return ~a + 1;
}

int boothAlgorithm(int BR, int QR){
   int AC = 0;
   int Qn1 = 0;
   int SC = 32; 
   int lsb;
   int AC_lsb;

   while (SC != 0) {
      printf("AC: %08x   QR: %08x   Qn+1: %d   SC: %d\n", AC, QR, Qn1, SC);
       //printf("QR: %d\n",QR);
      if ((QR & 1) == 0 && Qn1 == 1) {
          AC = AC + BR;
      } else if ((QR & 1) == 1 && Qn1 == 0) {
          AC = AC + complement(BR) + 1;
      }

    
      Qn1 = QR & 1;
      AC_lsb = AC & 1;
      AC = (AC >> 1) | (AC & 0x80000000); 
      QR = (QR >> 1) | (AC_lsb << 31);

      SC = SC - 1;
   }

   // Combine AC and QR to form the final result
    int64_t result = ((int64_t)AC << 32) | (QR & 0xFFFFFFFF);
   return result;
}

int main() {
    int num1 = 7;
    int num2 = 3;
    printf("7 x 3 = %d\n", boothAlgorithm(num1, num2));

    return 0;
}

