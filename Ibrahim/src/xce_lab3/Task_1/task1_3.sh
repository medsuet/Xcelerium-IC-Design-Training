#!/bin/bash
# store the input numbers in variables
if [ "$#" -ne 2 ]; then
echo "Error! Please enter only two numbers"
exit 1
fi
# check if only two arguments are entered
num1=$1
num2=$2
# calculating the sum
sum=$((num1 + num2))
# printing the sum
echo "The sum of $num1 and $num2 is $sum"
