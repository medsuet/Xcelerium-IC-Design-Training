#!/bin/bash

backup_files="/home/salman/work/xcelerium/training/Salman-Xcelerium-IC-Design-Training/Salman/module3/backup-directory" #location of directory to create backup of

destination="/home/salman/work/xcelerium/training/Salman-Xcelerium-IC-Design-Training/Salman/module3" #destination of tar file

#tar file names starts with time
date=$(date '+%Y-%m-%d')

hostname=$(hostname -s)

archive_file="$hostname-$date.tgz"

echo "Backing up $backup_files to $dest/$archive_file"
date
echo

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