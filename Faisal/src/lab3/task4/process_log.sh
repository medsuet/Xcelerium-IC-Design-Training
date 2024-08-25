#!/bin/bash

# File to process
FILE="log.txt"

# Check if file exists
if [[ ! -f "$FILE" ]]; then
  echo "File not found!"
  exit 1
fi

# Part a: Count the total number of entries
total_entries=$(wc -l < "$FILE")
echo "Total number of entries: $total_entries"

# Part b: List unique usernames
unique_usernames=$(awk '{print $2}' "$FILE" | sort | uniq)
echo "Unique usernames:"
echo "$unique_usernames"

# Part c: Count actions per user
echo "Actions per user:"
awk '{actions[$2]++} END {for (user in actions) print user ": " actions[user]}' "$FILE"
