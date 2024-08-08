#!/bin/bash
#this script takes path of directory from user as argument and make zip file of
#directory and give name to zip file, of its path and current date


backup_file() {
    if [ "$#" -ne 1 ]; then
        echo "too much arguments"
        exit 1
    fi
    local path=$1
    local date=$(date +%F)
    local file_name="$path_$date.tar.gz"

    tar -czvf "$file_name" "$path"

    if [ $? -eq 0 ]; then
        echo "Backup of '$1' created successfully as '$file_name'."
    else
        echo "Error: Backup failed."
        exit 1
    fi
}
backup_file "$1"

