#!/bin/bash
# Create an array of fruits
fruits=("Apples" "Bananas" "Grapes")
# Function to print each fruit in the array
print_fruits() {
	echo "List of fruits"
	for fruit in "${fruits[@]}"
	do
		echo "$fruit"
	done
}
# call the print_fruit function to print the frutis
print_fruits
# add a new fruit to the array
new_fruit="Peach"
fruits+=("$new_fruit")
# print a separator
echo "-------------------"

# call the function again after adding a new fruit
print_fruits

