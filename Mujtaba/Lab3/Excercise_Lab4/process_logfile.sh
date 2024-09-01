#!/usr/bin/env bash
logfile="$1"

# Print the total entries in the file.
total_entries=$(wc -l < $logfile)
echo Total Entries in $logfile is $total_entries.
echo " "

# List unique usernames in the file.
echo Unique Usernames in $logfile are:
awk '{print $2}' "$logfile" | sort | uniq
echo " "

# Counts action per user
echo Action Counts per user of $logfile are:
awk '{print $2, $3}' "$logfile" | sort | uniq -c | awk '{print $2, $3 ":" $1}'
