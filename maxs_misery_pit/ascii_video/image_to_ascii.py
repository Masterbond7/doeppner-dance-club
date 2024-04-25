from PIL import Image

file = input("Filename: ")

im = Image.open('images/{}'.format(file), 'r')
width, height = im.size

rgb_vals = list(im.getdata())
brightness_vals = []

chars_string = " `.-':_,^=;><+!rc*/z?sLTv)J7(|Fi{C}fI31tlu[neoZ5Yxjya]2ESwqkP6h9d4VpOGbUAKXHm8RD#$Bg0MNWQ%&@"
chars = []

for char in chars_string:
    chars.append(char)


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

print("lowest brightness: ", lowest_brightness)
print("highest brightness: ", highest_brightness)

# Shift range down to lowest value of 0
highest_brightness -= lowest_brightness
lowest_brightness = 0

range_divider = 255/(255 / highest_brightness)

brightness_multiplier = ( 70/(255/( 255/highest_brightness )) )
print (brightness_multiplier)

pos = 0

for y in range(int(height/2)):
    line = ""
    for x in range(width):
        char = int(brightness_multiplier * brightness_vals[pos])
        pos += 1

        line += chars[char]

    pos += width

    print(line)