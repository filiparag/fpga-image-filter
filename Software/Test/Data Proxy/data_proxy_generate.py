#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt
from scipy import signal
from scipy import misc

with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))


kernel = np.ones((15,15), dtype=np.uint8)
for y in range(15):
    for x in range(15):
        kernel[y,x] *= (14 - (abs(7 - x) + abs(7 - y)))**2

kernel = kernel / np.sum(kernel)

# image = np.random.randint(256, size=(60,256), dtype=np.uint8)
# image = np.zeros((60,256))


# for s in range(4):
#     for y in range(len(image) // 4):
#         for x in range(len(image[0])):
#             image[s * 15 + y][x] = np.floor((y / (len(image) - 1) * ((s + 1) * 32)) + (x / (len(image[0]) - 1) * ((s + 1) * 32)))

image = misc.ascent()

result = signal.convolve2d(image, kernel, boundary='symm', mode='valid')

plt.imshow(result)
plt.show()



kernel_serial = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), kernel.reshape(kernel.size, 1))))
image_serial = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), image.reshape(image.size, 1))))

data_in = kernel_serial + '\n' + image_serial

with open('data_proxy.in.test', 'w') as file:
    file.write(data_in)

with open('data_proxy_kernel.out.test', 'w') as file:
    file.write(kernel_serial)

with open('data_proxy_image.out.test', 'w') as file:
    file.write(image_serial)