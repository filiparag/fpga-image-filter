#! /usr/bin/env python3

import numpy as np
import converter as convert

def arch_priority_encoder(gen_lookup, gen_dimension, in_write, in_histogram):

    out_value = int()
    treshold = int()

    if gen_lookup == 'min':
        treshold = 1
    elif gen_lookup == 'max':
        treshold = gen_dimension ** 2
    elif gen_lookup == 'med':
        treshold = (gen_dimension ** 2 + 1) / 2

    if in_write:
        for p in range(255):
            if convert.bin_to_num(in_histogram[8 * p : 8 * (p + 1)]) >= treshold:
                if p == 0:
                    out_value = p
                elif convert.bin_to_num(in_histogram[8 * (p - 1) : 8 * p]) < treshold:
                    out_value = p

    return out_value


def test_priority_encoder():

    with open('priority_encoder.in.test', 'r') as test_in, \
         open('priority_encoder.out', 'w') as test_out:
        
        in_histogram = convert.binstr_to_bin(test_in.readline().replace('\n', ''))
        for gen_lookup in ['min', 'med', 'max']:
            out_value = arch_priority_encoder(gen_lookup, 15, 1, in_histogram)
            test_out.write(convert.num_to_binstr(out_value) + '\n')

test_priority_encoder()