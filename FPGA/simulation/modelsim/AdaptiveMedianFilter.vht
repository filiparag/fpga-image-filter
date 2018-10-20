--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity AdaptiveMedianFilterTestbench is																	
end AdaptiveMedianFilterTestbench;


architecture adaptive_median_filter_testbench of AdaptiveMedianFilterTestbench is

	-- constants   
	constant clk_period 	: time := 10 ns;

	-- signals                                                   
	signal in_clk			: std_logic;
	signal in_write			: std_logic := '0';
	signal in_data			: window_matrix;
	
	signal out_data			: pixel;
	signal out_ready		: std_logic;


	--files
	file in_file 			: text;
	file out_file 			: text;

	--UUT component
	component AdaptiveMedianFilter
		port
		(
			in_clk				: in std_logic;
			in_window_ready		: in std_logic;
			in_window_data		: in window_matrix;
			out_ready			: out std_logic; 
			out_data			: out pixel
		);
	end component;

	--Signal mapping
begin

		amf : AdaptiveMedianFilter
		port map (
			in_clk			=> in_clk,
			in_window_ready	=> in_write,
			in_window_data	=> in_data,
			out_ready		=> out_ready,
			out_data		=> out_data
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

		file_open(in_file, "adaptivemedianfilter.in.test",  read_mode);

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

		file_close(in_file);

		wait;

	end process;

	
end adaptive_median_filter_testbench;