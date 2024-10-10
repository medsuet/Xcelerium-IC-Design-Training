#!/bin/bash
for ((i=0;i<11;i++))
do
    multiple=$(( $1*$i ))
    echo "$i Multiple of $1 is $multiple"
done