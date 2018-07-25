--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;


entity Kernel is
	port
	(
		in_clk			: in std_logic;
		in_write		: in std_logic;
		in_data			: in pixel;

		out_ready		: out std_logic; 
		out_data		: out window_matrix
	);
end Kernel;


architecture kernel of Kernel is

	signal reg 			: window_matrix;
	signal pixel_count 	: unsigned(7 downto 0) := (others => '0');

begin

	out_data <= reg;

	kernel_reg_shift : process(in_clk)
	begin
		if rising_edge(in_clk) then
			if(pixel_count < (kernel_dimension * kernel_dimension)) then
				out_ready <= '0';
				if(in_write = '1') then
					reg <= in_data & reg((kernel_dimension * kernel_dimension) - 1 downto 1);
					pixel_count <= pixel_count + 1;
				end if;
			else
				out_ready <= '1';
			end if;
		end if;
	end process kernel_reg_shift;
end kernel;