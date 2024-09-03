#include <stdio.h>
#include <stdlib.h>

int store_buffer_data[8];
int store_buffer_address[8];
int TOQ=0;
int BOQ=0;
int valid[8]={0,0,0,0,0,0,0,0};

int main() {
    for (int j=0; j<10; j++) {
        add_to_que()
    }

}

int add_to_que(int address, int data) {
    TOQ++;
    while (~valid[TOQ]);
    store_buffer_data[TOQ] = data;
    store_buffer_address[TOQ] = address;
    valid[TOQ] = 1;
}

int evacuate_to_cache() {
    if (valid[BOQ]) {
        for (int i=0; i<(rand()%2000000); i++);
        store_buffer_data[BOQ] = 0;
        store_buffer_address[BOQ] = 0;
        valid[BOQ] = 0;
        BOQ++;
    }
}