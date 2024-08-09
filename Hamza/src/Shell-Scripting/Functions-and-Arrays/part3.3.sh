#!/bin/bash 

declare -A capitals=(["USA"]="Washington" ["France"]="Paris" ["Japan"]="Tokyo")

get_capital() {
    read -p "Enter a country: " country
    if [[ -v capitals[$country] ]]; then
        echo "The capital of $country is ${capitals[$country]}"
    else
        echo "No data for $country"
    fi
}

get_capital