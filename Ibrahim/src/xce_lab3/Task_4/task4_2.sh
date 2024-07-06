#!/bin/bash
LOGFILE="logfile.txt"

# a. Counts the total number of entries
total_entries=$(wc -l < "$LOGFILE")
echo "Total number of entries: $total_entries"

# b. Lists unique usernames
unique_usernames=$(awk '{print $2}' "$LOGFILE" | sort | uniq)
echo "Unique usernames:"
echo "$unique_usernames"

# c. Counts actions per user
echo "Actions per user:"
awk '{print $2}' "$LOGFILE" | sort | uniq -c

