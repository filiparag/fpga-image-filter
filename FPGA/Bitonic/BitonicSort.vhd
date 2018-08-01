--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity BitonicSort is
    generic 
    (
		N	 			: integer								                := 8
    );
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector ((2 ** N) * 8 - 1 downto 0);

		out_ready		: out std_logic;
		out_data		: out std_logic_vector ((2 ** N) * 8 - 1 downto 0)
	);
end BitonicSort;


architecture bitonic_sort of BitonicSort is

    signal temp		    : std_logic_vector ((2 ** N) * 8 - 1 downto 0);
    signal in_data1		: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0)        := (others => '0');
	signal out_data1	: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0);
	signal in_data2		: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0)        := (others => '0');
    signal out_data2	: std_logic_vector ((2 ** (N - 1)) * 8 - 1 downto 0);
    signal out_ready1	: std_logic;
	signal out_ready2	: std_logic;
	signal out_ready_temp	: std_logic;

	component BitonicSort
	generic 
    (
		N	 			: integer								                := 8
    );
	port
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector ((2 ** N) * 8 - 1 downto 0);

		out_ready		: out std_logic;
		out_data		: out std_logic_vector ((2 ** N) * 8 - 1 downto 0)
	);
	end component;

	component BitonicMerge
	generic 
    (
		N	 			: integer								                := 8
    );
	port 
	(
		in_clk			: in std_logic;
		in_ready		: in std_logic;
		in_data			: in std_logic_vector ((2 ** N) * 8 - 1 downto 0);

		out_ready		: out std_logic;
		out_data		: out std_logic_vector ((2 ** N) * 8 - 1 downto 0);
		finished        : out std_logic                                        	:= '0'
	);
	end component;


begin
	BMsimple : if N = 1 generate
		

		BM: BitonicMerge
		generic map (N)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_ready,
			in_data => in_data,
			out_ready => out_ready,
			out_data => out_data
		);
	end generate;

	BMrec : if N > 1 generate
		out_ready_temp <= out_ready1 and out_ready2;
		BM: BitonicMerge
		generic map (N)
		port map 
		(
			in_clk => in_clk,
			in_ready => out_ready_temp,
			in_data => temp,
			out_ready => out_ready,
			out_data => out_data
		);

		BS1: BitonicSort
		generic map (N - 1)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_ready,
			in_data => in_data ((2 ** N) * 8 - 1 downto (2 ** (N - 1)) * 8),
			out_ready => out_ready1,
			out_data => out_data1
		);

		BS2: BitonicSort
		generic map (N - 1)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_ready,
			in_data => in_data ((2 ** (N - 1)) * 8 - 1 downto 0),
			out_ready => out_ready2,
			out_data => out_data2
		);

		temp ((2 ** N) * 8 - 1 downto (2 ** (N - 1)) * 8) <= out_data1;

		f : for i in 0 to (2 ** (N - 1)) - 1 generate
			temp (i * 8 + 7 downto i * 8) <= out_data2 (((2 ** (N - 1)) - 1 - i) * 8 + 7 downto ((2 ** (N - 1)) - 1 - i) * 8);
		end generate f;
	end generate;


	process (
	in_clk
	)
	begin
        if rising_edge(in_clk) then
		end if;
	end process;

end bitonic_sort;
