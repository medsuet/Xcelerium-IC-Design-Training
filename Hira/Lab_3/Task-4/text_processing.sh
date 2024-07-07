#!/bin/bash

log_file="log_file.txt"

if [ ! -f "$log_file" ]; then 
	echo "Log file $log_file does not exist"
	exit 1
fi


#Counting the entries
entries=$(wc -l < "$log_file")
echo "Total number of entries: $entries"


#unique users
awk '{print $2}' "$log_file" | sort | uniq

#c
echo "actions per user"

awk '{print $2}' "$log_file" | sort | uniq | while read -r user; do
	count=$(grep -c "$user" "$log_file")
	echo "$user: $count actions"
done
