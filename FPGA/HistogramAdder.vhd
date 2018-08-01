library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity HistogramAdder is
	port
	(
		in_clk			: in std_logic;
		in_values		: in histogram_in_bin;
		in_enabled		: in histogram_in_bin;
		out_sum			: out pixel
	);
end HistogramAdder;

architecture histogram_adder of HistogramAdder is
begin

	process( in_clk )

		variable sum : unsigned (7 downto 0) := (others => '0');

	begin

		if rising_edge(in_clk) then

			for p in 0 to 224 loop
				if in_values(p) = '1' and in_enabled(p) = '1' then
					sum := sum + 1;
				end if;
			end loop;

		end if;
		
	end process;

end histogram_adder;