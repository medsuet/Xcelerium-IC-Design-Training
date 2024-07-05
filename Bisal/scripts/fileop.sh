#  ============================================================================
#  Filename:    fileop.sh 
#  Description: File consists of codes based on concepts of linuxshellscripting
#  Author:      Bisal Saeed
#  Date:        7/3/2024
#  ============================================================================

#NOTE: run using command : ./scripts/fileop.sh

#!/bin/bash

#Check if file exists by ! -f returning True if it does noy exist, if not 
#create a new file 
echo "PART 4.1 : FILE READING" 

example="scripts/example.txt"
if [ ! -f "$example" ]; then 
	echo "File $example not found."
	#exit status 1 used in BASH to indicate the error and 0 means success
	exit 1
fi
#cat the contents of file and store it in a variable 
file_content=$(cat "$example")
# Print the entire file content
echo "$file_content"
echo " "


echo "PART 4.2 : TEXT PROCESSING"

logfile="scripts/logfile.txt"

# Check if the logfile exists
if [ ! -f "$logfile" ]; then
    echo "File $logfile not found."
    exit 1
fi

# Total number of entries
#wc used to count and -l specifies to count lines , > takes contents from log file 
total_entries=$(wc -l < "$logfile")
echo "Total number of entries: $total_entries"

# List unique usernames
# Extracts the second field (username) from each line of $logfile using awk.
# Sorts the extracted usernames alphabetically using sort
# Filters out duplicate usernames, retaining only unique ones using uniq

unique_usernames=$(awk '{print $2}' "$logfile" | sort | uniq)
echo "Unique usernames:"
echo "$unique_usernames"

# Count actions per user
echo "Actions per user:"
declare -A actions_count
#used to store usernames as keys and their corresponding action counts as values.
while read -r date username action; do
    # Increment action count for each username
    ((actions_count[$username]++))
done < "$logfile"

# Print action counts
for username in "${!actions_count[@]}"; do
    echo "User '$username' performed ${actions_count[$username]} actions."
done
echo " "

echo "PART 4.3 : FILE BACKUP" 
#LOGIC: create a backup file with date and name of file then backup file using tar 
#check if backup is done successfully by if else conditions

dirBackUp="scripts"
#create a backup folder as destination to save file
backUpFolder="/home/bisal/xcelerium"
mkdir -p "$backUpFolder"

curDate=$(date +%Y-%m-%d)

#creates a backup file with directory name and current date to make backup clean 
#with tar and zip extensions

backUpFile="$backUpFolder/${dirBackUp}_backup$curDate.tar.gz"

# czf selects option to create,zip and name file and atr backups all files and directories
tar -czf "$backUpFile" "$dirBackUp"

#$? to check status of last command if it equals 0 (failed) or not 
if [ $? -eq 0 ]; then
       echo "Backup done successfully."	
else
	echo "Error: Backup failed."
	exit 1
fi 


