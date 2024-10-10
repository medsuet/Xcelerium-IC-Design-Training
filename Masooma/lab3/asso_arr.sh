#!/bin/bash
declare -A arr_asso #tells Bash to use an associative array, enabling the use of string keys
arr_asso[Pakistan]="Islamabad"
arr_asso[India]="Mumbai"
arr_asso[China]="Beijing"
capital(){
    local count=0
    for key in "${!arr_asso[@]}"
    do
        if [ "${arr_asso[$1]}" == "${arr_asso[$key]}" ]; then
            echo "Capital of $key is ${arr_asso[$key]}"
            count=1
            break
        fi
    done
    if [ $count -eq 0 ]; then
        echo "Capital of $1 not found"
    fi
}
echo $(capital Pakistan)
echo $(capital Turkey)