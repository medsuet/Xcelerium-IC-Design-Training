#!/bin/bash
#taking arguement
number=$1

#using for loop
for ((i = 1; i<=10; i++)); do
	echo "$((number * i))"
done
