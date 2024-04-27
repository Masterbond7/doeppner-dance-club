from PIL import Image
import os
import re
import math

#
# Sorting frames
#
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
else:
    frames_to_clear = os.listdir("ascii_frames")

    for frame in frames_to_clear:
        os.remove("ascii_frames/{}".format(frame))


frames = os.listdir('frames')
sort_nicely(frames)


#
# Setting character string
#
chars_string = " `.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#$Bg0MNWQ%&@"
chars = []

for char in chars_string:
    chars.append(char)

#
# Frame iteration
#
frame_num = 0

frames_len = len(frames)

video_file = open("ascii_frames/hehehehaw.asv", "ab")

# open frame and get its dimensions
im = Image.open("frames/0.jpg", 'r')
width, height = im.size

width_bytes = width.to_bytes(2, "little")
height_bytes = height.to_bytes(2, "little")

video_file.write(width_bytes)
video_file.write(height_bytes)

for frame in frames:
    print("Frame {}/{}".format(frame_num+1, frames_len))

    # open frame and get its dimensions
    im = Image.open("frames/{}".format(frame), 'r')

    # reset brightness values
    brightness_vals = []

    # return list of an rgb value for each pixel
    rgb_vals = list(im.getdata()) 

    #
    # remove every second line from rgb_vals
    #
    skip = 0

    for y in range( math.floor(height/2) ):
        skip += width # to skip a line

        for x in range(width): # iterate over entire line
            rgb_vals.pop(skip)
        
        
    lowest_brightness = 254
    highest_brightness = 0

    #
    # convert each rgb value into a brightness value
    #
    for pixel in rgb_vals:
        # funny maths to convert rgb --> brightness
        red = pixel[0] * 0.2126
        green = pixel[1] * 0.7152
        blue = pixel[2] * 0.0722

        brightness = round(red + green + blue)

        if brightness < lowest_brightness:
            lowest_brightness = brightness

        if brightness > highest_brightness:
            highest_brightness = brightness

        brightness_vals.append(brightness)

    # set the shifted brightness values. e.g. a range of 10-50 becomes 0-40
    shifted_lowest_brightness = 0
    shifted_highest_brightness = highest_brightness - lowest_brightness


    if shifted_highest_brightness == 0:
        brightness_multiplier = 0
    else:
        # shift all the brightness values
        for i in range(len(brightness_vals)):
            brightness_vals[i] -= lowest_brightness

        brightness_multiplier = (len(chars)-1)/shifted_highest_brightness


    #
    # Brightness value to ascii
    #

    pos = 0

    for y in range( math.floor(height/2)*width ):
        char = round( brightness_multiplier*brightness_vals[pos] ) 
        byte = chars[char].encode()

        video_file.write(byte)

        pos += 1

    
    frame_num += 1
video_file.close()