#!/bin/bash

#Function to display the usage 
usage(){
    echo "Usage! $0 <directory_to_be_backup> <Destination_of_backup>"
    exit 1

}


# Checking the correct Usage 
 # Check if the correct number of arguments is provided

if [ $# -ne 2 ]; then
    usage
fi

#Assigning the arguments to the variables 
directory_to_backup="$1"
backup_destination="$2"

#checking if the directory to be backup exists or not
if [ ! -d "$directory_to_backup" ]; then
    echo "Error! The directory $directory_to_backup does not exist"
    exit 1
fi

#Creating the backup file with name of current date
current_date=$(date +%Y-%m-%d)
backup_filename="$(basename "$directory_to_backup")-backup-$current_date.tar.gz"

#Full Pathnto the backup file
backup_file_path="$backup_destination/$backup_filename"

#creating the backup

tar -cpPzf "$backup_file_path"  "$directory_to_backup"
#This is basically telling tar to create (-c) a gunzipped (-z) back up file (-f)
# preserving permissions (-p), using absolute file names (-P) basically not stripping "/" from the beginning of the file name

#Check if the backup wa successful

if [ $? -eq 0 ]; then 
    echo "Backup Successful! File created : $backup_file_path"
else 
    echo "Backup Failed" 
    exit 1
 fi
