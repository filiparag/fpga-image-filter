library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LinearFilter is
    Port ( 
        in_clk :            in  STD_LOGIC;
       in_kernel_ready :    in  STD_LOGIC;
       in_window_ready :    in  STD_LOGIC;
       in_kernel_data :     in  STD_LOGIC_VECTOR (224 downto 0);
       in_window_data :     in  STD_LOGIC_VECTOR (224 downto 0);
       out_ready :          out STD_LOGIC;
       out_data :           out STD_LOGIC_VECTOR (7 downto 0)
    );
end LinearFilter;

architecture arch_linear_filter of LinearFilter is
begin


end arch_linear_filter;
