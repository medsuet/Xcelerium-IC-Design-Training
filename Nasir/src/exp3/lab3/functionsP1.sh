#!/bin/bash

# Function to calculate the factorial of a number
factorial() {
  local number=$1
  if [ $number -le 1 ]; then
    echo 1
  else
    local previousNumber=$((number - 1))
    local previousFactorial=$(factorial $previousNumber)
    echo $((number * previousFactorial))
  fi
}

# Checking factorial function for different values
listNumbers=(2 3 5 7 9 10)
for facNumber in "${listNumbers[@]}"; do
  # calling factorial function
  result=$(factorial $facNumber)
  echo "The factorial of $facNumber is: $result"
done
