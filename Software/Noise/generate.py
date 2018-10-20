#! /usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.misc
import cv2

def impulse_noise(original, intensity=0.5):

    high = np.random.randint(100, size=original.size, dtype=np.uint8)
    low = np.random.randint(100, size=original.size, dtype=np.uint8)
    
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
    
    return img

def white_noise(original, coverage=0.5, intensity=64):
    
    noise = np.random.randint(low=-intensity, high=intensity, size=original.size, dtype=np.int16)
    select = np.random.randint(100, size=original.size, dtype=np.uint8)

    img = original.reshape(original.size)

    for i in range(img.size):

        if select[i] < 100 * coverage:
            img[i] = np.min([np.max([0, img[i] + noise[i]]), 255])

    img = img.reshape(original.shape)
    
    return img

for i in range(1, 4):

    img_o = scipy.misc.imread('original/%s.png' % i, flatten=True, mode='L')

    print('Image %s:' % i)

    img_wn = np.copy(img_o)
    img_in = np.copy(img_o)

    print(' Allocate images')

    img_wn = white_noise(img_wn, 1, 48)

    print(' White noise')

    img_in = impulse_noise(img_in, 0.1)

    print(' Impulse noise')
    
    img_both = np.copy(img_wn)
    img_both = impulse_noise(img_both, 0.1)

    print(' Both noises')

    # plt.subplot(1,2,1)
    # plt.imshow(img_o, cmap='gray', vmin=0, vmax=255)
    # plt.subplot(1,2,2)
    # plt.imshow(img_both, cmap='gray', vmin=0, vmax=255)
    # plt.show()

    scipy.misc.imsave('noisy/white/%s.png' % i, img_wn)
    scipy.misc.imsave('noisy/impulse/%s.png' % i, img_in)
    scipy.misc.imsave('noisy/both/%s.png' % i, img_both)

    print(' Save to disk')