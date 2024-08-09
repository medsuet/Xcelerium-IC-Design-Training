#!/bin/bash

backup_files="./backup-directory" #location of directory to create backup of

destination="./" #destination of tar file

#tar file names starts with time
date=$(date '+%Y-%m-%d') #date has 3 components, Y, m, d

hostname=$(hostname -s) # hostname for username
# archive file name starts with hostname + date
archive_file="$hostname-$date.tgz"

echo "Backing up $backup_files to $dest/$archive_file"
date # prints date
echo
# -d to check if directory exists
if [ -d $backup_files ]; then
    echo "Directory Found!"
    #Backing up files using tar
    tar czf $destination/$archive_file $backup_files
    #c for create, z for compression, f for specifying name

    echo
    echo 'Backup Finished'
    date
else
    echo "Error: Directory '$backup_files' does not exist."
    exit 1
fi