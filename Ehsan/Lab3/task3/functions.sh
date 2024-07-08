#!/bin/bash
factorial() {
local temp=1
    for((i=1; i<=$1; i++)); do
        temp=$((temp * i))
    done
    echo "factorial is $temp"
}

factorial 5

