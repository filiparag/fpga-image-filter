--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
use std.textio.all;
use work.CustomTypes.all;


-- Empty testbench entity
entity BitonicMergeTestbench is																	
end BitonicMergeTestbench;


architecture bitonic_merge_testbench of BitonicMergeTestbench is

	-- constants   
    constant clk_period				: time 				:= 30 ns;
    constant N				        : integer 			:= 8;
                                               
	-- signals                                                   
    signal in_clk			        : std_logic;
    signal in_ready		            : std_logic;
    signal in_data			        : std_logic_vector ((2 ** N) * 8 - 1 downto 0);

    signal out_ready		        : std_logic;
    signal out_data                 : std_logic_vector ((2 ** N) * 8 - 1 downto 0);

	--files
	file in_file 					: text;
	file out_file 					: text;

	--UUT component
    component BitonicMerge
    generic 
    (
		N	 			            : integer
    );
    port
	(
		in_clk			            : in std_logic;
		in_ready		            : in std_logic;
		in_data			            : in std_logic_vector ((2 ** N) * 8 - 1 downto 0);

		out_ready		            : out std_logic                                         := '1';
		out_data		            : out std_logic_vector ((2 ** N) * 8 - 1 downto 0)
	);
	end component;


begin

	--Signal mapping
    i1 : BitonicMerge
    generic map (N => N)
	port map (
        in_clk => in_clk,
        in_ready => in_ready,
        in_data => in_data,
        out_ready => out_ready,
        out_data => out_data
	);

	-- Generates clock for UUT
	clk_process : process                                                                               
	begin      
		in_clk <= '1';
		wait for clk_period/2;

		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process;   
	
	
	--Sends inputs and reads outputs of UUT
	bitonic_merge : process                                         

		variable in_line			: line;
		variable out_line			: line;
		variable in_data_var	    : std_logic_vector(2047 downto 0);
        variable pixel_vect_var		: std_logic_vector(7 downto 0);
        variable counter		    : integer                                               := 0;

    begin    
		--File opening
		file_open(in_file, "bitonic_merge_test.in",  read_mode);
		file_open(out_file, "bitonic_merge_test.out", write_mode);  
                
        in_ready <= '1';
		--Reading the in file
		while not endfile(in_file) loop
			readline(in_file, in_line);	
			read(in_line, pixel_vect_var);
            
            in_data_var (counter * 8 + 7 downto counter * 8) := pixel_vect_var(7 downto 0);
			counter := counter + 1;
		end loop;
		
		in_data <= in_data_var;
        
        wait until rising_edge(out_ready);
        wait until rising_edge(in_clk);
        if (out_ready = '1') then
            for i in 0 to 255 loop
                pixel_vect_var := out_data (i * 8 + 7 downto i * 8);
                write(out_line, pixel_vect_var, right, 8);
                writeline(out_file, out_line);
            end loop;
        end if;

		file_close(in_file);
		file_close(out_file);

		wait;
	end process bitonic_merge;
end bitonic_merge_testbench;
