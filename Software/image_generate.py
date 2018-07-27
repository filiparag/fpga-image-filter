#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

# image = list(range(15**2))
image = np.zeros((60,256))

# image = np.array(list(map(lambda p: p / 225 * 256, image)), dtype=np.uint8).reshape((15,15))

for s in range(4):
    for y in range(len(image) // 4):
        for x in range(len(image[0])):
            image[s * 15 + y][x] = np.floor((y / (len(image) - 1) * ((s + 1) * 32)) + (x / (len(image[0]) - 1) * ((s + 1) * 32)))

image = np.array(image, dtype=np.uint8)

with open('image_input.in', 'w') as file:
    pixels = []
    for p in image.reshape(60*256,1):
        pixels.append((np.binary_repr(p[0], width=8)))
    file.write('\n'.join(pixels))

with open('image_output.in', 'w') as file:
#     for column in image.T:
#         column_in = ""
#         for pixel in column:
#             column_in += str(np.binary_repr(pixel, width=8))
#         file.write(column_in + '\n')

    output = []

    for r in range(0, len(image) - 15):
        for c in range(len(image[0])):
            output.append(image[r:r+15].T[c])

    for column in output:
        column_in = ""
        for pixel in column:
            column_in += str(np.binary_repr(pixel, width=8))
        file.write(column_in + '\n')        

# plt.ion()
# fig = plt.figure()
# ax = fig.add_subplot(2,1,1)
# bx = fig.add_subplot(2,1,2)

# for i in range(230, len(output) - 15):
#     ax.imshow(output[i:i+15], vmin=0, vmax=100)

#     position = np.copy(image)
#     position[i // 15 % 250:i // 15 % 250 + 15].T[i:i+15] = 255

#     bx.imshow(position, vmin=0, vmax=100)
    
#     fig.canvas.draw()
#     fig.canvas.flush_events()

plt.subplot(2,2,1)
plt.imshow(output[250:265], vmin=0, vmax=255)
plt.subplot(2,2,2)
plt.imshow(output[255:270], vmin=0, vmax=255)
# plt.imshow(image[0:15].T[250:265], vmin=0, vmax=255)
plt.subplot(2,2,3)
plt.imshow(image, vmin=0, vmax=255)

# plt.show()