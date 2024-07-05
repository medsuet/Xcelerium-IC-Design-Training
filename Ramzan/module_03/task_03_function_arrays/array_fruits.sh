#!/bin/bash

my_array=("banana" "Apple" "Mango" "Diljeet")
Fruits() {
	for fruit in "${my_array[@]}"
	do
		echo $fruit
	done
}
echo "List of fruits is:"
Fruits 	

#add fruits to previous arra

my_array+=("kalak")
echo "Updated array is:"
Fruits
