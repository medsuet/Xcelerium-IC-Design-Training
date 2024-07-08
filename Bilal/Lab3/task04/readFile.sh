#!/bin/bash

if [ ! -f "content.txt" ]; then
    echo "File doesn't exist"
    exit 1
else
    echo "Found"
fi
i=0
while read -r line; #We use the read command with -r argument to read the contents without escaping the backslash character.
do                   
    echo "Line $i: $line"
    ((i++))

done < $1   #$1  is file name given in the terminal as an argument


