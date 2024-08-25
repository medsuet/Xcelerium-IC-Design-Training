#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
  echo "Please enter the number along with run command"
  exit 1
fi

# Read the argument
number = $1

# Check if the number is even or odd
if [ $((number % 2)) -eq 0 ]; then
  echo "$number is even."
else
  echo "$number is odd."
fi