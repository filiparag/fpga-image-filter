#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

np.random.seed(seed=111)

values = np.random.randint(2, size=225, dtype=np.uint8)
enabled = np.random.randint(2, size=225, dtype=np.uint8)

value_arr = ''.join(values.astype(str))
enabled_arr = ''.join(enabled.astype(str))
value_sum = 0 #np.binary_repr(np.sum(values), width=8)

for ind in range(225):
    if enabled[ind] == 1:
        value_sum += values[ind]
value_sum = np.binary_repr(value_sum, width=8)

print(value_arr)
print(enabled_arr)

with open('histogram_adder.out.test', 'w') as file:
    file.write(value_sum)

with open('histogram_adder_values.in.test', 'w') as file:
    file.write(value_arr)

with open('histogram_adder_enabled.in.test', 'w') as file:
    file.write(enabled_arr)