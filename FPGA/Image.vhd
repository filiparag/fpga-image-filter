library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library CustomTypes;
use CustomTypes.CustomTypes.all;

entity Image is
	generic 
	(
		image_width 	: integer := 256;
		image_height 	: integer := 15
	);
	port
	(
		in_clk			: in STD_LOGIC;
		in_write		: in STD_LOGIC;
		in_data			: in STD_LOGIC_VECTOR (7 downto 0);

		out_ready		: out STD_LOGIC;
		out_data		: out STD_LOGIC_VECTOR (7 downto 0)
	);

end Image;	

architecture image of Image is

	type data_byte 		is array (7 downto 0) 					of STD_LOGIC_VECTOR;
	type data_row 		is array (image_width - 1 downto 0) 	of data_byte;
	type data_matrix 	is array (image_height - 1 downto 0) 	of data_row;

	signal image_matrix : data_matrix;

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


