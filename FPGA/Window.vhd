--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity Window is
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: kernel_row;

		out_ready		: out std_logic;
		out_data		: out window_matrix
	);

end Window;

architecture window of Window is

	signal window_reg	: window_matrix;
	signal row_count 	: unsigned (7 downto 0) := (others => '0');

begin

	f1 : for i in 0 to kernel_dimension - 1 generate
		f2 : for j in 0 to kernel_dimension - 1 generate
			out_data(i * kernel_dimension + j) <= window_reg((kernel_dimension - i - 1) * kernel_dimension + j);
		end generate f2;
	end generate f1;


	process (
	in_clk
	)
	begin
		if rising_edge(in_clk) then
			if in_ready = '1' then
				for i in 0 to kernel_dimension - 2 loop
					for j in 0 to kernel_dimension - 1 loop
						window_reg((i + 1) * kernel_dimension + j) <= window_reg(i * kernel_dimension + j);
					end loop;
				end loop;
				
				for i in 0 to kernel_dimension - 1 loop
					window_reg(i) <= in_data(i);
				end loop;
				
				if row_count = image_slice_width then
					row_count <= "00000000";
				else
					row_count <= row_count + 1;
				end if;
	
				if row_count > kernel_dimension - 2 then
					out_ready <= '1';
				else
					out_ready <= '0';
				end if;
			else
				out_ready <= '0';
			end if;
		end if;
	end process;
end window;
