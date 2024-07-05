#!/bin/bash

file='logfile.txt'
declare -A array
LINE_NO=1
while read CURRENT_LINE; do
    arrar+=(CURRENT_LINE)
    echo "$CURRENT_LINE" 
    ((LINE_NO++))
done < "$file"


