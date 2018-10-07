#! /usr/bin/env python3

import numpy as np
import converter as convert
from MedianHistogram import arch_median_histogram as arch_median_histogram_

s_ready = np.empty([7 * 8], dtype=np.uint8)

def arch_median_histogram(in_clk, in_write, in_data):

	out_median = np.empty([7 * 8], dtype=np.uint8)
	out_maximum = np.empty([7 * 8], dtype=np.uint8)
	out_minimum = np.empty([7 * 8], dtype=np.uint8)
	out_ready = bool()

	for d in range(1, 8):
		out_minimum[8 * (d - 1) : 8 * d], out_median[8 * (d - 1) : 8 * d], \
			out_maximum[8 * (d - 1) : 8 * d], s_ready[8 * (d - 1) : 8 * d] = \
			arch_median_histogram_(d, 1, in_data)

	if s_ready == np.array([1] * 7):
		out_ready = 1
	else:
		out_ready = 0

	return out_minimum, out_median, out_maximum, out_ready

def test_minmedmax():

	with open('minmedmax.in.test', 'r') as test_in, \
		 open('minmedmax_max.out', 'w') as test_max_out, \
		 open('minmedmax_med.out', 'w') as test_med_out, \
		 open('minmedmax_min.out', 'w') as test_min_out:
		
		in_data = convert.binstr_to_bin(test_in.readline().replace('\n', ''))
		out_minimum, out_median, out_maximum, out_ready = arch_median_histogram(15, 1, in_data)
		test_min_out.write(convert.bin_to_binstr(out_minimum))
		test_med_out.write(convert.bin_to_binstr(out_median))
		test_max_out.write(convert.bin_to_binstr(out_maximum))


test_minmedmax()
