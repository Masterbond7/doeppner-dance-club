import os
import cv2

import re
import moviepy.editor as mp

rows_string, columns_string = os.popen('stty size', 'r').read().split()
rows = int(rows_string)
columns = int(columns_string)

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


if not os.path.isdir("frames"):
  os.mkdir("frames")
else:
    frames_to_clear = os.listdir("frames")

    for frame in frames_to_clear:
        os.remove("frames/{}".format(frame))

videos = os.listdir("videos")
sort_nicely(videos)

count = 1
for file in videos:
   print("{}: {}".format(count, file))
   count += 1

video = videos[ int(input("Select video: "))-1 ]

split_name = video.split(".")
scaled_name = "videos/scaled.{}".format(split_name[1])


vid = cv2.VideoCapture("videos/{}".format(video))
video_height = vid.get(cv2.CAP_PROP_FRAME_HEIGHT)
video_width = vid.get(cv2.CAP_PROP_FRAME_WIDTH)



clip = mp.VideoFileClip("videos/{}".format(video))

if video_height > video_width:
  clip_resized = clip.resize(height=rows*2)
else:
   clip_resized = clip.resize(width=columns)

clip_resized.write_videofile(scaled_name)


vidcap = cv2.VideoCapture(scaled_name)
success,image = vidcap.read()
count = 0
while success:
  cv2.imwrite("frames/%d.jpg" % count, image)     # save frame as JPEG file      
  success,image = vidcap.read()
  print("Frame {}".format(count+1))
  count += 1
