#!/bin/bash
backup_dir="/home/masooma/masoom"
dest_dir="/home/masooma/dest"
# Check if backup directory exists
if [ ! -d "$backup_dir" ]; then #This line checks if $backup_dir does not exist
    echo "Error: Directory $backup_dir does not exist or is not accessible."
    exit 1
fi
backup_file="backup_$(date +'%Y-%m-%d').tar.gz"
tar -czf "$dest_dir/$backup_file" -C "$backup_dir" .

