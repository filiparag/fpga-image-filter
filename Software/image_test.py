#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt


image = np.zeros((15,15))

for x in range(len(image)):
    for y in range(len(image[0])):
        image[x][y] = int((x / (len(image) - 1) + y / (len(image) - 1)) * 127)


def decode(file):

    columns = file.split('\n')[:-1]

    image = np.zeros((len(columns), len(columns)), dtype=np.uint8)

    for c in range(len(columns)):
        column = list(columns[c])
        for p in range(0, len(column), 8):
            pixel = np.packbits(list(map(lambda x: int(x), column[p:p+8])))[0]
            image[c][p // 8] = pixel

    image = np.flip(image.T, axis=1)
    return image


with open('image_test.in', 'r') as file:
    image_out = decode(file.read())
    
print ('Error percentage: ' + str(round(len(np.setdiff1d(image_out, image)) / image.size, 2)) + ' %')
print ('Error count: ' + str(len(np.setdiff1d(image_out, image))) + ' pixel(s)')

# plt.suptitle('Image test')
# plt.subplot(1,2,1)
# plt.imshow(image_out)
# plt.subplot(1,2,2)
# plt.imshow(image)
# plt.imshow(image - image_out)
# plt.figure(1)
# plt.imshow(image_out, cmap='gray')
# plt.figure(2)
# plt.imshow(image, cmap='gray')
# plt.show()
