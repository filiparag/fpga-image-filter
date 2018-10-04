library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Window is
    Port (
        in_clk :            in  STD_LOGIC;
        in_ready :          in  STD_LOGIC;
        in_data :           in  STD_LOGIC_VECTOR ((15 * 8 - 1) downto 0);
        out_ready :         out STD_LOGIC;
        out_data :          out STD_LOGIC_VECTOR ((15 * 15 * 8 - 1) downto 0)
    );
end Window;

architecture arch_window of Window is
    signal window_reg	    : STD_LOGIC_VECTOR ((15 * 15 * 8 - 1) downto 0);
begin
	out_data <= window_reg;
	window_reg_shift : process (in_clk)
	begin
		if rising_edge(in_clk) then
			if in_ready = '1' then
				for i in 14 downto 0 loop
                    window_reg((15 * 8 * i - 8 - 1) downto (15 * 8 * i)) <= 
                      window_reg((15 * 8 * i - 1) downto (15 * 8 * i + 8));
				end loop;
				for i in 15 downto 1 loop
					window_reg((15 * 8 * i + 15 * 8 - 1) downto (15 * 8 * i + 14 * 8)) <= in_data((8 * i - 1) downto (8 * (i - 1)));
				end loop;
			else
				out_ready <= '0';
			end if;
		end if;
	end process window_reg_shift;

end arch_window;
