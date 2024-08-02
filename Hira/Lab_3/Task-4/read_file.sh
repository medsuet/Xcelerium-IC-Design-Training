#!/bin/bash

file_name='read_file.txt'

if [ -r "$file_name" ]; then
	temp=0
	while read -r LINE;do
		temp=$((temp+1))
		echo "line: $temp $LINE"
	done < "$file_name"
else
	echo "file is not readable or file does not exist"

fi

