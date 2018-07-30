#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt
from scipy import signal
from scipy import misc

def decode(file):

    columns = file.split('\n')
    # print(len(columns))
    image = np.zeros((498,242), dtype=np.uint8)

    for c in range(len(columns)):
        columns[c] = [int(columns[c][i:i+8], 2) for i in range(0, len(columns[c]), 8)]
    columns = np.array(columns)
    
    # plt.imshow(columns[-520:])
    # plt.figure(2)

    # print(len(columns))

    for i in range(498):
        for j in range(242):
            image[i, j] = columns[i * 242 + j]

    return image


# with open('testic.out', 'r') as file:
#     image_out = decode(file.read())

with open('testic.out', 'r') as file:
    image_out = decode(file.read())
    

kernel = np.ones((15,15), dtype=np.uint8)
for y in range(15):
    for x in range(15):
        kernel[y,x] *= (14 - (abs(7 - x) + abs(7 - y)))**2
kernel1 = kernel / np.sum(kernel)

image = misc.ascent()
image = image[:, 0:256]
result = np.zeros((498,242), dtype=np.uint8)
resultt = np.zeros((498,242), dtype=np.float)

for i in range(498):
    for j in range(242):
        result[i,j] = np.sum(np.multiply(image[i:i+15,j:j+15], kernel))/np.sum(kernel)

# result = signal.convolve2d(image, kernel1, mode='valid')

# print (image_out[0,0])
# print (image_out[0,1])
# print (image_out[0,2])
# print (image_out[0,3])
# print (image_out[0,4])
# print (image_out[0,5])
# print (image_out[0,6])
# print (image_out[0,7])
# print (image_out[0,8])

resultt = result.astype(float) - image_out.astype(float)

print(np.max(resultt))
print(np.min(resultt))
# plt.imshow(image)
# plt.show()

# plt.imshow(kernel)
# plt.show()

# plt.imshow(result)
# plt.show()

# plt.imshow(image_out)
# plt.show()

# print(np.max(resultt))
# print(np.min(resultt))
# for i in range(498):
#     for j in range(242):
        # print (image[0,0])

plt.imshow(resultt)
plt.show()