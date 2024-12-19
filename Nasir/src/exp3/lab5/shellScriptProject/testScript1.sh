#!/bin/bash

output=$(./script1.sh)
expected_output="This is script 1"

if [ "$output" == "$expected_output" ]; then
    echo "script1.sh passed"
else
    echo "script1.sh failed"
    exit 1
fi
