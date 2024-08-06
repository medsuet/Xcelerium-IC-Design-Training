#!/usr/bin/env bash

backup_dir="$1"

if [ ! -d "$backup_dir" ]; then
    echo "'$1' doesn't exists or may be it's not directory."
    exit 1
fi

current_date=$(date +%F)

backup_file_name="$(basename "$backup_dir")_backup_$current_date.tar"

tar -czf "$backup_file_name" -C "$(dirname "$backup_dir")" "$(basename "$backup_dir")"

if [ "$?" -eq 0 ]; then
    echo "Backup successful: $backup_dir"
else
    echo "Backup failed."
    exit 1
fi
