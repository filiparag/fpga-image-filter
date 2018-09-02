import numpy as np
from random import randint

with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))

pos = randint(0,256)
unsorted  = np.random.randint(256, size = 256)
sortedd = np.sort(unsorted)


bitonic = np.ones(256)
for i in range(256):
    if i < 256 - pos:
        bitonic [i] = sortedd [pos + i]
    else:
        bitonic [i] = sortedd [255 - i]

data_in = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), bitonic.reshape(bitonic.size, 1))))
data_out = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), sortedd.reshape(unsorted.size, 1))))
unsorted_out = '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), unsorted.reshape(unsorted.size, 1))))

with open('bitonic_merge_test.in', 'w') as file:
    file.write(data_in)

with open('bitonic_merge_expected_out.in', 'w') as file:
    file.write(data_out)

with open('bitonic_sort_test.in', 'w') as file:
    file.write(unsorted_out)


