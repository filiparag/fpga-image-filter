library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity MinMedMax is 
	port
	(
		in_clk			: in 	std_logic;
		in_write		: in 	std_logic;
		in_data			: in 	window_matrix;

		out_median		: out 	min_med_max;
		out_maximum		: out 	min_med_max;
		out_minimum		: out 	min_med_max;
		out_ready		: out 	std_logic
	);

end MinMedMax;

architecture median_histogram of MinMedMax is
begin
		
	MH_GEN : for dimension in 1 to 7 generate
		MED_HIST : entity work.MedianHistogram(median_histogram)
		generic map
		( 
			in_dimension => to_unsigned(2 * dimension + 1, 8)
		)
		port map (
			in_clk		 => in_clk,
			in_write	 => in_write,
			in_data		 => in_data,
			out_median	 => out_median(dimension),
			out_maximum	 => out_maximum(dimension),
			out_minimum	 => out_minimum(dimension),
			out_ready	 => out_ready
		);
	end generate;
	
end median_histogram;