#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt


image = np.zeros((15,256))
for x in range(len(image)):
    for y in range(len(image[0])):
        image[x][y] = (x / (len(image) - 1) * 127) + (y / (len(image[0]) - 1) * 127)


def decode(file):

    columns = file.split('\n')[:-1]

    image = np.zeros((256,15), dtype=np.uint8)

    for c in range(256):
        column = list(columns[c])
        for p in range(0, len(column), 8):
            pixel = np.packbits(list(map(lambda x: int(x), column[p:p+8])))[0]
            image[c][p // 8] = pixel

    image = np.flip(image.T, axis=1)
    return image


with open('image_output.in', 'r') as file:
    image_out = decode(file.read())
    
# image_diff = image - image_out
# error = np.count_nonzero(image_diff)

# print('Error percentage : %s percent' % round(error / image.size, 2))
# print('Error count      : %s / %s pixel(s)' % (error, image.size))

# plt.suptitle('Image test')
# plt.subplot(2,1,1)
# plt.imshow(image_out)
# plt.subplot(2,1,2)
# plt.imshow(image)
# plt.imshow(image - image_out)
# plt.figure(1)
# plt.imshow(image_out, cmap='gray')
# plt.figure(2)
# plt.imshow(image, cmap='gray')
plt.show()
