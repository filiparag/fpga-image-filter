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

		out_ready		: out std_logic;
		out_data		: out kernel_row
	);

end Image;	

architecture image of Image is

	signal shift_register 	: image_slice;
	signal pixel_count		: unsigned (19 downto 0) := (others => '0');

begin

	f1 : for i in 0 to (kernel_dimension - 1)  generate
		out_data(kernel_dimension - i - 1) <= shift_register(i * image_slice_width);
	end generate f1;

	process (
		in_clk
	)
	begin

		if rising_edge(in_clk) then

			if in_write = '1' then
				
				shift_register((image_slice_width * image_slice_height - 1) downto 1) <= 
					shift_register((image_slice_width * image_slice_height - 2) downto 0);

				shift_register(0) <= in_data;
				pixel_count <= pixel_count + 1;

				if pixel_count > image_slice_width * (image_slice_height - 1) - 1 then	
					out_ready <= '1';
				end if; 
			else 
				out_ready <= '0';
			end if;

		end if;

	end process;
end image;