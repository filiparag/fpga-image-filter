#! /usr/bin/env python3

import numpy as np
import converter as convert

def arch_priority_decoder(in_write, in_value):

    out_values = np.zeros([256], dtype=np.uint8)

    if in_write:
        for value in range(256):
            if convert.bin_to_num(in_value) < value:
                out_values[value] = 1
            else:
                out_values[value] = 0

    return out_values

def test_priority_decoder():

    with open('priority_decoder.in.test', 'r') as test_in, \
         open('priority_decoder.out', 'w') as test_out:
        
        in_value = convert.binstr_to_bin(test_in.readline().replace('\n', ''))
        out_values = arch_priority_decoder(1, in_value)
        test_out.write(convert.bin_to_binstr(out_values))

test_priority_decoder()