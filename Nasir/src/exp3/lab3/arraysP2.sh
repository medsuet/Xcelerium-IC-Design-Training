#!/bin/bash

# Create an array of fruits
fruits=("Apple" "Banana" "Grapes")

# Function to print each fruit in the array
print_fruits() {
  # @ represents al the arguments passed to the function
  local array=("$@")
  # for loop for printing each fruit one by one
  for fruit in "${array[@]}"; do
    echo $fruit
  done
}

# Print the initial list of fruits
echo "Initial list of fruits:"
# fruits[@] expands to all elements in fruits list
print_fruits "${fruits[@]}"

# Add a new fruit to the array
fruits+=("Mango")

# Print the updated list of fruits
echo "Updated list of fruits:"
# fruits[@] expands to all elements in fruits list
print_fruits "${fruits[@]}"
