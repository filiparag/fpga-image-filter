--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity DelayRegister is
    generic 
    (
		N	 			: integer								                := 8
    );
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector (23 downto 0);

		out_ready		: out std_logic;
		out_data		: out std_logic_vector (23 downto 0)
	);
end DelayRegister;


architecture delay_register of DelayRegister is
    signal reg          : std_logic_vector (24 * N - 1 downto 0)
begin
    out_data <= reg (24 * (N - 1) + 23 downto 24 * (N - 1))
	process (
	in_clk
	)
	begin
        if rising_edge(in_clk) and in_ready = '1' then
            for i in 0 to N - 2 loop
                reg ((i + 1) * 24 + 23 downto (i + 1) * 24) <=  reg (i * 24 + 23 downto i * 24)
                reg (23 downto 0) <= in_data;
            end loop;
		end if;
	end process;

end delay_register;
