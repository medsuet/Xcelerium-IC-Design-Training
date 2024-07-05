#!/bin/bash 

# $# is for command line arguments
# $# -ne 2 is to check if user has not entered 2 arguments
if [ $# -ne 2 ]; then
    # $0 holds the name of script
    echo "Usage: $0 num1 num2"
    exit 1
fi

sum=$(($1 + $2))

echo "The sum of $1 and $2 is $sum"
