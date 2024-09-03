#!/bin/bash

target=$(( RANDOM % 10 + 1 ))
guess=0

while [ $guess -ne $target ]; do

    read -p "Enter number : " guess

    if [ $guess -eq $target ] ; then

        echo "correct"

    elif [ $guess -lt $target ]; then

        echo "not corret try low"

    elif [ $guess -gt $target ]; then

        echo "not correct try high"

    fi
done
