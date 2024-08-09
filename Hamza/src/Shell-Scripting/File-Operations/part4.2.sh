#!/bin/bash 

# Count the total number of entries
total_entries=$(wc -l < log.txt)
echo "Total entries: $total_entries"

# List unique usernames
echo "Unique usernames:"
cut -d ' ' -f 2 log.txt | sort | uniq

# Count actions per user
echo "Actions per user:"
cut -d ' ' -f 2,3 log.txt | sort | uniq -c
