#! /usr/bin/env python3

import numpy as np

def bin_to_num(value):
    return int(np.packbits(value))

def num_to_bin(value):
    return np.asarray(list(num_to_binstr(value)), dtype=np.uint8)

def binstr_to_num(value):
    return bin_to_num(list(map(lambda x: int(x), value)))

def num_to_binstr(value):
    return np.binary_repr(value, width=8)

def bin_to_binstr(value):
    return ''.join(list(map(lambda x: str(x), value)))

def binstr_to_bin(value):
    return np.asarray(list(map(lambda x: int(x), value)), dtype=np.uint8)
