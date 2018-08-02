library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity PriorityEncoder is
	generic
	(
		gen_lookup		: String(1 to 3) := "med";
		gen_dimension	: unsigned (7 downto 0) := to_unsigned(15, 8)
	);
	port
	(
		in_clk			: in 	std_logic;
		in_write		: in 	std_logic;
		in_histogram	: in 	histogram;
		out_value		: out 	pixel
	);
end PriorityEncoder;

architecture priority_encoder of PriorityEncoder is
begin

	process(in_clk, in_write)

		variable treshold 	: integer;

	begin

		if gen_lookup = "min" then
			treshold := 1;
		elsif gen_lookup = "max" then
			treshold := to_integer(gen_dimension * gen_dimension);
		elsif gen_lookup = "med" then
			treshold := to_integer(gen_dimension * gen_dimension + 1) / 2;
		end if;

		if rising_edge(in_clk) then
			if in_write = '1' then

				for p in 0 to 255 loop

					if unsigned(in_histogram(p)) >= to_unsigned(treshold, 8) then
						if p = 0 then
							out_value <= pixel(to_unsigned(p, 8));
						elsif unsigned(in_histogram(p-1)) < to_unsigned(treshold, 8) then
							out_value <= pixel(to_unsigned(p, 8));
						end if;
					end if;

				end loop;

			end if;
		end if;
		
	end process;

end priority_encoder;