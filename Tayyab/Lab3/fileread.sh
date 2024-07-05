#!/bin/bash
# Reads a file line by line and prints with line number.
i=0
while read line;
do
    echo "Line $i: $line"
    i=$(($i+1))
done < textfile.txt