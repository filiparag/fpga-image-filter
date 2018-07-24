#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))

kernel = np.random.randint(256, size=(15**2))

plt.imshow(kernel.reshape((15,15)))
plt.show()

kernel_in = []

for pixel in kernel:
    kernel_in.append(np.binary_repr(pixel, width=8))

kernel_in = " ".join(kernel_in)

with open('kernel_test.in', 'w') as file:
    file.write(kernel_in)

