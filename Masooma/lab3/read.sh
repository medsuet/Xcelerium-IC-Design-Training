#!/bin/bash
count=1
 #-r prevents backslashes from being interpreted as escape characters. 
cat file.txt | while IFS= read -r line #IFS= sets the Internal Field Separator to an empty value, which preserves leading and trailing whitespace in each line.
do
    echo "Line no $count: $line"
    count=$(($count+1))
done