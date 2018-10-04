library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataProxy is
    Port (
        in_clk :             in  STD_LOGIC;
        in_ready :           in  STD_LOGIC;
        in_data :            in  STD_LOGIC_VECTOR (0 downto 0);
        out_image_write :    out STD_LOGIC;
        out_kernel_write :   out STD_LOGIC;
        out_image :          out STD_LOGIC_VECTOR (7 downto 0);
        out_kernel :         out STD_LOGIC_VECTOR (7 downto 0)
    );
end DataProxy;

architecture arch_data_proxy of DataProxy is
    signal  pixel_count 	 : UNSIGNED (7 downto 0) := (others => '0');
begin
    data_proxy : process (in_clk)
	begin
		if rising_edge(in_clk) then
			if in_ready = '1' then
				if pixel_count < 225 then
					pixel_count <= pixel_count + 1;
					out_kernel_write <= '1';
					out_image_write <= '0';
					out_kernel <= in_data;
				else
					out_kernel_write <= '0';
					out_image_write <= '1';
					out_image <= in_data;
				end if;
			else
				out_kernel_write <= '0';
				out_image_write <= '0';
			end if;
		end if;
	end process data_proxy;
end arch_data_proxy;
