library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity DataFetcher is
	generic 
	(
		kernel_dim : integer := 15
		-- kernel_dim_bin :  := 15;
	);
	port
	(
		in_clk			: in STD_LOGIC;
		in_ready		: in STD_LOGIC;
		in_data			: in STD_LOGIC_VECTOR (7 downto 0);

		out_image_write	: out STD_LOGIC;
		out_kernel_write: out STD_LOGIC;
		out_image		: out STD_LOGIC_VECTOR (7 downto 0);
		out_kernel		: out STD_LOGIC_VECTOR (7 downto 0)
	);

end DataFetcher;

architecture data_fetcher of DataFetcher is

	signal pixel_count : unsigned (7 downto 0) := "11100001";

begin

	process (
		in_clk,
		in_data
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