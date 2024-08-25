#!/bin/bash

# Create an array of fruits
fruits=("Apple" "Banana" "Cherry" "Date")

# Function to print each fruit in the array
print_fruits() {
  local fruit_array=("$@")
  for fruit in "${fruit_array[@]}"; do
    echo "$fruit"
  done
}

# Call the function to print the initial array of fruits
echo "Initial list of fruits:"
print_fruits "${fruits[@]}"

# Add a new fruit to the array
fruits+=("Orange")

# Call the function to print the updated array of fruits
echo "Updated list of fruits:"
print_fruits "${fruits[@]}"
