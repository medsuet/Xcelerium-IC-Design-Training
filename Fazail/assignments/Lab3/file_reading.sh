#!/bin/bash

file="file1.txt"

count=1         #count is use to count the lines 
while read -r line; do
    echo "[$count] $line"
    count=$(($count+1))
done < file1.txt