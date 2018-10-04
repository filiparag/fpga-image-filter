#! /usr/bin/env python3

import numpy as np
import converter as convert

pixel_count = int()

def arch_data_proxy(in_ready, in_data):

    out_kernel_write = bool()
    out_image_write = bool()
    out_kernel = np.empty([8], dtype=np.uint8)
    out_image = np.empty([8], dtype=np.uint8)

    global pixel_count

    if in_ready:
        if pixel_count < 225:
            pixel_count = pixel_count + 1
            out_kernel_write = True
            out_image_write = False
            out_kernel = in_data
        else:
            out_kernel_write = False
            out_image_write = True
            out_image = in_data
    else:
        out_kernel_write = False
        out_image_write = False

    return out_kernel_write, out_image_write, out_kernel, out_image


def test_data_proxy():

    with open('data_proxy.in.test', 'r') as test_in, \
         open('data_proxy_kernel.out', 'w') as test_kernel_out, \
         open('data_proxy_image.out', 'w') as test_image_out:

        for line in test_in.readlines():
            in_data = convert.binstr_to_bin(line[:-1])
            out_kernel_write, out_image_write, out_kernel, out_image = arch_data_proxy(1, in_data)
            if out_kernel_write:
                test_kernel_out.write(convert.bin_to_binstr(out_kernel) + '\n')
            if out_image_write:
                test_image_out.write(convert.bin_to_binstr(out_image) + '\n')
                print(out_image)

test_data_proxy()