#!/bin/bash
# Calculates factorial of argument 1.
function fact() {
    if [[ $1 == 0 ]]
    then
        echo "${2:-1}"
        # ${2:1} : If $2 was assigned a value, use it. Else use 1
    else
        fact $(($1 - 1)) $(($1*${2:-1}))
    fi
}

fact 0
fact 6
fact 5
fact 3
fact 9