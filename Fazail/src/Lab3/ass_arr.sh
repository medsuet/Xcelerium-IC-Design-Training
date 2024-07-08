#!/bin/bash

# Declare the associative array
declare -A country_capital

country_capital["Pakistan"]="Islamabad"
country_capital["India"]="Delhi"
country_capital["Bangladesh"]="Dhaka"

echo "You can type the given countries : "
for key in "${!country_capital[@]}"; do
    echo "$key"
done

echo " "

# Function to get the capital of a country
function country_capital_pairs() {
    read -p "Write the country name: " COUNTRY
    echo " "
    echo "The capital of the country is ${country_capital[${COUNTRY}]}"
}

# Call the function
country_capital_pairs
