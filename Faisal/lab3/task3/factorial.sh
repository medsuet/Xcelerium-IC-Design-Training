#!/bin/bash

# Function to calculate the factorial of a number using recursion
factorial() {
  local num=$1

  if [ "$num" -le 1 ]; then
    echo 1
  else
    local prev_factorial=$(factorial $((num - 1)))
    echo $((num * prev_factorial))
  fi
}

# Call the function with different numbers and print the results
for number in {0..10}; do
  echo "Factorial of $number is $(factorial $number)"
done
