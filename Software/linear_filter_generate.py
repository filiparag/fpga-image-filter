#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))

kernel = np.random.randint(256, size=(15**2))

linear_filter_in = []
result = int((np.average(kernel)))

for i in range(15**2):
    linear_filter_in.append(str(np.binary_repr(kernel[i], width=8)) + str(np.binary_repr(1, width=8)))

linear_filter_in = "\n".join(linear_filter_in)

with open('linear_filter_test.in', 'w') as file:
    file.write(linear_filter_in)

with open('linear_filter_test_expected.out', 'w') as file:
    file.write(np.binary_repr(result, width=8))
