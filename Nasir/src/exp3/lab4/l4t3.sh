#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 <directory_to_backup>"
  exit 1
}

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
  usage
fi

# Get the directory to backup
DIR_TO_BACKUP=$1

# Check if the directory exists
if [ ! -d "$DIR_TO_BACKUP" ]; then
  echo "Error: Directory $DIR_TO_BACKUP does not exist."
  exit 1
fi

# Get the current date
CURRENT_DATE=$(date +%Y-%m-%d)

# Create the backup filename
BACKUP_FILENAME="${DIR_TO_BACKUP##*/}_backup_$CURRENT_DATE.tar.gz"

# Create the compressed tar file
tar -czf $BACKUP_FILENAME $DIR_TO_BACKUP

# Verify if the backup was created successfully
if [ $? -eq 0 ]; then
  echo "Backup of $DIR_TO_BACKUP created successfully as $BACKUP_FILENAME"
else
  echo "Error: Failed to create backup"
  exit 1
fi
