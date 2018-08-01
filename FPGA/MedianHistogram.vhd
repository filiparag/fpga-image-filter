library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity MedianHistogram is 
	generic
	(
		in_dimension	: unsigned (7 downto 0) := to_unsigned(15, 8)
	);
	port
	(
		in_clk			: in 	std_logic;
		in_write		: in 	std_logic;
		in_data			: in 	window_matrix;

		out_ready		: out 	std_logic;
		out_median		: out 	pixel;
		out_maximum		: out 	pixel;
		out_minimum		: out 	pixel
	);

end MedianHistogram;

architecture median_histogram of MedianHistogram is

	signal decoder_out 	: histogram_dec_out;
	signal adder_in 	: histogram_add_in;
	signal c_histogram 	: histogram;
	signal pixel_enable	: histogram_in_bin;

begin
		
	DEC_GEN : for p in 0 to kernel_dimension * kernel_dimension - 1 generate
		DEC : entity work.PriorityDecoder(priority_decoder)
		port map (
			in_clk 		=> in_clk,
			in_value 	=> in_data(p),
			out_values 	=> decoder_out(p)
		);
	end generate;

	ADD_GEN : for p in 0 to 255 generate
		ADD : entity work.HistogramAdder(histogram_adder)
		port map (
			in_clk 		=> in_clk,
			in_values 	=> adder_in(p),
			in_enabled 	=> pixel_enable,
			out_sum 	=> c_histogram(p)
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
		out_value => out_minimum
	);

	MED : entity work.PriorityEncoder(priority_encoder)
	generic map
	( 
		gen_lookup => "med"
	)
	port map (
		in_clk => in_clk,
		in_histogram => c_histogram,
		out_value => out_median
	);

	MAX : entity work.PriorityEncoder(priority_encoder)
	generic map
	( 
		gen_lookup => "max"
	)
	port map (
		in_clk => in_clk,
		in_histogram => c_histogram,
		out_value => out_maximum
	);

	process(in_clk)
	begin

		for a in 0 to 14 loop
			for b in 0 to 14 loop
				if b = 0 or b = 14 then
					pixel_enable(15 * a + b) <= '0';
				else
					pixel_enable(15 * a + b) <= '1';
				end if;
			end loop;
		end loop;

		for d in 0 to 224 loop
			for a in 0 to 255 loop
				adder_in(a)(d) <= decoder_out(d)(a);
			end loop;
		end loop;
		
	end process;

end median_histogram;