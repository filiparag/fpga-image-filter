library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use STD.textio.all;                                                             
use work.CustomTypes.all;                             

ENTITY DataFetcher_vhd_tst IS
END DataFetcher_vhd_tst;

ARCHITECTURE DataFetcher_arch OF DataFetcher_vhd_tst IS
	-- constants                                           
	constant clk_period			: time 						:= 9 ns;
	constant clks_per_bit		: unsigned (19 downto 0) 	:= "00000000001111000010"; 
	--   (9 * 1000000000) clks / 11520 bits
	-- = 781250 clks / bit per second <=> 10111110101111000010
	
	file in_file 				: text;
	file out_file				: text;

	-- signals                                                   
	signal in_clk			: std_logic;
	signal in_reset			: std_logic;
	signal in_rx			: std_logic;
	signal out_tx			: std_logic;
	signal out_interrupt	: std_logic;
	signal out_readdata 	: std_logic_vector(0 to 7);
	signal in_writedata 	: std_logic_vector(0 to 7);
	signal in_read 			: std_logic;
	signal in_write 		: std_logic;

	COMPONENT DataFetcher
		PORT (
			in_clk			: in 		std_logic;
			in_reset		: in 		std_logic;
			in_rx			: in 		std_logic;
			out_tx			: buffer	std_logic;
			out_interrupt	: buffer 	std_logic;
			out_readdata 	: buffer	std_logic_vector(0 to 7);
			in_writedata 	: in		std_logic_vector(0 to 7);
			in_read 		: in		std_logic;
			in_write 		: in		std_logic
		);
	END COMPONENT;

BEGIN
	
	i1 : DataFetcher
	PORT MAP (
-- list connections between master ports and signals
		in_clk => in_clk,
		in_reset => in_reset,
		in_rx => in_rx,
		out_tx => out_tx,
		out_interrupt => out_interrupt,
		out_readdata => out_readdata,
		in_writedata => in_writedata,
		in_read => in_read,
		in_write => in_write
	);

	clk_process : process                                                                               
	begin      
		in_clk <= '1';
		wait for clk_period/2; 

		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process;

	-- uart_send : process

	-- 	variable in_line		: line;
	-- 	variable in_bit			: std_logic;
	-- 	variable clock_counter	: unsigned (19 downto 0) := clks_per_bit - 1;

	-- begin

	-- 	file_open(in_file, "data_fetcher.out.test", read_mode);
		
	-- 	in_read <= '1';

	-- 	-- start bit
	-- 	in_rx <= '1';
	-- 	while clock_counter > 0 loop
	-- 		clock_counter := clock_counter - 1;
	-- 		wait until rising_edge(in_clk);
	-- 	end loop;
	-- 	clock_counter := clks_per_bit - 1;
	-- 	-- start bit

	-- 	wait until rising_edge(in_clk);

	-- 	while not endfile(in_file) loop
	-- 		readline(in_file, in_line);	
	-- 		read(in_line, in_bit);

	-- 		in_rx <= in_bit;

	-- 		while clock_counter > 0 loop
	-- 			clock_counter := clock_counter - 1;
	-- 			wait until rising_edge(in_clk);
	-- 		end loop;

	-- 		clock_counter := clks_per_bit - 1;

	-- 	end loop;

	-- 	file_close(in_file);

	-- 	wait;
		
	-- end process;

end DataFetcher_arch;