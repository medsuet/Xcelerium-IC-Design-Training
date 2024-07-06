#!/bin/bash
# Take the argument from command line 
number=$1
# using if-else to check whether number is even or odd and printing the number
if [ $((number % 2)) -eq 0 ]; then 
    echo "$number is an even number."
else 
    echo "$number is an odd number." 
fi

