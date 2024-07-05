#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 directory_name"
    exit 1
fi

# Check if the directory exists
if [ -d "$1" ]; then
    # Create a backup
    tar -czf "backup_$(date +%F).tar.gz" "$1"
    if [ $? -eq 0 ]; then
        echo "Backup created successfully."
    else
        echo "Failed to create backup."
    fi
else
    echo "Directory $1 does not exist."
fi
