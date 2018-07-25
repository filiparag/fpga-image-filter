--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity DataFetcher is
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector (7 downto 0);

		out_image_write	: out std_logic;
		out_kernel_write: out std_logic;
		out_image		: out std_logic_vector (7 downto 0);
		out_kernel		: out std_logic_vector (7 downto 0)
	);

end DataFetcher;

architecture data_fetcher of DataFetcher is

	signal pixel_count 	: unsigned (7 downto 0) := "11100001";

begin

	process (
		in_clk
	)
	begin

		if rising_edge(in_clk) then
			if in_ready = '1' then
				if pixel_count > 0 then
					pixel_count <= pixel_count - 1;
					out_kernel_write <= '1';
					out_image_write <= '0';
					out_kernel <= in_data;
				else
					out_kernel_write <= '0';
					out_image_write <= '1';
					out_image <= in_data;
				end if;
			end if;
		end if;
	end process;

end data_fetcher;
