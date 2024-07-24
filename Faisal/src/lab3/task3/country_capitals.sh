#!/bin/bash

# Create an associative array of country-capital pairs
declare -A country_capitals=(
  ["Pakistan"]="Islamabad"
  ["France"]="Paris"
  ["Germany"]="Berlin"
  ["Japan"]="Tokyo"
  ["India"]="New Delhi"
)

# Function to ask the user for a country and return its capital
get_capital() {
  local country=$1

  # Check if the country exists in the array
  if [[ -v country_capitals["$country"] ]]; then
    echo "The capital of $country is ${country_capitals["$country"]}."
  else
    echo "Error: The country '$country' is not in the list."
  fi
}

# Ask the user for a country and call the function
read -p "Enter a country: " user_country
get_capital "$user_country"
