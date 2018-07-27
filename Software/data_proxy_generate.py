#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))


kernel = np.ones((15,15), dtype=np.uint8)
for y in range(15):
    for x in range(15):
        kernel[y,x] *= (14 - (abs(7 - x) + abs(7 - y)))**2

image = np.random.randint(256, size=(60,256), dtype=np.uint8)

kernel_serial = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), kernel.reshape(kernel.size, 1))))
image_serial = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), image.reshape(image.size, 1))))

data_in = kernel_serial + '\n' + image_serial

with open('data_proxy.in.test', 'w') as file:
    file.write(data_in)

with open('data_proxy_kernel.out.test', 'w') as file:
    file.write(kernel_serial)

with open('data_proxy_image.out.test', 'w') as file:
    file.write(image_serial)