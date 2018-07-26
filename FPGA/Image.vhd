--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

use work.CustomTypes.all;

entity Image is 
	port
	(
		in_clk			: in std_logic;
		in_write		: in std_logic;
		in_data			: in pixel;

		out_ready		: out std_logic := '0';
		out_data		: out kernel_row
	);

end Image;	

architecture image of Image is

	signal shift_register 	: image_slice;
	signal pixel_count_in	: unsigned (11 downto 0) := (others => '0');
	signal pixel_count_out	: unsigned (11 downto 0) := (others => '0');

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
				pixel_count_in <= pixel_count_in + 1;
				
			end if;

			if pixel_count_out > pixel_count_in then

				out_ready <= '0';

			elsif pixel_count_in > image_slice_width * (image_slice_height - 1) + 1 then
				
				out_ready <= '1';

				for index in 0 to (kernel_dimension - 1) loop
					out_data(index) <= shift_register(index * image_slice_width + 1);
				end loop;
				pixel_count_out <= pixel_count_out + kernel_dimension;

			end if;

		end if;

	end process;
end image;