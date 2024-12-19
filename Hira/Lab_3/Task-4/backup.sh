#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <directory_to_backup>"
    exit 1
}

# Checking if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    usage
fi

# Directory to backup
dir_to_backup=$1

# Checking if the directory exists
if [ ! -d "$dir_to_backup" ]; then
    echo "Error: Directory $dir_to_backup does not exist."
    exit 1
fi

# Geting the current date
current_date=$(date +%Y-%m-%d)

# Createing the backup file name
backup_file="${dir_to_backup%/}_backup_$current_date.tar.gz"

# Createing the compressed tar file
tar -czf "$backup_file" -C "$dir_to_backup" .

# Checking if the tar command was successful
if [ "$?" -eq 0 ]; then
    echo "Backup successful: $backup_file"
else
    echo "Error: Backup failed."
    exit 1
fi

