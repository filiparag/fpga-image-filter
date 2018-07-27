#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))

window = np.random.randint(256, size=(15**2))
#window = np.ones(15**2)
kernel = np.zeros(15**2)
for i in range(10, 15):
    for j in range(10, 15):
        #window [i * 15 + j] = (15 - i + )
        kernel [i * 15 + j] = i + j

linear_filter_in = []
result = np.sum(np.multiply(window, kernel)) / np.sum(kernel)

print(result)
print(sum(kernel))

for i in range(15**2):
    linear_filter_in.append(str(np.binary_repr(window[i], width=8)) + str(np.binary_repr(int(kernel[i]), width=8)))

linear_filter_in = "\n".join(linear_filter_in)

with open('linear_filter_test.in', 'w') as file:
    file.write(linear_filter_in)

with open('linear_filter_test_expected.out', 'w') as file:
    file.write(np.binary_repr(int(result), width=8))
