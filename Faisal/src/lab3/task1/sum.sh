#!/bin/bash

# Check if exactly two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Please enter the two numbers along with run command"
  exit 1
fi

# Read the arguments
num1=$1
num2=$2

# Calculate the sum
sum=$(($num1 + $num2))

# Print the result
echo "The sum of $num1 and $num2 is: $sum"

