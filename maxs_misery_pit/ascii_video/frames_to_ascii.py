from PIL import Image
import os

import re

def tryint(s):
    try:
        return int(s)
    except:
        return s

def alphanum_key(s):
    """ Turn a string into a list of string and number chunks.
        "z23a" -> ["z", 23, "a"]
    """
    return [ tryint(c) for c in re.split('([0-9]+)', s) ]

def sort_nicely(l):
    """ Sort the given list in the way that humans expect.
    """
    l.sort(key=alphanum_key)


if not os.path.isdir("ascii_frames"):
  os.mkdir("ascii_frames")

frames = os.listdir('frames')
sort_nicely(frames)


chars_string = " `.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#$Bg0MNWQ%&@"
chars = []

for char in chars_string:
    chars.append(char)


frame_num = 0

for frame in frames:
    frame_chars = []

    im = Image.open("frames/{}".format(frame), 'r')
    width, height = im.size

    rgb_vals = list(im.getdata())
    brightness_vals = []

    lowest_brightness = 255
    highest_brightness = 0

    for pixel in rgb_vals:
        red = pixel[0] * 0.2126
        green = pixel[1] * 0.7152
        blue = pixel[2] * 0.0722

        brightness = int(red + green + blue)

        if brightness < lowest_brightness:
            lowest_brightness = brightness

        if brightness > highest_brightness:
            highest_brightness = brightness

        brightness_vals.append(brightness)

    # Shift range down to lowest value of 0
    highest_brightness -= lowest_brightness
    lowest_brightness = 0

    range_divider = 255/(255 / highest_brightness)

    brightness_multiplier = ( 70/(255/( 255/highest_brightness )) )

    pos = 0

    frame_file = open("ascii_frames/frame{}".format(frame_num), "a")

    for y in range(int(height/2)):
        line = ""
        for x in range(width):
            char = int(brightness_multiplier * brightness_vals[pos])
            pos += 1

            line += chars[char]

        pos += width
        
        line += "\n"

        frame_file.write(line)
        
    
    print("Frame {}".format(frame_num))
    frame_num += 1