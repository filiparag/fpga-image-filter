#! /usr/bin/env python3

import numpy as np

shift_register = np.empty([256 * 15 * 8], dtype=np.bool)
pixel_count = int()
row_count = int()

def arch_image(in_write, in_data):

    out_ready = bool()
    out_data = np.empty([15 * 8], dtype=np.uint8)

    global shift_register
    global pixel_count
    global row_count

    if in_write:
        shift_register[256 * 15 * 8 - 1 : 8] = shift_register[256 * 15 * 8 - 8 - 1 : 0]
        shift_register[7 : 0] = in_data
        pixel_count = pixel_count + 1
        if pixel_count > 256 * 14 - 1:
            if row_count == 256:
                row_count = 0
            else:
                row_count = row_count + 1
            if row_count > 15 - 2:
                out_ready = True
            else:
                out_ready = False
    else:
        out_ready = False

    for row in reversed(range(0, 14)):
        out_data[(row + 1) * 8 - 1 : row * 8 - 1] = shift_register[256 * 15 * 8 - 8 - 1 : 0]

    return out_ready, out_data