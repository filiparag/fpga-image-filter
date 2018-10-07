#! /usr/bin/env python3

import numpy as np
import converter as convert
from PriorityDecoder import arch_priority_decoder
from PriorityEncoder import arch_priority_encoder
from HistogramAdder import arch_histogram_adder

decoder_out = np.empty([225 * 256], dtype=np.uint8)
adder_in = np.empty([225 * 256], dtype=np.uint8)
c_histogram = np.empty([256 * 8], dtype=np.uint8)
pixel_enable = np.empty([225], dtype=np.uint8)

write_dec = bool(1)
write_add = bool(1)
write_enc = bool(1)

def arch_median_histogram(gen_dimension, in_write, in_data):

	out_median = int()
	out_maximum = int()
	out_minimum = int()
	out_ready = bool()

	global decoder_out
	global adder_in
	global c_histogram
	global pixel_enable

	global write_dec
	global write_add
	global write_enc

	for a in range(15):
		for b in range(15):
			if (b < (15 - gen_dimension) / 2 or b >= (15 - gen_dimension) / 2 + gen_dimension) or \
			   (a < (15 - gen_dimension) / 2 or a >= (15 - gen_dimension) / 2 + gen_dimension):
				pixel_enable[15 * a + b] = '0'
			if (b >= (15 - gen_dimension) / 2 and b < (15 - gen_dimension) / 2 + gen_dimension) and \
			   (a >= (15 - gen_dimension) / 2 and a < (15 - gen_dimension) / 2 + gen_dimension):
				pixel_enable[15 * a + b] = '1'

	for p in range(225):
		decoder_out[256 * p : 256 * (p + 1)] = arch_priority_decoder(write_dec, in_data[8 * p : 8 * (p + 1)])

	for d in range(225):
		for a in range(256):
			adder_in[225 * a + d] = decoder_out[256 * d + a]

	for p in range(256):
		c_histogram[8 * p : 8 * (p + 1)] = arch_histogram_adder(write_add, adder_in[225 * p : 225 * (p + 1)], pixel_enable)
	out_minimum = arch_priority_encoder('min', 15, write_enc, c_histogram)
	out_median = arch_priority_encoder('med', 15, write_enc, c_histogram)
	out_maximum = arch_priority_encoder('max', 15, write_enc, c_histogram)

	return out_minimum, out_median, out_maximum, True

def test_median_histogram():

	with open('median_histogram.in.test', 'r') as test_in, \
		 open('median_histogram.out', 'w') as test_out:
		
		in_data = convert.binstr_to_bin(test_in.readline().replace('\n', ''))
		out_minimum, out_median, out_maximum, out_ready = arch_median_histogram(15, 1, in_data)
		test_out.write(convert.bin_to_binstr(out_minimum) + '\n')
		test_out.write(convert.bin_to_binstr(out_median) + '\n')
		test_out.write(convert.bin_to_binstr(out_maximum))

test_median_histogram()
