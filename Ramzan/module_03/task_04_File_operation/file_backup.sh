#!/bin/bash

directory="logs.txt"
#check if file is exist
if [ ! -f "$directory" ];then
	echo "Error:$directory doesnot exist."
	exit 1
fi
backup_file="back_$( date +'%Y-%m-%d').tar.gz"
#create backup and capture output
tar czf "$backup_file" "$directory"
#check if back was successfull
if [ $? -eq 0 ];then
	echo "Backup was successfull:$backup_file"
else
	echo "Failed to create backup"
fi
