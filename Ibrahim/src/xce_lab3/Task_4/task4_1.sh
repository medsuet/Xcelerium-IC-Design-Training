#!/bin/bash
# file to read
file="sample.txt"

# check if the file exists
if [[ ! -f $file ]]; then 
	echo "Error: File $file not found"
	exit 1
fi

# read the file line by line
line_number=0
while IFS= read -r line
do
	line_number=$((line_number + 1))
	echo "$line_number: $line"
done < "$file"
