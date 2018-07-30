#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

# Set seed value for data predictablity
with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))

data = np.random.randint(256, size=100, dtype=np.uint8)

data_in = '\n'.join(list(map(lambda x: '\n'.join(list(reversed(list(np.binary_repr(x, width=8))))), data)))
data_out = '\n'.join(list(map(lambda x: np.binary_repr(x, width=8), data)))

with open('data_fetcher.in.test', 'w') as file:
    file.write(data_in)

with open('data_fetcher.out.test', 'w') as file:
    file.write(data_out)