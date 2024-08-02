#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Usage: $0 <num>"
	exit 1
fi

num=$1

if [ $((num % 2)) -eq 0 ]; then
	echo "$num is even "
else
 	echo "$num is odd"

fi

