#!/bin/bash

# This script reads from a file line by line and prints each line with its line number.

filename='read.txt'  # specify the file name
line_number=1          # initialize line number

while read line; do    # read file line by line
    echo "$line_number: $line"  # print line with its line number
    ((line_number++))           # increment line number
done < "$filename"

