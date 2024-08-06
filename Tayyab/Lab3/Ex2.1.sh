#!/bin/bash
# Outputs is argument 1 is even
if [ `expr $1 % 2` == 0 ] 
then
    echo "$1 is even"
else
    echo "$1 is odd"
fi