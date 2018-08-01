library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity PriorityEncoder is
	generic
	(
		gen_lookup		: String(1 to 3)
	);
	port
	(
		in_clk			: in 	std_logic;
		in_histogram	: in 	histogram;
		out_value		: out 	pixel
	);
end PriorityEncoder;

architecture priority_encoder of PriorityEncoder is
begin

	process( in_clk )

		variable treshold 	: unsigned (7 downto 0);
		variable reached	: std_logic := '0';

	begin

		if gen_lookup = "min" then
			treshold := to_unsigned(1, 8);
		elsif gen_lookup = "max" then
			treshold := to_unsigned((kernel_dimension * kernel_dimension) - 1, 8);
		elsif gen_lookup = "med" then
			treshold := to_unsigned((kernel_dimension * kernel_dimension + 1) / 2, 8);
		end if;

		if rising_edge(in_clk) then

			for p in 0 to 255 loop
				if reached = '0' then
					if unsigned(in_histogram(p)) >= treshold then
						reached := '1';
						out_value <= pixel(to_unsigned(p, 8));
					end if;
				end if;
			end loop;

		end if;
		
	end process;

end priority_encoder;