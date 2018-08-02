import numpy as np
from random import randint

with open('seed', 'r') as file:
    np.random.seed(seed=int(file.read()))

data_in = ""
data_out = ""
for i in range (100):
    unsorted  = np.random.randint(256, size = 256)
    sortedd = np.sort(unsorted)
    data_in = data_in + '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), unsorted.reshape(unsorted.size, 1)))) + '\n'
    data_out = data_out + '\n'.join(list(map(lambda p: np.binary_repr(int(p), width=8), sortedd.reshape(unsorted.size, 1)))) + '\n'

with open('bitonic_sort_test.in', 'w') as file:
    file.write(data_in)

with open('bitonic_sort_expected_out.in', 'w') as file:
    file.write(data_out)