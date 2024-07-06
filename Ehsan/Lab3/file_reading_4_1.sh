#!/bin/bash

#file that reads line and add line no to it

file='test.txt'
LINE_NO=1
while read CURRENT_LINE; do
    echo "Line no.$LINE_NO : $CURRENT_LINE"
    ((LINE_NO++))
done < "$file"



