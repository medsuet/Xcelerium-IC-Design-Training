#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
  echo "Please enter the number along with run command"
  exit 1
fi

# Read the argument
number=$1

# Use a for loop to print the first 10 multiples of the number
for i in {1..10}; do
  multiple=$((number * i))
  echo "$number * $i = $multiple"
done
