#!/bin/bash

# Simple unit test for script1.sh and script2.sh

output1=$(./script1.sh)
if [ "$output1" == "This is script1" ]; then
    echo "script1.sh passed"
else
    echo "script1.sh failed"
    exit 1
fi

output2=$(./script2.sh)
if [ "$output2" == "This is script2" ]; then
    echo "script2.sh passed"
else
    echo "script2.sh failed"
    exit 1
fi
