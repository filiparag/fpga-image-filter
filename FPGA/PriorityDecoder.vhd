library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity PriorityDecoder is
	port
	(
		in_clk			: in std_logic;
		in_value		: in pixel;
		out_values		: out histogram_binary
	);
end PriorityDecoder;

architecture priority_decoder of PriorityDecoder is
begin

	process( in_clk )
	begin

		if rising_edge(in_clk) then

			for value in 0 to 254 loop
				if (unsigned(in_value) >= to_unsigned(value, 8)) then
					out_values(value) <= '1';
				else
					out_values(value) <= '0';
				end if;
			end loop;

		end if;
		
	end process;

end priority_decoder;