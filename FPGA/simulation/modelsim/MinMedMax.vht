--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity MinMedMaxTestbench is																	
end MinMedMaxTestbench;


architecture minmedmax_testbench of MinMedMaxTestbench is

	-- constants   
	constant clk_period 	: time := 10 ns;

	-- signals                                                   
	signal s_clk			: std_logic;
	signal s_write			: std_logic := '0';
	signal s_data			: window_matrix;
	
	signal s_median			: min_med_max;
	signal s_maximum		: min_med_max;
	signal s_minimum		: min_med_max;
	signal s_ready			: std_logic_vector(6 downto 0) := (others => '0');


	--files
	file in_file 			: text;

begin

		mmm : entity work.MinMedMax(arch_median_histogram)
		generic map
		(
			in_dimension	=> to_unsigned(15, 8)
		)
		port map (
			in_clk			=> s_clk,
			in_write		=> s_write,
			in_data			=> s_data,
			out_median		=> s_median,
			out_maximum		=> s_maximum,
			out_minimum		=> s_minimum,
			out_ready		=> s_ready
		);

	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		-- in_write <= '1';
		s_clk <= '0';
		wait for clk_period/2; 

		-- in_write <= '0';
		s_clk <= '1';
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
					s_data(224 - p)(b) <= in_window_vec(8 * p + b);
				end loop;
			end loop;

		end loop;
		
		wait until rising_edge(s_clk);

		s_write <= '1';

		file_close(in_file);

		wait;

	end process;

	
end minmedmax_testbench;