#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

size = 1

np.random.seed(seed=100)

values = np.random.randint(256, size=size, dtype=np.uint8)

out = np.zeros((size, 256), dtype=np.uint8)

def decode(value):

    return ''.join(list(map(lambda x: str(int(value < x)), range(256))))

dec = ''
val = ''

for index in range(size):
    dec += decode(values[index]) + '\n'
    val += np.binary_repr(values[index], width=8) + '\n'

with open('priority_decoder.out.test', 'w') as file:
    file.write(dec[:-1])

with open('priority_decoder.in.test', 'w') as file:
    file.write(val[:-1])
