--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use STD.textio.all;   
use work.CustomTypes.all;                              

-- Empty testbench entity
entity WindowTestbench is																	
end WindowTestbench;

architecture window_testbench of WindowTestbench is
	
	-- constants   
	constant clk_period				: time 				:= 30 ns;   

	-- signals      
	signal in_data 					: kernel_row;                                             
	signal in_clk 					: std_logic;
	signal in_ready 				: std_logic;

	signal out_data 				: window_matrix;
	signal out_ready 				: std_logic;


	--files
	file in_file 					: text;
	file out_file 					: text;

	--UUT component
	component Window
		port (
		in_data 					: in kernel_row;
		in_clk 						: in std_logic;
		in_ready 					: in std_logic;

		out_data 					: out window_matrix;
		out_ready 					: out std_logic
		);
	end component;


begin

	--Signal mapping
	i1 : Window
	port map (
	in_clk => in_clk,
	in_data => in_data,
	in_ready => in_ready,
	out_data => out_data,
	out_ready => out_ready
	);


	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		in_clk <= '1';
		in_ready <= '1';
		wait for clk_period/2; 

		in_ready <= '0';
		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process; 


	--Sends inputs and reads outputs of UUT
	send_kernel_row : process                                         

		variable in_line			: line;
		variable out_line			: line;
		variable out_data_var		: window_matrix;
		variable pixel_var			: pixel;
		variable pixel_vect_var		: std_logic_vector(7 downto 0);

	begin    
		--File opening
		file_open(in_file, "linear_filter_test.in",  read_mode);
		file_open(out_file, "linear_filter_test.out", write_mode);
				
		--Reading the in file
		while not endfile(in_file) loop
			readline(in_file, in_line);	
			for i in 0 to 14 loop
				read(in_line, pixel_vect_var);
				for j in 0 to 7 loop
					pixel_var(j) := pixel_vect_var(j);
				end loop;
				in_data(i) <=  pixel_var;
			end loop;

			if (out_ready = '1') then
				for i in 0 to (kernel_dimension * kernel_dimension - 1) loop
					pixel_var := out_data(i);
					for j in 0 to 7 loop
						pixel_vect_var(i) := pixel_var(i);
					end loop;
				end loop;
				write(out_line, pixel_vect_var, right, 8);
				writeline(out_file, out_line);
			end if;

			wait until rising_edge(in_clk);
		end loop;

		file_close(in_file);
		file_close(out_file);

		wait;
	end process send_kernel_row;                                  
end window_testbench;
