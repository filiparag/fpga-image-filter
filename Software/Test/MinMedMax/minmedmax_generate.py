#! /usr/bin/env python3

import numpy as np
from matplotlib import pyplot as plt

np.random.seed(seed=111)

window = np.random.randint(256, size=(15, 15), dtype=np.uint8)

def minmedmax(window, d=0):

    if d == 0:
        w = window.reshape(window.size)
    else:
        w = window[d:-d,d:-d].reshape(window[d:-d,d:-d].size)
        # print(window[d:-d,d:-d])

    min = int(np.min(w))
    med = int(np.median(w))
    max = int(np.max(w))

    return min, med, max

window_out = ''.join(list(map(lambda x: np.binary_repr(x, width=8), window.reshape(window.size))))

a_min, a_med, a_max = [], [], []

for d in range(7):
        v_min, v_med, v_max = minmedmax(window, d)
        a_min.append(np.binary_repr(v_min, width=8))
        a_med.append(np.binary_repr(v_med, width=8))
        a_max.append(np.binary_repr(v_max, width=8))

with open('minmedmax.in.test', 'w') as file:
    file.write(window_out)

with open('minmedmax_min.out.test', 'w') as f_min,\
     open('minmedmax_med.out.test', 'w') as f_med,\
     open('minmedmax_max.out.test', 'w') as f_max:

    f_min.write('\n'.join(a_min))
    f_med.write('\n'.join(a_med))
    f_max.write('\n'.join(a_max))