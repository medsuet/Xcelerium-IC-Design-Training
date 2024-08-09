#!/bin/bash
declare -a fruits=(
[0]=Apples
[1]=Mangoes
[2]=Bananas
[3]=Grapes
[4]=Oranges
)
print_array(){
	local my_array=("$@")
	echo "${my_array[@]}"
}
print_array ${fruits[@]}
fruits+=("Melons")
print_array ${fruits[@]}
