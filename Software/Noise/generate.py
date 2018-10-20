#! /usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.misc
import cv2

def impulse_noise(original, intensity=0.5):

    high = np.random.randint(100, size=original.size)
    low = np.random.randint(100, size=original.size)
    
    img = original.reshape(original.size)


    for i in range(img.size):

        l = low[i] < 100 * intensity
        h = high[i] < 100 * intensity

        if l and h:
            img[i] = np.random.randint(2) * 255
        elif l:
            img[i] = 0
        elif h:
            img[i] = 255

    img = img.reshape(original.shape)
    
    plt.imshow(img, cmap='gray', vmin=0, vmax=255)


img_o = scipy.misc.imread('original/%s.png' % 1, flatten=True, mode='L')

impulse_noise(img_o, 0.5)

# plt.imshow(img_o, cmap='gray', vmin=0, vmax=255)
plt.show()