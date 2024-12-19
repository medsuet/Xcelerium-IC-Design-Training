
int changeBit(int *num, int bit_position, int value ){
         if (value == 0){
	       *num &=~(1<<bit_position);
	 }
	 else  *num |= (1<<bit_position);
}

int main(){
int num = 0xF;
changeBit(&num,3,0);
//printf("num is 0x%X\n",num);
return 0;
}
