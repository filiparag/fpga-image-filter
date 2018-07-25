#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

# image = list(range(15**2))
image = np.zeros((15,15))

# image = np.array(list(map(lambda p: p / 225 * 256, image)), dtype=np.uint8).reshape((15,15))

for x in range(len(image)):
    for y in range(len(image[0])):
        image[x][y] = (x / (len(image) - 1) + y / (len(image) - 1)) * 127

image = np.array(image, dtype=np.uint8)

with open('image_test.in', 'w') as file:
    for column in np.flip(image.T, axis=0):
        column_in = ""
        for pixel in column:
            column_in += str(np.binary_repr(pixel, width=8))
        file.write(column_in + '\n')

# plt.imshow(image, cmap='gray')
# plt.show()