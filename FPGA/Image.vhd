library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library CustomTypes;
use CustomTypes.CustomTypes.all;

entity Image is 
	port
	(
		in_clk			: in STD_LOGIC;
		in_write		: in STD_LOGIC;
		in_data			: in pixel;

		out_ready		: out STD_LOGIC;
		out_data		: out kernel_slice_row
	);

end Image;	

architecture image of Image is

	signal image_matrix : image_slice;

begin

	process (
		in_clk,
		in_write,
		in_data
	)
	begin

		if rising_edge(in_clk) then
			if in_write = '1' then
				image_matrix(0)(0) <= in_data;
			end if;
		end if;

	end process;

end image;


