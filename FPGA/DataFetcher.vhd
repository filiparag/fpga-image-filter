library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity DataFetcher is
	port
	(
		in_clk			: in STD_LOGIC;
		in_ready		: in STD_LOGIC;
		in_data			: in STD_LOGIC_VECTOR (7 downto 0);
		in_write_lock	: in STD_LOGIC;

		out_write_data	: out STD_LOGIC_VECTOR (7 downto 0);
		out_write_lock	: out STD_LOGIC
	);
end DataFetcher;

architecture data_fetcher of DataFetcher is

	-- signal pixel_count : unsigned (15 downto 0);

begin

	process (
		in_clk,
		in_data
	)
	begin
		if rising_edge(in_clk) then
			if in_ready = '1' and in_write_lock = '0' then
				out_write_lock <= '1';
				out_write_data <= in_data;
			end if;
		end if;
	end process;

end data_fetcher;
