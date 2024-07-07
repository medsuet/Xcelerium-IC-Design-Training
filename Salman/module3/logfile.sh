#!/bin/bash

# $= prints line number of last line in the file logfile.txt
echo "Total number of entries: $(sed -n '$=' logfile.txt)"

