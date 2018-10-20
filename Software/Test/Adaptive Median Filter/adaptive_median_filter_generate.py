#! /usr/bin/env python3

import numpy as np
import matplotlib.pyplot as plt
import scipy.misc
import cv2
import time

d_max = 7

def admedfilt(window):

    _siz = len(window)
    _cnt = window[_siz // 2, _siz // 2]
    _dim = 1
    
    _min = lambda: np.min(window[_siz // 2 - _dim : _siz // 2 + _dim + 1, _siz // 2 - _dim : _siz // 2 + _dim + 1])
    _med = lambda: np.median(window[_siz // 2 - _dim : _siz // 2 + _dim + 1, _siz // 2 - _dim : _siz // 2 + _dim + 1])
    _max = lambda: np.max(window[_siz // 2 - _dim : _siz // 2 + _dim + 1, _siz // 2 - _dim : _siz // 2 + _dim + 1])

    while _dim <= d_max:

        if _min() < _med() and _med() < _max():
            if _min() < _cnt and _cnt < _max():
                return _cnt
            else:
                return _med()
        else:
            _dim += 1

    else:

        return _cnt

def filter(image):

    filtered_image = np.zeros(image.shape, dtype=np.uint8)

    for y in range(d_max, image.shape[0] - d_max):
        for x in range(d_max, image.shape[1] - d_max):
            filtered_image[y,x] = admedfilt(image[y:y+d_max*2+1, x:x+d_max*2+1])

    return filtered_image

def test_input_output(image):

    h, w = image.shape
    s = (h - d_max * 2), (w - d_max * 2)

    win = np.zeros((d_max * 2 + 1, d_max * 2 + 1, s[0] * s[1]))

    pix = np.zeros((h - d_max * 2) * (w - d_max * 2))

    ind = 0

    for y in range(h - d_max * 2):
        for x in range(w - d_max * 2):
            win[:, :, ind] = image[y : y + d_max * 2 + 1, x : x + d_max * 2 + 1]
            pix[ind] = admedfilt(win[:, :, ind])
            ind += 1
            if ind % 1000 == 0:
                print(round(ind / win.shape[2] * 100, 2))

    # print(pix.shape)

    # ppix = np.zeros(image.shape, dtype=np.uint8)
    # ppix[7:h-7,7:w-7] = np.reshape(pix, (h - 14, w - 14))
    # ppix[:w - 15, :h - 15] = np.reshape(pix, (w - 14, h - 14))


    # plt.figure(1)
    # plt.subplot(3,1,2)
    # plt.imshow(ppix, cmap='gray', vmin=0, vmax=255)

    # plt.subplot(3,1,3)
    # plt.imshow(image - ppix)

    return win, pix, s

def binarize_win(inp):

    out = [None] * inp.shape[2]
    for ind in range(inp.shape[2]):
        w = np.reshape(win[:, :, ind], (inp.shape[0] * inp.shape[1]))
        out[ind] = ''.join(map(lambda x: np.binary_repr(x, width=8), w.astype(int)))
    
    return out

def binarize_pix(inp):

    out = [None] * inp.shape[0]
    for ind in range(inp.shape[0]):
        out[ind] = np.binary_repr(int(inp[ind]), width=8)

    return out

# o = scipy.misc.imread('Noise/original/1.png', flatten=True, mode='L')[100:164, :256]
i = scipy.misc.imread('Noise/noisy/impulse/1.png', flatten=True, mode='L')[100:164, :256]

win, pix, _ = test_input_output(i)


with open('adaptive_median.in.test', 'w') as file:
    file.write('\n'.join(binarize_win(win)))

with open('adaptive_median.out.test', 'w') as file:
    file.write('\n'.join(binarize_pix(pix)))

# plt.figure(1)
# plt.subplot(3,1,1)
# plt.imshow(i, cmap='gray', vmin=0, vmax=255)
# plt.subplot(3,1,3)
# plt.imshow(o, cmap='gray', vmin=0, vmax=255)
# f = filter(i)
# plt.subplot(3,1,2)
# plt.imshow(f, cmap='gray', vmin=0, vmax=255)
# plt.subplot(3,1,3)
# plt.imshow(f - i)
# plt.show()

