#!/bin/bash
rem=$(($1%2))
if [ $rem -eq 0 ]; then
    echo "It's even"
else
    echo "It's odd"
fi