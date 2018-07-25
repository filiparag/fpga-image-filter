#! /usr/bin/env python3

import numpy as np

with open('kernel_test.in', 'r') as file:
    kernel_in = np.array(list(map(lambda p: int(np.packbits(list(map(lambda x: int(x), list(p))))), file.read().split('\n'))))

with open('kernel_test.out', 'r') as file:
    kernel_out = np.array(list(map(lambda p: int(np.packbits(list(map(lambda x: int(x), list(p))))), file.read().split('\n'))))

kernel_diff = kernel_in - kernel_out
error = np.count_nonzero(kernel_diff)

print('Error percentage : %s percent' % round(error / kernel_in.size, 2))
print('Error count      : %s / %s pixel(s)' % (error, kernel_in.size))