#!/bin/bash

line_num=1
while read -r line; do
    echo "$((line_num++)): $line"
done < "$1"
echo "$((line_num++)): $line"



logfile="log.txt"

# Count total number of entries
total_entries=$(wc -l < "$logfile")
echo "Total number of entries: $((total_entries+1))"

# List unique usernames
echo -n "Unique usernames: "
awk '{print $2}' "$logfile" | sort | uniq | tr '\n' ' '
echo ""

# Count actions per user
echo "Actions per user:"
awk '{print $2}' "$logfile" | sort | uniq | while read -r user; do
    count=$(grep -c " $user " "$logfile")
    echo "  $user: $count"
done


# Check if a directory was provided as an argument
if [ -z "$2" ]; then
    echo "Usage: $0 <directory_to_backup>"
    exit 1
fi

directory=$2

# Check if the specified directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory $directory does not exist."
    exit 1
fi

# Get the current date in YYYY-MM-DD format
current_date=$(date +%Y-%m-%d)

# Create the backup filename
backup_filename="${directory}_backup_$current_date.tar"

# Create the backup
tar -czf "$backup_filename" -C "$(dirname "$directory")" "$(basename "$directory")"

if [ $? -eq 0 ]; then
    echo "Backup successful: $backup_filename"
else
    echo "Error: Backup failed."
    exit 1
fi
