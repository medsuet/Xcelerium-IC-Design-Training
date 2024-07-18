int long  arr_gol[6] = {22,4,6,8,10};

int main(){
    int short arr[6] ={1,2,3,4,5};
    arr_gol[5] = 12;
    arr[5] = 6;  
    for(int x =0; x<6; x++){
        arr[x] = arr[x]*2; 
        arr_gol[x] = arr_gol[x]*2; 
    }
}