#!/bin/bash

# File to read
FILE="content.txt"

# Check if file exists
if [[ ! -f "$FILE" ]]; then
  echo "File not found!"
  exit 1
fi

# Initialize line number
line_number=1

# Read the file line by line
while read line
do
  # Print the line with its line number
  echo "$line_number: $line"
  # Increment the line number
  ((line_number++))
done < "$FILE" #redirects the content of the file specified by FILE into the while loop
