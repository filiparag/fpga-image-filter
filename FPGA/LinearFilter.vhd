library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

use work.CustomTypes.all;

entity LinearFilter is
	port
	(
		in_clk					: in STD_LOGIC;
		in_kernel_ready			: in STD_LOGIC;
		in_window_ready			: in STD_LOGIC;
		in_kernel_data			: in window_matrix;
		in_window_data			: in window_matrix;

		out_ready				: out STD_LOGIC; 
		out_data				: out pixel
	);
end LinearFilter;


architecture linear_filter of LinearFilter is


begin

out_ready <= in_kernel_ready and in_window_ready;


	process(
		in_clk
	)
	variable param	 					: unsigned(7 downto 0) 		:= (others => '0');
	variable result 					: unsigned(30 downto 0)		:= (others => '0');
	variable counter 					: unsigned(7 downto 0) 		:= (others => '0');
	begin
		if rising_edge(in_clk) then
			for i in 0 to 15 loop
				for j in 0 to 15 loop
					param := unsigned (in_kernel_data (i * kernel_dimension + j)) * unsigned(in_window_data (i * kernel_dimension + j));
					result := result + param;
					if param /= "00000000" then
					counter := counter + 1;
					end if;
				end loop;
			end loop;
			result := result / counter;
			out_data <= pixel(result);
		end if;
	end process;

end linear_filter;