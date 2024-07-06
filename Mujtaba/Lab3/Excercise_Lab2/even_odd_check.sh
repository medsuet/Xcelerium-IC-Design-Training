#!/usr/bin/env bash
reminder=$(expr $1 % 2)
if [ $reminder -ne 0 ]; then
    echo $1 is an odd number.
else 
    echo $1 is an even number.
fi
