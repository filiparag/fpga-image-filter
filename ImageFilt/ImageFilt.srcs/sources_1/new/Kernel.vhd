library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Kernel is
    Port (
        in_clk :            in  STD_LOGIC;
        in_write :          in  STD_LOGIC;
        in_data :           in  STD_LOGIC_VECTOR (7 downto 0);
        out_ready :         out STD_LOGIC;
        out_data :          out STD_LOGIC_VECTOR ((15 * 15 * 8 - 1)  downto 0)
    );
end Kernel;

architecture arch_kernel of Kernel is
    signal  reg 			: STD_LOGIC_VECTOR ((15 * 15 * 8 - 1)  downto 0);
	signal  pixel_count 	: UNSIGNED(7 downto 0) := (others => '0');
begin
    out_data <= reg;
	kernel_reg_shift : process(in_clk)
	begin
		if rising_edge(in_clk) then
			if(pixel_count < 225) then
				out_ready <= '0';
				if(in_write = '1') then
					reg <= in_data & reg((225 * 8 - 1) downto 8);
					pixel_count <= pixel_count + 1;
				end if;
			else
				out_ready <= '1';
			end if;
		end if;
	end process kernel_reg_shift;
end arch_kernel;
