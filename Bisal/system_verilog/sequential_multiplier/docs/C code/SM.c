#include <stdio.h>

int and(int n1,int n2){
	int B;
	if (n2==0){
		B=0;
	}
	else{
		B=-1;
	}
	return n1 & B;
};

int printBits(int *num){
    for (int i = sizeof(int)*8 -1 ; i>=0;i-- ){
        printf("%d", (*num >> i) & 1);
    }
    printf("\n");
};

int SM(int n1,int n2){
	int pp;
	int shifted_p;
	int product;
	int b_bit;
	for (int i = 0;i<32;i++){
		b_bit= (1<<i )&n2;
        printBits(&b_bit);
		pp=and(n1,b_bit);
        printBits(&pp);
		shifted_p = pp << i; 
		printf("%d\n",shifted_p);
		product = product + shifted_p; 
	}
	printf("product is: % d\n",product);
};

int main(){
	int n1=3;
	int n2=-3;
	SM(n1,n2);
	return 0;
};
