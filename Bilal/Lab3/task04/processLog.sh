#!/bin/bash

# Check if the file exists
if [ ! -f "logFile.log" ]; then
    echo "File 'logFile.log' not found."
    exit 1
    else
    echo "found"
fi

# Task 2a: Count the total number of entries
total_entries=$(wc -l < logFile.log)
echo "Total number of entries: $total_entries"

# Task 2b: List unique usernames
unique_usernames=$(awk '{print $2}' logFile.log | sort -u)
echo "Unique usernames:"
echo "$unique_usernames"

# Task 2c: Count actions per user
echo "Actions per user:"
while read -r username; do
    count=$(grep -c "$username" logFile.log)
    echo "$username: $count"
done <<< "$unique_usernames"

