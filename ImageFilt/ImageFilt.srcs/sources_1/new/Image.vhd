library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Image is
    Port (
        in_clk :            in  STD_LOGIC;
        in_write :          in  STD_LOGIC;
        in_data :           in  STD_LOGIC_VECTOR (7 downto 0);
        out_ready :         out STD_LOGIC;
        out_data :          out STD_LOGIC_VECTOR ((15 * 8 - 1) downto 0)
    );
end Image;

architecture arch_image of Image is
    signal shift_register 	: STD_LOGIC_VECTOR ((256 * 15 * 8 - 1) downto 0);
	signal pixel_count		: UNSIGNED (19 downto 0) := (others => '0');
	signal row_count 	    : UNSIGNED (7 downto 0) := (others => '0');
begin
    output : for row in 14 downto 0  generate
		out_data(((row + 1) * 8 - 1) downto (row * 8 - 1)) <= shift_register((row * 8 * 256 + 7) downto (row * 8 * 256));
	end generate output;
    shift_image : process (in_clk)
    begin
        if rising_edge(in_clk) then
            if in_write = '1' then
                shift_register((256 * 15 * 8 - 1) downto 8) <= shift_register((256 * 15 * 8 - 9) downto 0);
                shift_register(7 downto 0) <= in_data;
                pixel_count <= pixel_count + 1;
                if pixel_count > (256 * 14 - 1) then    
                    if row_count = 256 then
                        row_count <= "00000000";
                    else
                        row_count <= row_count + 1;
                    end if;
                    if row_count > (15 - 2) then
                        out_ready <= '1';
                    else
                        out_ready <= '0';
                    end if;
                end if;
            else 
                out_ready <= '0';
            end if;
        end if;
    end process shift_image;
end arch_image;
