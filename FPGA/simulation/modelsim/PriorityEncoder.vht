--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity PriorityEncodertestbench is																	
end PriorityEncodertestbench;


architecture priority_encoder_testbench of PriorityEncodertestbench is

	-- constants   
	constant clk_period 	: time := 10 ns;

	-- signals                                                   
	signal in_clk			: std_logic;
	signal in_histogram		: histogram;
	signal out_value_min	: pixel;
	signal out_value_med	: pixel;
	signal out_value_max	: pixel;

	--files
	file in_file 			: text;
	file out_file 			: text;

	--UUT component
	component PriorityEncoder
		generic
		(
			gen_lookup		: String(1 to 3)
		);
		port
		(
			in_clk			: in 	std_logic;
			in_histogram	: in 	histogram;
			out_value		: out 	pixel
		);
	end component;

	--Signal mapping
	begin

		i_min : PriorityEncoder
		generic map (
			gen_lookup => "min"
		)
		port map (
			in_clk => in_clk,
			in_histogram => in_histogram,
			out_value => out_value_min
		);

		i_med : PriorityEncoder
		generic map (
			gen_lookup => "med"
		)
		port map (
			in_clk => in_clk,
			in_histogram => in_histogram,
			out_value => out_value_med
		);

		i_max : PriorityEncoder
		generic map (
			gen_lookup => "max"
		)
		port map (
			in_clk => in_clk,
			in_histogram => in_histogram,
			out_value => out_value_max
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
	
	read_histogram : process

		variable in_line		: line;
		variable in_hist		: histogram;
		variable in_hist_vec	: std_logic_vector(2047 downto 0);

	begin

		file_open(in_file, "priority_encoder.in.test",  read_mode);

		while not endfile(in_file) loop

			readline(in_file, in_line);	
			read(in_line, in_hist_vec);

			for p in 0 to 255 loop
				for b in 0 to 7 loop
					in_hist(255 - p)(b) := in_hist_vec(p * 8 + b);
				end loop;
			end loop;

			in_histogram <= in_hist;
			-- in_histogram <= (others => "00000000");

		end loop;
		
		wait until rising_edge(in_clk);

		file_close(in_file);

		wait;

	end process;

	
end priority_encoder_testbench;