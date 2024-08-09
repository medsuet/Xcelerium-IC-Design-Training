#!/bin/bash

factorial()
{
    if (( $1 <= 1 )); then # base case
        echo 1
    else
        echo $(( $1 * $(factorial $(($1-1 )) ) )) # recursive call
    fi
}

factorial $1
