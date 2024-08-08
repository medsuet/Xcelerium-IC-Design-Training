#!/bin/bash

# Specify the directory to back up
DIRECTORY_TO_BACKUP="$1"

# Check if the directory exists
if [ ! -d "$DIRECTORY_TO_BACKUP" ]; then
    echo "Error: The directory '$DIRECTORY_TO_BACKUP' does not exist."
    exit 1
fi

# Generate a backup file name with the current date
BACKUP_FILE="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Create a compressed tar file containing the contents of the directory
tar -czf "$BACKUP_FILE" "$DIRECTORY_TO_BACKUP" 2> /dev/null

# Check if the tar command was successful
if [ $? -eq 0 ]; then
    echo "Backup of '$DIRECTORY_TO_BACKUP' was successful. File created: $BACKUP_FILE"
else
    echo "Error: Failed to create backup."
    exit 1
fi

