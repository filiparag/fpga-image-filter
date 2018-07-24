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
		out_data		: out kernel_row
	);

end Image;	

architecture image of Image is

	signal shift_register 	: image_slice;
	signal pixel_count 		: unsigned (15 downto 0) := "00000000";

begin

	process (
		in_clk,
		in_write,
		in_data
	)
	begin

		if rising_edge(in_clk) then
			if in_write = '1' then
				
				shift_register((image_slice_width * image_slice_height - 1) downto 1) <= 
					shift_register((image_slice_width * image_slice_height - 2) downto 0);

				shift_register(0) <= in_data;
				pixel_count <= pixel_count + 1;

				if pixel_count >= (image_slice_width * image_slice_height - kernel_dimension + 1) then
					out_ready <= '1';
				end if;

			end if;
		end if;

		for index in 0 to kernel_dimension loop
		exit when index = kernel_dimension;
			out_data(index) <= shift_register(image_slice_width - kernel_dimension + 1);
		end loop;

	end process;

end image;


