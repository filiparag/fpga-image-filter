--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;   
use work.CustomTypes.all;                              

-- Empty testbench entity
entity ImageProcTestbench is																	
end ImageProcTestbench;

architecture image_proc_testbench of ImageProcTestbench is
	
	-- constants   
	constant clk_period				: time 				:= 30 ns;   

	-- signals      
	signal in_data 					: pixel;                                             
	signal in_clk 					: std_logic;
	signal in_ready 				: std_logic;

	signal out_ready 				: std_logic;
	signal out_data 				: pixel;	


	--files
	file in_file 					: text;
	file out_file 					: text;

	--UUT component
	component ImageProc
		port (
		in_clk 						: in std_logic;
		in_ready 					: in std_logic;
		in_data 					: in pixel;

		out_data 					: out pixel;	
		out_ready 					: out std_logic
		);
	end component;


begin

	--Signal mapping
	i1 : ImageProc
	port map (
	in_clk => in_clk,
	in_data => in_data,
	in_ready => in_ready,
	out_data =>	out_data,
	out_ready => out_ready
	);


	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		in_clk <= '1';
		-- in_ready <= '1';
		wait for clk_period/2; 

		-- in_ready <= '0';
		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process; 


	--Sends inputs and reads outputs of UUT
	send_image : process                                         

		variable in_line			: line;
		variable out_line			: line;
		variable pixel_var			: pixel;
		variable pixel_vect_var		: std_logic_vector(7 downto 0);

	begin    
		--File opening
		file_open(in_file, "image_proc_test.in",  read_mode);
		file_open(out_file, "image_proc_test.out", write_mode);
				
		--Reading the in file
		while not endfile(in_file) loop
			readline(in_file, in_line);	
			read(in_line, pixel_vect_var);
			in_ready <= '1';

			for i in 0 to 7 loop
				pixel_var(i) := pixel_vect_var(i);
			end loop;
			
			in_data <= pixel_var;



			if (out_ready = '1') then
				pixel_var := out_data;
				for j in 0 to 7 loop
					pixel_vect_var(j) := pixel_var(j);
				end loop;
				write(out_line, pixel_vect_var, right, 8);
				writeline(out_file, out_line);
			end if;

			wait until rising_edge(in_clk);
		end loop;

		-- wait until rising_edge(in_clk);

		in_ready <= '0';
		file_close(in_file);
		file_close(out_file);

		wait;
	end process send_image;                                  
end image_proc_testbench;
