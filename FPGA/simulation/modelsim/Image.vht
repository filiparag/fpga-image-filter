--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use STD.textio.all;                                                             

library work;
use work.customtypes.all;


-- Empty testbench entity
entity ImageTestbench is																	
end ImageTestbench;



architecture image_testbench of ImageTestbench is

	-- constants   
	constant clk_period 	: time := 10 ns;

	-- signals                                                   
	signal in_data 			: pixel;
	signal out_data 		: kernel_row;
	signal in_clk 			: std_logic;
	signal in_write			: std_logic;
	signal out_ready 		: std_logic;

	--files
	file in_file 			: text;
	file out_file 			: text;

	--UUT component
	component Image
		port (
			in_clk 			: in std_logic;
			in_write 		: in std_logic;
			out_ready 		: buffer std_logic;
			out_data 		: buffer kernel_row;
			in_data 		: in pixel
		);
	end component;

	--Signal mapping
	begin
		i1 : Image
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
		-- in_write <= '1';
		in_clk <= '1';
		wait for clk_period/2; 

		-- in_write <= '0';
		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process;       


	--Sends inputs and reads outputs of UUT
	send_kernel : process                                         

		variable in_line			: line;
		variable out_line			: line;
		variable in_pixel	 		: pixel;
		variable out_pixel    		: pixel;
		variable in_pixel_vect 		: std_logic_vector(7 downto 0);
		variable out_pixel_vect 	: std_logic_vector(7 downto 0);
		variable out_column_vect	: std_logic_vector(119 downto 0);
		variable temp				: std_logic_vector(7 downto 0) := (others => '0');

	begin    
		--File opening
		file_open(in_file, "image_input.in",  read_mode);
				
		in_write <= '1';

		--Reading the in file
		while not endfile(in_file) loop
			readline(in_file, in_line);	
			read(in_line, in_pixel_vect);

			--Converting std_vector to pixel
			for i in 7 downto 0 loop
				in_pixel(i) := in_pixel_vect(i);
			end loop;
			in_data <= in_pixel;

			wait until rising_edge(in_clk);
		end loop;
		
		in_data <= (others => '0');
		wait until rising_edge(in_clk);
		
		in_write <= '0';

		file_close(in_file);

		wait;
	end process send_kernel;

	--Sends inputs and reads outputs of UUT
	receive_output : process                                         

		variable out_line			: line;
		variable out_column_vect	: std_logic_vector(119 downto 0);

	begin    

		--File opening
		file_open(out_file, "image_output.out", write_mode);  

		--Waiting until UUT is ready
		wait until rising_edge(out_ready);
		wait until rising_edge(in_clk);

		-- Writing output in file
		while out_ready = '1' loop
			for i in 0 to 14 loop
				for j in 0 to 7 loop
					out_column_vect(i * 8 + j) := out_data(i)(j);
				end loop;
			end loop;
			write(out_line, out_column_vect);
			writeline(out_file, out_line);
			
			wait until rising_edge(in_clk);
		end loop;

		file_close(out_file);

		wait;
	end process receive_output;
	
end image_testbench;