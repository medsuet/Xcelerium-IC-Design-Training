#!/bin/bash

echo "First 10 Multiples of a Number Provided as an argument"

for ((i=1; i<11; i++))
do
    echo "Multiple no. $i of $1 is $(($i*$1))"
done

