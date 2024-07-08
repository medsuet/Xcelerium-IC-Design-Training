#!/bin/bash

#Defining an associative array
declare -A capitals=(
    ["Pakistan"]="Islamabad"
    ["India"]="Dehli"
    ["China"]="Beijing"
    ["Iran"]="Tehran"
    ["Russia"]="Moscow"
    ["Afghanistan"]="Kabul"
    ["Spain"]="Madrid"
    ["France"]="Paris"
    ["Germany"]="Berlin"
    ["Italy"]="Rome"
    ["Japan"]="Tokyo"
)

# Function to ask user for a country and return its capital
get_capital() {
    read -p "Enter a country: " country

    # Check if the country exists in the array
    if [ -n "${capitals[$country]}" ]; then
        echo "The capital of $country is ${capitals[$country]}"
    else
        echo "Capital for '$country' not found."
    fi
}

# Call the function to get the capital of a country
get_capital

