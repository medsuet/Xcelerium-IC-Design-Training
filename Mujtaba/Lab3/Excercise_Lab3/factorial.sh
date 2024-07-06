#!/usr/bin/env bash
factorial(){
    n=$1
    if [ $n -eq 0 ] || [ $n -eq 1 ]; then
        echo 1
    else
        temp=$(($n-1))
        echo $(($n*$(factorial $temp)))
    fi
}
echo The factorial of $1 is $(factorial $1)
