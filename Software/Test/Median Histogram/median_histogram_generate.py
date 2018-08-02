#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

np.random.seed(seed=111)

window = np.random.randint(256, size=(225), dtype=np.uint8)

minimum = int(np.min(window))
median  = int(np.median(window))
maximum = int(np.max(window))

window_out = ''.join(list(map(lambda x: np.binary_repr(x, width=8), window)))

minimum_out = np.binary_repr(minimum, width=8)
median_out  = np.binary_repr(median,  width=8)
maximum_out = np.binary_repr(maximum, width=8)

print(window)

with open('median_histogram.in.test', 'w') as file:
    file.write(window_out)

with open('median_histogram.out.test', 'w') as file:
    file.write('\n'.join([minimum_out, median_out, maximum_out]))