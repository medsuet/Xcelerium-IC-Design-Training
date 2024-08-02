#!/bin/bash
if [ $# -ne 2 ]; then
	echo "Usage: $0 <num1> <num2>"
	exit 1
fi


num1=$1
num2=$2

echo "numbers are $num1 $num2"

sum=$((num1+num2))

echo "This is the sum: $sum"
