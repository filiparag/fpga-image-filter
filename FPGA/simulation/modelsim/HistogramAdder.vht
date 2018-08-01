--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity HistogramAdderTestbench is																	
end HistogramAdderTestbench;


architecture histogram_adder_testbench of HistogramAdderTestbench is

	-- constants   
	constant clk_period 	: time := 10 ns;

	-- signals                                                   
	signal in_clk			: std_logic;
	signal in_values		: histogram_in_bin;
	signal in_enabled		: histogram_in_bin;
	signal out_sum			: pixel;

	--files
	file in_file_v 			: text;
	file in_file_e 			: text;

	--UUT component
	component HistogramAdder
		port
		(
			in_clk			: in std_logic;
			in_values		: in histogram_in_bin;
			in_enabled		: in histogram_in_bin;
			out_sum			: out pixel
		);
	end component;

	--Signal mapping
	begin

		d1 : HistogramAdder
		port map (
			in_clk 			=> in_clk,
			in_values 		=> in_values,
			in_enabled 		=> in_enabled,
			out_sum 		=> out_sum
		);

	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		-- in_write <= '1';
		in_clk <= '1';
		wait for clk_period/2; 

		-- in_write <= '0';
		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process;   
	
	read_value : process

		variable in_line_v		: line;
		variable in_line_e		: line;
		variable in_values_vec	: std_logic_vector(224 downto 0);
		variable in_enabled_vec	: std_logic_vector(224 downto 0);

	begin

		file_open(in_file_v, "histogram_adder_values.in.test",  read_mode);
		file_open(in_file_e, "histogram_adder_enabled.in.test",  read_mode);

		readline(in_file_v, in_line_v);	
		read(in_line_v, in_values_vec);

		readline(in_file_e, in_line_e);	
		read(in_line_e, in_enabled_vec);

		for b in 0 to 224 loop
			in_values(b) <= in_values_vec(b);
		end loop;

		for b in 0 to 224 loop
			in_enabled(b) <= in_enabled_vec(b);
		end loop;
		
		wait until rising_edge(in_clk);

		file_close(in_file_v);
		file_close(in_file_e);

		wait;

	end process;

	
end histogram_adder_testbench;