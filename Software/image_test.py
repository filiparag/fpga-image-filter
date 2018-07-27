#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt


image = np.zeros((60,256))
for s in range(4):
    for y in range(len(image) // 4):
        for x in range(len(image[0])):
            image[s * 15 + y][x] = np.floor((y / (len(image) - 1) * ((s + 1) * 32)) + (x / (len(image[0]) - 1) * ((s + 1) * 32)))

def decode(file):

    columns = file.split('\n')[:-1]

    image = np.zeros((256,60), dtype=np.uint8)

    for c in range(256):
        column = list(columns[c])
        for p in range(0, len(column), 8):
            pixel = np.packbits(list(map(lambda x: int(x), column[p:p+8])))[0]
            image[c][p // 8] = pixel

    image = np.flip(image.T, axis=1)
    return image


with open('image_output.in', 'r') as file:
    image_out = np.flip(decode(file.read()), axis=1)
    
image_diff = image - image_out
error = np.count_nonzero(image_diff)

print('Error percentage : %s percent' % round(error / image.size, 2))
print('Error count      : %s / %s pixel(s)' % (error, image.size))

plt.suptitle('Image test')
plt.subplot(3,1,1)
plt.imshow(image_out)
plt.subplot(3,1,2)
plt.imshow(image)
plt.subplot(3,1,3)
plt.imshow(image_diff)
# plt.figure(1)
# plt.imshow(image_out, cmap='gray')
# plt.figure(2)
# plt.imshow(image, cmap='gray')
plt.show()
