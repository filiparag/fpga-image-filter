--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use STD.textio.all;   
use work.CustomTypes.all;


-- Empty testbench entity
entity LinearFilterTestbench is																	
end LinearFilterTestbench;


architecture linear_filter_testbench of LinearFilterTestbench is

	-- constants   
	constant clk_period				: time 				:= 30 ns;
                                               
	-- signals                                                   
	signal in_kernel_data 			: window_matrix;
	signal in_window_data 			: window_matrix;
	signal in_clk 					: std_logic;
	signal in_kernel_ready 			: std_logic;
	signal in_window_ready 			: std_logic;

	signal out_ready 				: std_logic;
	signal out_data 				: pixel;

	--files
	file in_file 					: text;
	file out_file 					: text;

	--UUT component
	component LinearFilter
		port (
		in_window_data 				: in window_matrix;
		in_kernel_data 				: in window_matrix;
		in_clk 						: in std_logic;
		in_kernel_ready 			: in std_logic;
		in_window_ready 			: in std_logic;
		
		out_ready 					: out std_logic;
		out_data 					: out pixel
		);
	end component;


begin

	--Signal mapping
	i1 : LinearFilter
	port map (
	in_clk => in_clk,
	in_kernel_data => in_kernel_data,
	in_kernel_ready => in_kernel_ready,
	in_window_data => in_window_data,
	in_window_ready => in_window_ready,
	out_data => out_data,
	out_ready => out_ready
	);

	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		in_clk <= '1';
		in_kernel_ready <= '1';
		in_window_ready <= '1';
		wait for clk_period/2; 

		in_kernel_ready <= '0';
		in_window_ready <= '0';
		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process;   
	
	
	--Sends inputs and reads outputs of UUT
	apply_filter : process                                         

		variable in_line			: line;
		variable out_line			: line;
		variable in_window_data_var	: window_matrix;
		variable in_kernel_data_var	: window_matrix;
		variable pixel_var			: pixel;
		variable pixel_vect_var		: std_logic_vector(7 downto 0);
		variable counter			: integer 			:= 0;
		variable zero				: std_logic_vector(7 downto 0)		:= "00000000";

	begin    
		--File opening
		file_open(in_file, "linear_filter_test.in",  read_mode);
		file_open(out_file, "linear_filter_test.out", write_mode);  
				
		--Reading the in file
		while not endfile(in_file) loop
			readline(in_file, in_line);	
			read(in_line, pixel_vect_var);

			for i in 0 to 7 loop
				pixel_var(i) := pixel_vect_var(i);
			end loop;
			in_window_data_var (counter) := pixel_var;

			read(in_line, pixel_vect_var);
			for i in 0 to 7 loop
				pixel_var(i) := pixel_vect_var(i);
			end loop;
			in_kernel_data_var (counter) := pixel_var;
			counter := counter + 1;
		end loop;
		
		in_window_data <= in_window_data_var;
		in_kernel_data <= in_kernel_data_var;
		

		wait for 100 ns;

		if (out_ready = '1') then
			pixel_var := out_data;
			for i in 0 to 7 loop
				pixel_vect_var(i) := pixel_var(i);
			end loop;
			write(out_line, pixel_vect_var, right, 8);
			writeline(out_file, out_line);
		end if;

		file_close(in_file);
		file_close(out_file);

		wait;
	end process apply_filter;                                       
end linear_filter_testbench;
