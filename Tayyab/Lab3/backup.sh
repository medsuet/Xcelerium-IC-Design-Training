#!/bin/bash
# Compresses ../Lab1 directory in tar
if !(tar -cvf a.tar -C ~/Lab6 .)
then
    echo "Notice: File not found"
fi
