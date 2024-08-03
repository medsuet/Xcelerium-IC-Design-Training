#!/bin/bash

# Check if the log file exists
# The flag ! -f checks if the file does not exist
if [[ ! -f "logfile.txt" ]]; then
    echo "Log file logfile.txt not found!"
    exit 1
fi

# a. Count the total number of entries
# wc -l counts the number of lines in the file
total_entries=$(wc -l < logfile.txt)
echo "Total number of entries: $total_entries"

# b. List unique usernames
echo "Unique usernames:"
# awk '{print $2}' extracts the second field (username) from each line
# sort sorts the usernames alphabetically
# uniq removes duplicate usernames
awk '{print $2}' logfile.txt | sort | uniq

# c. Count actions per user
echo "Actions per user:"
# awk '{print $2}' extracts the second field (username) from each line
# sort sorts the usernames alphabetically
# uniq removes duplicate usernames
# while read -r user iterates over each unique username
awk '{print $2}' logfile.txt | sort | uniq | while read -r user; do
    # grep -c " $user " counts the number of lines containing the username in the file
    action_count=$(grep -c " $user " logfile.txt)
    echo "$user: $action_count actions"
done
