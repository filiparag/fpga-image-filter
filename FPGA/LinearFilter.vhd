--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity LinearFilter is
	port
	(
		in_clk				: in std_logic;
		in_kernel_ready		: in std_logic;
		in_window_ready		: in std_logic;
		in_kernel_data		: in window_matrix;
		in_window_data		: in window_matrix;

		out_ready			: out std_logic; 
		out_data			: out pixel
	);
end LinearFilter;


architecture linear_filter of LinearFilter is
begin

	out_ready <= in_kernel_ready and in_window_ready;

	ime : process
	(
		in_clk
	)
		variable param	 	: unsigned(15 downto 0) 	:= (others => '0');
		variable result 	: unsigned(30 downto 0)		:= (others => '0');
<<<<<<< Updated upstream
		variable counter 	: unsigned(12 downto 0) 	:= (others => '0');
	begin
		if rising_edge(in_clk) then
			counter := (others => '0');
=======
		variable counter 	: unsigned(10 downto 0) 	:= (others => '0');
	begin
		if rising_edge(in_clk) then
			--counter := "00000000";
>>>>>>> Stashed changes
			for i in 0 to 14 loop
				for j in 0 to 14 loop
					param := unsigned (in_kernel_data (i * kernel_dimension + j)) * unsigned(in_window_data (i * kernel_dimension + j));
					result := result + param;
<<<<<<< Updated upstream
					counter := counter + unsigned(in_kernel_data (i * kernel_dimension + j));
=======
					counter := counter + unsigned(in_window_data (i * kernel_dimension + j));
>>>>>>> Stashed changes
				end loop;
			end loop;
			if counter /= "0000000000" then
				result := result / counter;
			end if;
			for i in 0 to 7 loop
				out_data(i) <= result(i);
			end loop;
		end if;
	end process ime;
end linear_filter;