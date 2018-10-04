#! /usr/bin/env python3

import numpy as np
import converter as convert

shift_register = np.zeros([256 * 15 * 8], dtype=np.uint8)
pixel_count = int()
row_count = int()

def arch_image(in_write, in_data):

    out_ready = bool()
    out_data = np.empty([15 * 8], dtype=np.uint8)

    global shift_register
    global pixel_count
    global row_count

    if in_write:
        shift_register[8 : 256 * 15 * 8] = shift_register[0 : 256 * 15 * 8 - 8]
        shift_register[0 : 8] = in_data
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

    for row in range(0, 15):
        out_data[8 * row : 8 * (row + 1)] = shift_register[256 * 8 * row : 256 * 8 * row + 8]

    return out_ready, out_data

def test_image():

    with open('image.in.test', 'r') as test_in, \
         open('image.out', 'w') as test_out:

        for line in test_in.readlines():
            in_data = convert.binstr_to_bin(line.replace('\n', ''))
            out_ready, out_data = arch_image(1, in_data)
            if out_ready:
                test_out.write(convert.bin_to_binstr(out_data) + '\n')

test_image()