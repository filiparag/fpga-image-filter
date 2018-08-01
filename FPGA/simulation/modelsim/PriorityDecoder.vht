--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity PriorityDecodertestbench is																	
end PriorityDecodertestbench;


architecture priority_decoder_testbench of PriorityDecodertestbench is

	-- constants   
	constant clk_period 	: time := 10 ns;

	-- signals                                                   
	signal in_clk			: std_logic;
	signal in_value			: pixel;
	signal out_values		: histogram_bin;

	--files
	file in_file 			: text;
	file out_file 			: text;

	--UUT component
	component PriorityDecoder
		port
		(
			in_clk			: in 	std_logic;
			in_value		: in 	pixel;
			out_values		: out 	histogram_bin
		);
	end component;

	--Signal mapping
	begin

		d1 : PriorityDecoder
		port map (
			in_clk => in_clk,
			in_value => in_value,
			out_values => out_values
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

		variable in_line		: line;
		variable in_pixel_vec	: std_logic_vector(7 downto 0);

	begin

		file_open(in_file, "priority_decoder.in.test",  read_mode);

		while not endfile(in_file) loop

			readline(in_file, in_line);	
			read(in_line, in_pixel_vec);

			for b in 0 to 7 loop
				in_value(b) <= in_pixel_vec(b);
			end loop;

		end loop;
		
		wait until rising_edge(in_clk);

		file_close(in_file);

		wait;

	end process;

	
end priority_decoder_testbench;