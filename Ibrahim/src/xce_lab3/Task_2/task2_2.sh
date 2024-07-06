#!/bin/bash
# check is only one argument is provided
if [ "$#" -ne 1]; then 
	echo "Error! Please enter only one argument"
exit 1
fi
# store the argument in a variable
number=$1
echo "The first 10 multiples of $number are:"
for i in {1..10}
do
	multiple=$((number * i))
	echo "$i. $multiple"
done
