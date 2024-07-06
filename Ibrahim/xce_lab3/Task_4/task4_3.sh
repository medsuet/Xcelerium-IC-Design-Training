#!/bin/bash

# Configuration file
CONFIG_FILE="config.txt"

# Read the directory path from the configuration file
DIR_TO_BACKUP=$(cat "$CONFIG_FILE")

# Check if the directory exists
if [ ! -d "$DIR_TO_BACKUP" ]; then
    echo "Error: Directory '$DIR_TO_BACKUP' does not exist."
    exit 1
fi

# Get the current date
CURRENT_DATE=$(date +%Y%m%d)

# Name of the backup file
BACKUP_FILE="backup_${CURRENT_DATE}.tar.gz"

# Create the backup
tar -czf "$BACKUP_FILE" -C "$(dirname "$DIR_TO_BACKUP")" "$(basename "$DIR_TO_BACKUP")"

# Check if the tar command succeeded
if [ $? -eq 0 ]; then
	echo "Backup of '$DIR_TO_BACKUP' created successfully as '$BACKUP_FILE'."
	else
	echo "Error: Failed to create backup."
	exit 1
fi

