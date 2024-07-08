#!/bin/bash

echo "checking whether the provided number in argument is even or odd"


# Check if exactly one argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <number>"
    exit 1
fi

# Store the number provided as an argument
number=$1

# Check if the number is even or odd
if [ $((number % 2)) -eq 0 ]; then
    echo "$number is even."
else
    echo "$number is odd."
fi
