#!/bin/bash 

count=1

# Sets the Internal Field Separator to an empty value, which prevents leading/trailing whitespace from being trimmed and allows reading lines with spaces intact.

while IFS= read -r line; 
    do
        echo "$count: $line"
        ((count++))
    done < content.txt
