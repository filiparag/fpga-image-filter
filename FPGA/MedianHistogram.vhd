library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity MedianHistogram is 
	port
	(
		in_clk			: in 	std_logic;
		in_write		: in 	std_logic;
		in_data			: in 	window_matrix;

		out_ready		: out 	std_logic;
		out_median		: out 	medminmax;
		out_maximum		: out 	medminmax;
		out_minimum		: out 	medminmax
	);

end MedianHistogram;

architecture median_histogram of MedianHistogram is

	signal decoder_out 	: histogram_dec_out;
	signal adder_in 	: histogram_add_in;
	signal c_histogram 	: histogram;

begin

	DEC_ADD_1 : for d in 0 to 224 generate
		DEC_ADD_2 : for a in 0 to 255 generate
			adder_in(a)(d) <= decoder_out(d)(a);
		end generate;
	end generate;

	DEC_GEN : for p in 0 to kernel_dimension * kernel_dimension - 1 generate
		DEC : entity work.PriorityDecoder(priority_decoder)
		port map (
			in_clk => in_clk,
			in_value => in_data(p),
			out_values => decoder_out(p)
		);
	end generate;

	ADD_GEN : for p in 0 to 255 generate
		ADD : entity work.HistogramAdder(histogram_adder)
		port map (
			in_clk => in_clk,
			in_values => adder_in(p),
			out_sum => c_histogram(p)
		);
	end generate;

	MIN : entity work.PriorityEncoder(priority_encoder)
	generic map
	( 
		gen_lookup => "min"
	)
	port map (
		in_clk => in_clk,
		in_histogram => c_histogram,
		out_value => out_minimum(0)
	);

	MED : entity work.PriorityEncoder(priority_encoder)
	generic map
	( 
		gen_lookup => "med"
	)
	port map (
		in_clk => in_clk,
		in_histogram => c_histogram,
		out_value => out_median(0)
	);

	MAX : entity work.PriorityEncoder(priority_encoder)
	generic map
	( 
		gen_lookup => "max"
	)
	port map (
		in_clk => in_clk,
		in_histogram => c_histogram,
		out_value => out_maximum(0)
	);

end median_histogram;