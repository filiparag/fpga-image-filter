--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity MedianHistogramtestbench is																	
end MedianHistogramtestbench;


architecture median_histogram_testbench of MedianHistogramtestbench is

	-- constants   
	constant clk_period 	: time := 10 ns;

	-- signals                                                   
	signal in_clk			: std_logic;
	signal in_write			: std_logic := '0';
	signal in_data			: window_matrix;
	
	signal out_median		: pixel;
	signal out_maximum		: pixel;
	signal out_minimum		: pixel;
	signal out_ready		: std_logic;


	--files
	file in_file 			: text;
	file out_file 			: text;

	--UUT component
	component MedianHistogram
		generic
		(
			in_dimension	: unsigned (7 downto 0)
		);
		port
		(
			in_clk			: in 	std_logic;
			in_write		: in 	std_logic;
			in_data			: in 	window_matrix;

			out_median		: out 	pixel;
			out_maximum		: out 	pixel;
			out_minimum		: out 	pixel;
			out_ready		: out 	std_logic
		);
	end component;

	--Signal mapping
begin

		mh1 : MedianHistogram
		generic map
		(
			in_dimension	=> to_unsigned(5, 8)
		)
		port map (
			in_clk			=> in_clk,
			in_write		=> in_write,
			in_data			=> in_data,
			out_median		=> out_median,
			out_maximum		=> out_maximum,
			out_minimum		=> out_minimum,
			out_ready		=> out_ready
		);

	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		-- in_write <= '1';
		in_clk <= '0';
		wait for clk_period/2; 

		-- in_write <= '0';
		in_clk <= '1';
		wait for clk_period/2; 
													
	end process clk_process;   
	
	read_window : process

		variable in_line		: line;
		variable in_window_vec	: std_logic_vector(1799 downto 0);

	begin

		file_open(in_file, "minmedmax.in.test",  read_mode);

		while not endfile(in_file) loop

			readline(in_file, in_line);	
			read(in_line, in_window_vec);

			for p in 0 to 224 loop
				for b in 0 to 7 loop
					in_data(224 - p)(b) <= in_window_vec(8 * p + b);
				end loop;
			end loop;

		end loop;
		
		wait until rising_edge(in_clk);

		in_write <= '1';

		file_close(in_file);

		wait;

	end process;

	
end median_histogram_testbench;