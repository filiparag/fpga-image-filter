--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use STD.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity KernelTestbench is																	
end KernelTestbench;



architecture kernel_testbench OF KernelTestbench IS

-- constants   
constant clk_period : time 				:= 30 ns;

-- signals                                                   
signal in_clk 			: std_logic;
signal in_data 			: pixel;
signal in_write			: std_logic;
signal out_data 		: window_matrix;
signal out_ready 		: std_logic;

--files
file in_file 			: text;
file out_file 			: text;

--UUT component
component Kernel
	port (
	in_clk 				: in std_logic;
	in_data 			: in pixel;
	in_write 			: in std_logic;
	out_data 			: buffer window_matrix;
	out_ready 			: buffer std_logic
	);
end component;

--Signal mapping
begin
	i1 : Kernel
	port map (
	in_clk => in_clk,
	in_data => in_data,
	in_write => in_write,
	out_data => out_data,
	out_ready => out_ready
	);


-- Generates clock for UUT
clk_process : process                                                                               
begin      
	in_write <= '1';
	in_clk <= '1';
	wait for clk_period/2; 

	in_write <= '0';
	in_clk <= '0';
	wait for clk_period/2; 
                                                  
end process clk_process;       


--Sends inputs and reads outputs of UUT
send_kernel : process                                         

variable in_line		: line;
variable out_line		: line;
variable in_pixel_vect 	: std_logic_vector(7 downto 0);
variable out_pixel_vect	: std_logic_vector(7 downto 0);
variable in_pixel	 	: pixel;
variable out_pixel     	: pixel;


begin    
	--File opening
	file_open(in_file, "kernel_test.in",  read_mode);
	file_open(out_file, "Kernel_test.out", write_mode);  
			
	--Reading the in file
	while not endfile(in_file) loop
		readline(in_file, in_line);	
		read(in_line, in_pixel_vect);

		--Converting std_vector to pixel
		for i in 0 to 7 loop
			in_pixel(i) := in_pixel_vect(i);
		end loop;
		in_data <= in_pixel;

		wait until rising_edge(in_clk);
	end loop;
	
	--Writing kernel in output file
	for i in 0 to 224 loop
		out_pixel := out_data(i);
		--Converting vector to std_vector
		for j in 0 to 7 loop
			out_pixel_vect(j) := out_pixel(j);
		end loop;
		write(out_line, out_pixel_vect, right, 8);
		writeline(out_file, out_line);
		--write(out_line, character(''), right, 1);
	end loop;

	writeline(out_file, out_line);
	file_close(in_file);
	file_close(out_file);

	wait;                                                        
end process send_kernel;                                          
end kernel_testbench;
