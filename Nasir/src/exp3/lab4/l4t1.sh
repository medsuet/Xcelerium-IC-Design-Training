#!/bin/bash

# Check if the file exists
# The flag ! -f checks if the file does not exist
if [[ ! -f "sample.txt" ]]; then
    echo "File sample.txt not found!"
    exit 1
fi

# Initialize a line counter
line_number=1

# Read the file line by line
# IFS= is the Internal Field Separator; setting it to empty prevents leading/trailing whitespace from being trimmed
# -r prevents backslashes from being interpreted as escape characters
while IFS= read -r line; do
    # Print the line with its line number
    echo "Line $line_number: $line"
    # Increment the line counter
    ((line_number++))
done < "sample.txt"
