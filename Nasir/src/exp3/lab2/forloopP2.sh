#!/bin/bash
# taking command line argument
number=$1
# using for loop for calculating and printing 10 multiples of number
for((i=1;i<11;i++))
do
    result=$((number * i))
    echo "$number x $i = $result"

done




