#!/bin/bash

fruits=("Apple" "Banana" "Orange")

echo "Before adding Mango:"
echo ""

# Call the echo function to print fruits initially
echo ${fruits[@]}

# Add a new fruit to the array
fruits+=("Mango")
echo ""
echo "After adding Mango:"
echo ""

# Call the echo function again to print fruits after adding Mango
echo ${fruits[@]}
