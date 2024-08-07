#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 <directory_to_backup>"
  exit 1
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
  echo "Please enter the name of file that you want to backup"
  usage
fi

# Directory to backup
DIR="$1"

# Check if the directory exists
if [ ! -d "$DIR" ]; then
  echo "Error: Directory $DIR does not exist."
  exit 1
fi

# Get the current date
DATE=$(date +%Y-%m-%d)

# Backup file name
BACKUP_FILE="${DIR%/}-backup-$DATE.tar.gz"

# Create the backup
tar -czf "$BACKUP_FILE" "$DIR"

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_FILE"
else
  echo "Error: Backup failed."
  exit 1
fi
