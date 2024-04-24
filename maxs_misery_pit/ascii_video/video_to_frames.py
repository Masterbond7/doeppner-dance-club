import os
import cv2

if not os.path.isdir("frames"):
  os.mkdir("frames")

file = input("Filename: ")

vidcap = cv2.VideoCapture("videos/{}".format(file))
success,image = vidcap.read()
count = 0
while success:
  cv2.imwrite("frames/%d.jpg" % count, image)     # save frame as JPEG file      
  success,image = vidcap.read()
  print("Read a new frame: ", success)
  count += 1
