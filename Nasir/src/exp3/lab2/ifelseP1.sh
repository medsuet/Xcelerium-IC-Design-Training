#!/bin/bash

# Excercise 2.1 If Else statements

# step 1: taking number as command line argument
number=$1

# Check if the number is even or odd
if [ $((number % 2)) -eq 0 ]; then
  echo "The number $number is even."
else
  echo "The number $number is odd."
fi


