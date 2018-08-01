#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

size = 1


np.random.seed(seed=111)

values = np.random.randint(256, size=(size, 225), dtype=np.uint8)

histograms = np.zeros((size, 256), dtype=np.uint8)

for arr in range(size):
    for val in range(len(values[arr])):
        histograms[arr, values[arr, val]:] += 1

plt.plot(histograms[0,:])
plt.show()

def encode(values, histogram):

    minimum = np.binary_repr(np.where(histogram>=1)[0][0], width=8)
    median = np.binary_repr(np.where(histogram>=113)[0][0], width=8)
    maximum = np.binary_repr(np.where(histogram>=225)[0][0], width=8)

    return minimum, median, maximum

hist = ''
vals = ''

for index in range(size):
    hist += ''.join(list(map(lambda x: np.binary_repr(x, width=8), histograms[0]))) + '\n'
    vals += '\n'.join(encode(values[0], histograms[0])) + '\n'

with open('priority_encoder.in.test', 'w') as file:
    file.write(hist[:-1])

with open('priority_encoder.out.test', 'w') as file:
    file.write(vals[:-1])
