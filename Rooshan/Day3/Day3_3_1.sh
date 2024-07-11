#!/bin/bash
declare -i product=1
factorial ()
{
    if [[ $1 -eq 0 || $1 -eq 1 ]]
    then
	    product=$((product*1))
	    echo $product
	    product=1
    else
	    product=$(( $1*product ))
	    var=$(( $1-1 ))
	    factorial $var
    fi
}
factorial 5
factorial 6
