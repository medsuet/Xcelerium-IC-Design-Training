#!/bin/bash

# Function to display usage information
usage() {
  echo "Usage: $0 <backup_file>"
  exit 1
}

# Check if the correct number of arguments is provided
if [ $# -ne 1 ]; then
  usage
fi

# Get the backup file
BACKUP_FILE=$1

# Check if the backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
  echo "Error: Backup file $BACKUP_FILE does not exist."
  exit 1
fi

# Extract the backup file
tar -xzf $BACKUP_FILE

# Verify if the extraction was successful
if [ $? -eq 0 ]; then
  echo "Backup $BACKUP_FILE restored successfully"
else
  echo "Error: Failed to restore backup"
  exit 1
fi
