#!/bin/bash
array_fruits=("mango" "orange" "appple")

print_array(){
	echo "Fruits in array are"
	for fruits in ${array_fruits[@]}; do
		echo "$fruits"

	done
}


echo "before adding"
print_array
echo "after adding"
array_fruits+=("grape")
print_array




