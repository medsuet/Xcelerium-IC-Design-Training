num=$((RANDOM % 10 + 1))
read -p "Guess the number between 1 and 10: " guess
while [ $guess -ne $num ]
do
    if [ $guess -lt $num ]; then
    echo "Try bigger number."
    elif [ $guess -gt $num ]; then
    echo "Try smaller number."
    fi
    read -p "Guess the number between 1 and 10: " guess

done
echo "You did it."