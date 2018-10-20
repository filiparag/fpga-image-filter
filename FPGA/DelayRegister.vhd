--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;


entity DelayRegister is
	generic 
	(
		N	 			: integer								                := 8
	);
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector (23 downto 0);

		out_ready		: out std_logic; 
		out_data		: out std_logic_vector (23 downto 0)
	);
end DelayRegister;


architecture delay_register of DelayRegister is

	signal ready_reg			: std_logic_vector(N - 1 downto 0);
	signal data_reg				: std_logic_vector(N * 24 - 1 downto 0);

begin

	out_ready <= ready_reg(N - 1);
	out_data <= data_reg(N * 24 - 1 downto (N - 1) * 24);

	reg_shift : process(in_clk)
	begin
		if rising_edge(in_clk) then
			ready_reg <= ready_reg(N - 2 downto 0) & in_ready;

			data_reg <= data_reg((N - 1) * 24 - 1 downto 0) & in_data;

		end if;
	end process reg_shift;
end delay_register;