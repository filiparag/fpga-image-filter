#! /usr/bin/env python3

import numpy as np
import converter as convert

decoder_out = np.empty([225 * 256 * 8], dtype=np.uint8)
adder_in = np.empty([256 * 225], dtype=np.uint8)
c_histogram = np.empty([256 * 8], dtype=np.uint8)
pixel_enable = np.empty([225], dtype=np.uint8)

write_dec = bool()
write_add = bool()
write_enc = bool()

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

    # DEC_GEN : for p in 0 to kernel_dimension * kernel_dimension - 1 generate
	# 	DEC : entity work.PriorityDecoder(priority_decoder)
	# 	port map (
	# 		in_clk 		=> in_clk,
	# 		in_write	=> write_dec,
	# 		in_value 	=> in_data(p),
	# 		out_values 	=> decoder_out(p)
	# 	);
	# end generate;

    for d in range(225):
        for a in range(256):
            adder_in[a,d] = decoder_out[d,a]

    # ADD_GEN : for p in 0 to 255 generate
	# 	ADD : entity work.HistogramAdder(histogram_adder)
	# 	port map (
	# 		in_clk 		=> in_clk,
	# 		in_write	=> write_add,
	# 		in_values 	=> adder_in(p),
	# 		in_enabled 	=> pixel_enable,
	# 		out_sum 	=> c_histogram(p)
	# 	);
	# end generate;

    # MIN : entity work.PriorityEncoder(priority_encoder)
	# generic map
	# ( 
	# 	gen_lookup 		=> "min",
	# 	gen_dimension	=> in_dimension
	# )
	# port map (
	# 	in_clk 			=> in_clk,
	# 	in_write		=> write_enc,
	# 	in_histogram 	=> c_histogram,
	# 	out_value 		=> out_minimum
	# );

	# MED : entity work.PriorityEncoder(priority_encoder)
	# generic map
	# ( 
	# 	gen_lookup 		=> "med",
	# 	gen_dimension	=> in_dimension
	# )
	# port map (
	# 	in_clk 		 	=> in_clk,
	# 	in_write	 	=> write_enc,
	# 	in_histogram 	=> c_histogram,
	# 	out_value 	 	=> out_median
	# );

	# MAX : entity work.PriorityEncoder(priority_encoder)
	# generic map
	# ( 
	# 	gen_lookup 		=> "max",
	# 	gen_dimension	=> in_dimension
	# )
	# port map (
	# 	in_clk 			=> in_clk,
	# 	in_write		=> write_enc,
	# 	in_histogram 	=> c_histogram,
	# 	out_value 		=> out_maximum
	# );

    write_dec = in_write
    write_add = write_dec
    write_enc = write_add
    out_ready = write_enc

    return out_median, out_maximum, out_minimum, out_ready

def test_median_histogram():

    with open('median_histogram.in.test', 'r') as test_in, \
         open('median_histogram.out', 'w') as test_out:
        
        in_data = convert.binstr_to_bin(test_in.readline().replace('\n', ''))
        out_median, out_maximum, out_minimum, out_ready = arch_median_histogram(15, 1, in_data)
        # test_out.write(convert.bin_to_binstr(out_values))

test_median_histogram()