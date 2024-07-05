#!/bin/bash


printf 'Reading the file line by line\n'
printf '\n'
i=1
while read -r line; #We use the read command with -r argument to read the contents without escaping the backslash character.
do                   
    printf '%s. %s\n' "$i" "$line" 
    ((i++))

done < $1   #$1  is file name given in the terminal as an argument

echo ""
echo "=================================================================="
echo ""
printf 'Processing the File '
echo ""


# Check if the second argument is provided
if [ -z "$2" ]; then
    echo "Usage: $0 <arg1> log_file.log"
    exit 1
fi 

logfile="$2"

# Count the total number of entries
number_of_entries=$(wc -l < "$logfile")
printf 'The total number of entries in the log file are: %i\n' "$number_of_entries"

echo ""
printf 'Unique Usernames:\n'
# Correct the delimiter to space in the cut command
cut -d ' ' -f 2 "$logfile" | sort | uniq

echo ""
printf 'Unique Actions per user:\n'
cut -d ' ' -f 2,3 "$logfile" | sort | uniq | while read -r user action
do
    # Check if the user or action is empty, skip if it is
    if [ -n "$user" ] && [ -n "$action" ]; then
        action_count=$(grep -c "$user $action" "$logfile")
        printf '%s - %s: %i\n' "$user" "$action" "$action_count"
    fi
done

echo ""
echo "=================================================================="
echo ""
