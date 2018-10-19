#! /usr/bin/env python3

from pprint import pprint
import numpy as np
from matplotlib import pyplot as plt

np.random.seed(seed=111)

window = np.random.randint(256, size=(15, 15), dtype=np.uint8)

def minmedmax(window, d=0):

    # w = np.array([list(range(1,16))] * 15)

    w = window[7 - d : 8 + d, 7 - d : 8 + d]
    w = w.reshape(w.size)
    # pprint(w)
    # print(d, 2 * d + 1)

    min = int(np.min(w))
    med = int(np.median(w))
    max = int(np.max(w))

    return min, med, max

window_out = ''.join(list(map(lambda x: np.binary_repr(x, width=8), window.reshape(window.size))))

a_min, a_med, a_max = [], [], []

for d in range(1, 8):
        v_min, v_med, v_max = minmedmax(window, d)
        a_min.append(np.binary_repr(v_min, width=8))
        a_med.append(np.binary_repr(v_med, width=8))
        a_max.append(np.binary_repr(v_max, width=8))

with open('minmedmax.in.test', 'w') as file:
    file.write(window_out)

with open('minmedmax_min.out.test', 'w') as f_min,\
     open('minmedmax_med.out.test', 'w') as f_med,\
     open('minmedmax_max.out.test', 'w') as f_max:

    f_min.write(''.join(a_min))
    f_med.write(''.join(a_med))
    f_max.write(''.join(a_max))