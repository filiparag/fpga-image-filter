--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity ImageProc is
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: kernel_row;

		out_ready		: out std_logic;
		out_data		: out window_matrix
	);

end ImageProc;

architecture image_proc of ImageProc is

begin

	process (
	in_clk
	)
	begin
		if rising_edge(in_clk) then
			
		end if;
	end process;
end image_proc;
