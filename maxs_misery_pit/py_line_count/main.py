path = input("File path: ")

file = open(path, "r")
lines = file.readlines()

line_count = 0

for line in lines:
    split = line.split(";")
    
    stripped = split[0].strip()

    if stripped != "":
        line_count += 1

print("Your code has {} lines of actual code".format(line_count))