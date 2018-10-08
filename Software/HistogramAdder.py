#! /usr/bin/env python3

import numpy as np
import converter as convert

def arch_histogram_adder(in_write, in_values, in_enabled):

	out_sum = int()

	if in_write:
		for p in range(225):
			if in_values[p] == 1 and in_enabled[p] == 1:
				out_sum = out_sum + 1

	return convert.num_to_bin(out_sum)


def test_histogram_adder():

	with open('histogram_adder_values.in.test', 'r') as test_values_in, \
		 open('histogram_adder_enabled.in.test', 'r') as test_enabled_in, \
		 open('histogram_adder.out', 'w') as test_out:
		
		in_values = convert.binstr_to_bin(test_values_in.readline().replace('\n', ''))
		in_enabled = convert.binstr_to_bin(test_enabled_in.readline().replace('\n', ''))
		out_sum = arch_histogram_adder(1, in_values, in_enabled)
		test_out.write(convert.bin_to_binstr(out_sum) + '\n')

test_histogram_adder()