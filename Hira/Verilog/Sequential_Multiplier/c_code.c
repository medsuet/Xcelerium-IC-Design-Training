#include <stdio.h>


void print_binary(int *num){
    /*Print the binary of the decimal number*/
    int *ptr;
    ptr = num;
    for (int i = sizeof(int) * 8 - 1; i >= 0; i--) {
    printf("%d", (*ptr >> i) & 1);
    }
    printf("\n");

}


int partial_product(int A, int b_bit, int width) {
    int answer=A;
    //for toggle
    if (b_bit==0){
        answer=A & 0;
    }
    else{
        answer=A & 4294967295;     //this is 2^width-1
    }
    //int MSB = (answer >> (width - 1)) & 1;            //preserve 
    return answer;
}

int algorithm(int A, int B,int width){
    int temp=0;
    int product=0;
    for (int j; j < width; j++){
        temp=(B>>j) & 1;
        int temp_variable= partial_product(A, temp, width) << j;
        product=product + temp_variable;
    }
    return product;

}

int main() {
    int A_number=5;      //multiplicant
    int B_number=-7;      //multiplier

    /*
    int num=65535;
    print_binary(&B_number);
    int a= partial_product(&A_number,1,16) << 0;
    print_binary(&a);
    int b= partial_product(&A_number,1,16) << 1;
    print_binary(&b);
    int c= partial_product(&A_number,1,16) << 2;
    print_binary(&c);
    */
    int an=-algorithm(A_number,B_number,16);

    printf("answer is %d \n",an);
    //print_binary(&a);

    return 0;
}