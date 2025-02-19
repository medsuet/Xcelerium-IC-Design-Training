tolerance = 0.16

# Open both files and read line by line
with open("build/output_file.txt") as file1, open("build/sv_outputs.txt") as file2:
    for line_num, (line1, line2) in enumerate(zip(file1, file2), start=1):
        # Split the line into numbers and convert to floats
        values1 = list(map(float, line1.split()))
        values2 = list(map(float, line2.split()))

        # Ensure both lines have the same number of values
        if len(values1) != len(values2):
            print(f"Line {line_num} length mismatch: {len(values1)} vs {len(values2)}")
            continue

        # Compare numbers field-by-field
        for idx, (val1, val2) in enumerate(zip(values1, values2), start=1):
            rounded1 = round(val1, 2)
            rounded2 = round(val2, 2)
            diff = abs(rounded1 - rounded2)
            diff = round(diff, 2)
            if diff > tolerance:
                print(f"Mismatch at line {line_num}, field {idx}: {rounded1:.2f} vs {rounded2:.2f} with diff {diff}")
               
