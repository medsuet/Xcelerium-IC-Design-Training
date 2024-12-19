#!/bin/bash

output=$(./script2.sh)
expected_output="This is script 2"

if [ "$output" == "$expected_output" ]; then
    echo "script2.sh passed"
else
    echo "script2.sh failed"
    exit 1
fi
