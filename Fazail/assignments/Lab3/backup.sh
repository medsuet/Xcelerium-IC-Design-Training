#!/bin/bash

read -p "Enter the directory address which you want to backup " DIR

backup="$DIR"
day=$(date +%F)        #This is just a day vaiable YYYY-MM-DD

if [ -d $DIR ]
then
    echo "Directory exists."
    tar -czf $day.tar $backup
else 
    echo "Directory is not exists."
fi

# -czvf create new archive, compress(archive using gzip)
# verbose(prints the files on terminal) file_name (of archive file)
