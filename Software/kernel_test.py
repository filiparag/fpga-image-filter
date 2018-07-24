#! /usr/bin/env python3

import numpy as np

with open('kernel_test.in', 'r') as file:
    kernel_in = np.array(list(map(lambda p: int(np.packbits(list(map(lambda x: int(x), list(p))))), file.read().split(' '))))

with open('kernel_test.out', 'r') as file:
    kernel_out = np.array(list(map(lambda p: int(np.packbits(list(map(lambda x: int(x), list(p))))), file.read().split(' '))))

print ('Error percentage: ' + str(round(len(np.setdiff1d(kernel_in, kernel_out)) / len(kernel_in), 2)) + ' %')
print ('Error count: ' + str(len(np.setdiff1d(kernel_in, kernel_out))) + ' pixel(s)')