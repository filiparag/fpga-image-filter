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
# kernel = np.zeros((15,15), dtype=np.uint8)
# kernel[7,7] = 1

kernel1 = kernel / np.sum(kernel)
print(np.sum(kernel))

# image = image()

# image = np.random.randint(256, size=(60,256), dtype=np.uint8)
# image = np.zeros((60,256))


# for s in range(4):
#     for y in range(len(image) // 4):
#         for x in range(len(image[0])):
#             image[s * 15 + y][x] = np.floor((y / (len(image) - 1) * ((s + 1) * 32)) + (x / (len(image[0]) - 1) * ((s + 1) * 32)))

image = misc.ascent()
image = image[:, 0:256]
result = signal.convolve2d(image, kernel1, boundary='symm', mode='valid')

plt.imshow(image)
plt.show()


result_serial = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), result.reshape(result.size, 1))))
kernel_serial = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), kernel.reshape(kernel.size, 1))))
image_serial = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), image.reshape(image.size, 1))))

data_in = kernel_serial + '\n' + image_serial

with open('image_proc_test.in', 'w') as file:
    file.write(data_in)

with open('image_proc_out.in', 'w') as file:
    file.write(result_serial)

with open('image_proc_image_result.in', 'w') as file:
    for x in range(0, len(result)):
        column_in = ""
        for y in range(0, len(result[0])):
            column_in += str(np.binary_repr(int(result[x,y]), width=8))
            column_in += " "
        file.write(column_in + '\n')