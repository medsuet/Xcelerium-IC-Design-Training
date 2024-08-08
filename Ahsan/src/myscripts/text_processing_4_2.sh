#!/bin/bash

# this is for accessing the log file i made
logfile="log.txt"

#counting total number of entries for that we using wc -l
total_entries=$(wc -l < "$logfile")
echo "so total number of entries are: $total_entries"

#now finding unique username by using piped commands
echo "unique usernames"
awk '{print $2}' "$logfile" | sort | uniq

echo "action per user"
awk '{count[$2]++} END {for (user in count) print user, count[user]}' "$logfile"


