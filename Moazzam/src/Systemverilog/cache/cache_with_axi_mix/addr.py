import random

# Open the file in write mode
with open('output.txt', 'w') as file:
    # Generate and write 100 random 32-digit hexadecimal numbers
    for _ in range(16):
        hex_number = ''.join(random.choices('0123456789abcdef', k=32))
        file.write(hex_number + '\n')

print("100 random 32-digit hexadecimal numbers have been written to output.txt.")
