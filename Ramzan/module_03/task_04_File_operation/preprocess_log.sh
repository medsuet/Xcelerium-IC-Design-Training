#!/bin/bash
log_file="logs.txt"
total_entries=$(wc -l < "$log_file")
echo "Total number of entries:$total_entries"
#Lists unique usernames
echo "username are:"
awk '{print $2}' "$log_file" | sort | uniq

echo "Counts actions per user:"
awk '{print $2}' "$log_file" | sort | uniq -c
