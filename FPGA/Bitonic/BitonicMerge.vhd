--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity BitonicMerge is
    generic 
    (
		N	 			: integer								                    := 8
    );
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector ((2 ** N) * 8 - 1 downto 0);

		out_ready		: out std_logic                                             := '0';
        out_data		: out std_logic_vector ((2 ** N) * 8 - 1 downto 0);
        finished        : out std_logic                                             := '0'
	);
end BitonicMerge;


architecture bitonic_merge of BitonicMerge is

    signal temp		    : std_logic_vector ((2 ** N) * 8 - 1 downto 0);
    signal in_data1		: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0)        := (others => '0');
	signal out_data1	: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0);
	signal in_data2		: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0)        := (others => '0');
    signal out_data2	: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0);
    signal out_ready1	: std_logic;
    signal out_ready2	: std_logic;
    signal comp_finished: std_logic                                                 := '0';

	component BitonicMerge
	generic 
    (
		N	 			: integer
    );
    port 
    (
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector ((2 ** N) * 8 - 1 downto 0);

		out_ready		: out std_logic                                             := '0';
        out_data		: out std_logic_vector ((2 ** N) * 8 - 1 downto 0);
        finished        : out std_logic                                             := '0'
	);
	end component;

begin

    finished <= comp_finished;

    BMsimple : if N = 1 generate
        out_data <= temp;
        out_ready <= comp_finished;
    end generate;

    BMrec : if N > 1 generate

        BM1: BitonicMerge
        generic map (N - 1)
        port map 
        (
            in_clk => in_clk,
            in_ready => comp_finished,
            in_data => in_data1,
            out_ready => out_ready1,
            out_data => out_data1
        );

        BM2: BitonicMerge
        generic map (N - 1)
        port map 
        (
            in_clk => in_clk, 
            in_ready => comp_finished, 
            in_data => in_data2, 
            out_ready => out_ready2, 
            out_data => out_data2
        );

        out_ready <= out_ready1 and out_ready2;

        in_data1 <= temp((2 ** (N - 1)) * 8 - 1 downto 0);
        in_data2 <= temp((2 ** N) * 8 - 1 downto (2 ** (N - 1)) * 8);

        out_data ((2 ** (N - 1)) * 8 - 1 downto 0) <= out_data1;
        out_data ((2 ** N) * 8 - 1 downto (2 ** (N - 1)) * 8) <= out_data2;
        
    end generate BMrec;

	process (
	in_clk
    )
        variable comp1 	    : unsigned (7 downto 0) := (others => '0');
        variable comp2 	    : unsigned (7 downto 0) := (others => '0');
    begin
        if rising_edge(in_clk) and in_ready = '1' then

            if in_ready = '1' and comp_finished = '0' then
                comp_finished <= '1';
            end if;

            for i in 0 to 2 ** (N - 1) - 1 loop
                comp1 := unsigned(in_data ((i * 8 + 7) downto i * 8));
                comp2 := unsigned(in_data ((i * 8 + (2 ** (N - 1)) * 8 + 7) downto (i * 8 + (2 ** (N - 1)) * 8)));
                if comp1 > comp2 then
                    for j in 7 downto 0 loop
                        temp (i * 8 + j) <= comp2 (j);
                        temp (i * 8 + (2 ** (N - 1)) * 8 + j) <= comp1 (j);
                    end loop;
                else
                    for j in 7 downto 0 loop
                        temp (i * 8 + j) <= comp1 (j);
                        temp (i * 8 + (2 ** (N - 1)) * 8 + j) <= comp2 (j);
                    end loop;
                end if;
            end loop;
		end if;
    end process;

end bitonic_merge;
