#!/bin/bash
#command line variable
number=$1

#using modulus to checking if it is even or odd
if [ $((number % 2)) -eq 0 ]; then
 	echo "$number is even"
else
	echo "$number is odd"
fi


