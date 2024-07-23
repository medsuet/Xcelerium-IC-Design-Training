#!/bin/bash 

if [ $# -ne 1 ]; then
    echo "Usage: $0 num1"
    exit 1
fi


if [ $(($1 % 2)) -eq 0 ]; then
    echo "$1 is even"
else
    echo "$1 is odd"
fi