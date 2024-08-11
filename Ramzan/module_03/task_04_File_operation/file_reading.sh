#!/bin/bash

file="example.txt"
line_number=1
while read -r line
do 
	echo "$line_number:$line"
	((line_number++))
done < "$file"
