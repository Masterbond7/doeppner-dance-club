import os

path = "ascii_frames/hehehehaw.asv"

os.remove(path)

width = 21
height = 6

width_bytes = width.to_bytes(1, "little")
height_bytes = height.to_bytes(1, "little")

file = open(path, "ab")

file.write(width_bytes)
file.write(height_bytes)

file.close()