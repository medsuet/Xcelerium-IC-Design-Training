#!/bin/bash

# This script defines a function to calculate the factorial of a number and prints the results for different inputs.

# Function to calculate factorial
factorial() {
    local num=$1
    local fact=1

    for ((i=1; i<=num; i++)); do
        fact=$((fact * i))
    done

    echo "The factorial of $num is $fact."
}

# Test the factorial function with different numbers
factorial 5
factorial 6
factorial 7

