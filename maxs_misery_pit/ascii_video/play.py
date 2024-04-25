import os
import time

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


frames = os.listdir('ascii_frames')
sort_nicely(frames)



frame_list = []

for frame in frames:
    frame_file = open("ascii_frames/{}".format(frame), "r")
    frame_contents = frame_file.read()

    frame_list.append(frame_contents)
    
    frame_file.close()


while True:
    for frame in frame_list:
        os.system("clear")

        print(frame)

        time.sleep(.033)