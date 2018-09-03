#! /usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.misc
import cv2
import time

d_max = 7

with open('adaptive_median.out.test', 'r') as file:
    data = file.read().split('\n')

    pix = np.zeros(len(data))
    for ind in range(len(data)):
        pix[ind] = np.packbits(list(map(lambda x: int(x), list(data[ind]))))
    
    h = len(data) // (256 - 14)
    w = len(data) // h

    ppix = np.reshape(pix, (h, w))

    plt.figure(1)
    plt.imshow(ppix, cmap='gray', vmin=0, vmax=255)

    plt.show()

