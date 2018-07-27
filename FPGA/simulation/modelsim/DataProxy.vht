--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use STD.textio.all;                                                             
use work.CustomTypes.all;

-- Empty testbench entity
entity DataProxyTestbench is																	
end DataProxyTestbench;

architecture data_proxy_testbench of DataProxyTestbench is

	-- constants   
	constant clk_period			: time := 10 ns;

	-- signals                                                                                                   
	SIGNAL in_clk 				: STD_LOGIC := '0';                                             
	SIGNAL in_data 				: pixel;
	SIGNAL in_ready 			: STD_LOGIC := '0';
	SIGNAL out_image 			: pixel;
	SIGNAL out_image_write 		: STD_LOGIC;
	SIGNAL out_kernel 			: pixel;
	SIGNAL out_kernel_write 	: STD_LOGIC;

	--files
	file in_file 				: text;
	file out_file_image			: text;
	file out_file_kernel		: text;
	
	COMPONENT DataProxy
		PORT (
		in_clk 					: IN STD_LOGIC;
		in_data 				: IN pixel;
		in_ready 				: IN STD_LOGIC;
		out_image 				: OUT pixel;
		out_image_write 		: OUT STD_LOGIC;
		out_kernel 				: OUT pixel;
		out_kernel_write 		: OUT STD_LOGIC
		);
	END COMPONENT;

BEGIN
	
	i1 : DataProxy
	PORT MAP (
	-- list connections between master ports and signals
		in_clk => in_clk,
		in_data => in_data,
		in_ready => in_ready,
		out_image => out_image,
		out_image_write => out_image_write,
		out_kernel => out_kernel,
		out_kernel_write => out_kernel_write
	);

	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		in_clk <= '1';
		wait for clk_period/2; 

		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process;   

	-- send_kernel : process                                         

	-- 	variable in_line		: line;
	-- 	variable out_line		: line;
	-- 	variable in_pixel	 	: pixel;
	-- 	variable out_pixel     	: pixel;
	-- 	variable in_pixel_vect 	: std_logic_vector(7 downto 0);
	-- 	variable out_pixel_vect	: std_logic_vector(7 downto 0);

	-- begin    
		


	-- 	wait;                                                        
	-- end process send_kernel;      ]
	
	
	read_files : process

		variable in_line		: line;
		variable in_pixel	 	: pixel;
		variable in_pixel_vect 	: std_logic_vector(7 downto 0);

	begin

		file_open(in_file, "data_proxy.in.test", read_mode);

		in_ready <= '1';

		while not endfile(in_file) loop
			readline(in_file, in_line);	
			read(in_line, in_pixel_vect);

			for i in 0 to 7 loop
				in_pixel(i) := in_pixel_vect(i);
			end loop;
			
			in_data <= in_pixel;

			wait until rising_edge(in_clk);
		end loop;

		file_close(in_file);

		wait;
		
	end process;

	write_kernel : process

		variable out_line		: line;
		variable out_pixel	 	: pixel;
		variable out_pixel_vect : std_logic_vector(7 downto 0) := (others => '0');

	begin

		file_open(out_file_kernel, "data_proxy_kernel.out.test", write_mode);

		wait until rising_edge(out_kernel_write);

		while out_kernel_write = '1' loop

			out_pixel := out_kernel;

			for j in 0 to 7 loop
				out_pixel_vect(j) := out_pixel(j);
			end loop;
			
			write(out_line, out_pixel_vect);
			writeline(out_file_kernel, out_line);

			wait until rising_edge(in_clk);

		end loop;

		file_close(out_file_kernel);

		wait;
		
	end process;

	write_image : process

		variable out_line		: line;
		variable out_pixel	 	: pixel;
		variable out_pixel_vect : std_logic_vector(7 downto 0) := (others => '0');

	begin

		file_open(out_file_image, "data_proxy_image.out.test", write_mode);

		wait until rising_edge(out_image_write);

		while out_image_write = '1' loop

			out_pixel := out_image;

			for j in 0 to 7 loop
				out_pixel_vect(j) := out_pixel(j);
			end loop;
			
			write(out_line, out_pixel_vect);
			writeline(out_file_image, out_line);

			wait until rising_edge(in_clk);

		end loop;

		file_close(out_file_image);

		wait;
		
	end process;

end data_proxy_testbench;