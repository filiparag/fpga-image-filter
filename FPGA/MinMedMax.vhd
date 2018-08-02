library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity MinMedMax is 
	port
	(
		in_clk			: in 	std_logic;
		in_write		: in 	std_logic;
		in_data			: in 	window_matrix;

		out_median		: out 	min_med_max;
		out_maximum		: out 	min_med_max;
		out_minimum		: out 	min_med_max;
		out_ready		: out 	std_logic
	);

end MinMedMax;

architecture arch_median_histogram of MinMedMax is

	component MEDIAN_HISTOGRAM
		generic
		( 
			in_dimension : unsigned (7 downto 0)
		);
		port (
			in_clk		 : in std_logic;
			in_write	 : in std_logic;
			in_data		 : in window_matrix;
			out_median	 : in pixel;
			out_maximum	 : in pixel;
			out_minimum	 : in pixel;
			out_ready	 : in std_logic
		);
	end component;

	signal s_ready		 : std_logic_vector(6 downto 0);

begin
		
	MH_GEN : for dimension in 1 to 7 generate
		MED_HIST : entity work.MedianHistogram(median_histogram)
		generic map
		( 
			in_dimension => to_unsigned(2 * dimension + 1, 8)
		)
		port map (
			in_clk		 => in_clk,
			in_write	 => in_write,
			in_data		 => in_data,
			out_median	 => out_median(dimension - 1),
			out_maximum	 => out_maximum(dimension - 1),
			out_minimum	 => out_minimum(dimension - 1),
			out_ready	 => s_ready(dimension - 1)
		);
	end generate;

	process(in_clk)
	begin

		if rising_edge(in_clk) then
			if s_ready = "1111111" then
				out_ready <= '1';
			else
				out_ready <= '0';
			end if;
		end if;

	end process;
	
end arch_median_histogram;

architecture bitonic_sort of MinMedMax is
	signal in_data_vect 	: std_logic_vector ((kernel_dimension * kernel_dimension - 1) * 8 - 1 downto 0);
	signal in_data_vect 	: std_logic_vector ((kernel_dimension * kernel_dimension - 1) * 8 - 1 downto 0);

	signal in_15 			: std_logic_vector (255 * 8 - 1 downto 0);
	signal in_13 			: std_logic_vector (255 * 8 - 1 downto 0);
	signal in_11 			: std_logic_vector (127 * 8 - 1 downto 0);
	signal in_9 			: std_logic_vector (127 * 8 - 1 downto 0);
	signal in_7 			: std_logic_vector (63 * 8 - 1 downto 0);
	signal in_5 			: std_logic_vector (31 * 8 - 1 downto 0);
	signal in_3 			: std_logic_vector (15 * 8 - 1 downto 0);

	signal out_15 			: std_logic_vector (255 * 8 - 1 downto 0);
	signal out_13 			: std_logic_vector (255 * 8 - 1 downto 0);
	signal out_11 			: std_logic_vector (127 * 8 - 1 downto 0);
	signal out_9 			: std_logic_vector (127 * 8 - 1 downto 0);
	signal out_7 			: std_logic_vector (63 * 8 - 1 downto 0);
	signal out_5 			: std_logic_vector (31 * 8 - 1 downto 0);
	signal out_3 			: std_logic_vector (15 * 8 - 1 downto 0);

	signal ready_15			: std_logic;
	signal ready_13			: std_logic;
	signal ready_11			: std_logic;
	signal ready_9			: std_logic;
	signal ready_7			: std_logic;
	signal ready_5			: std_logic;
	signal ready_3			: std_logic;

	signal delay_in_11 		: std_logic_vector (23 downto 0);
	signal delay_in_9 		: std_logic_vector (23 downto 0);
	signal delay_in_7 		: std_logic_vector (23 downto 0);
	signal delay_in_5 		: std_logic_vector (23 downto 0);
	signal delay_in_3 		: std_logic_vector (23 downto 0);

	signal delay_ready_11	: std_logic;
	signal delay_ready_9	: std_logic;
	signal delay_ready_7	: std_logic;
	signal delay_ready_5	: std_logic;
	signal delay_ready_3	: std_logic;

	signal delay_out_11 	: std_logic_vector (23 downto 0);
	signal delay_out_9 		: std_logic_vector (23 downto 0);
	signal delay_out_7 		: std_logic_vector (23 downto 0);
	signal delay_out_5 		: std_logic_vector (23 downto 0);
	signal delay_out_3 		: std_logic_vector (23 downto 0);

	component BitonicSort
	generic 
    (
		N	 				: integer								                := 8
    );
	port
	(
		in_clk				: in std_logic;
		in_ready			: in std_logic;
		in_data				: in std_logic_vector ((2 ** N) * 8 - 1 downto 0);

		out_ready			: out std_logic;
		out_data			: out std_logic_vector ((2 ** N) * 8 - 1 downto 0)
	);
	end component;

	component DelayRegister
	generic 
    (
		N	 				: integer								                := 8
    );
	port
	(
		in_clk				: in std_logic;
		in_ready			: in std_logic;
		in_data				: in std_logic_vector (23 downto 0);

		out_ready			: out std_logic;
		out_data			: out std_logic_vector (23 downto 0)
	);
	end component;

	begin
		out_ready <= ready_15 and ready_13 and delay_ready_11 and delay_ready_9 and delay_ready_7 and delay_ready_5 and delay_ready_3;

		f_15_1 : for i in 0 to 14 generate
			f_15_2 : for j in 0 to 14 generate
				f_15_3	: for k in 0 to 7 generate
					in_15 ((i * 15 + j) * 8 + k) <= in_data (i * 15 + j) (k);
				end generate;
			end generate;
		end generate;

		f_15_4 : for i in 225 to 255 generate
			in_15 (i * 8 + 7 downto i * 8) <= "00000000";
		end generate;

		f_13_1 : for i in 1 to 13 generate
			f_13_2 : for j in 1 to 13 generate
				f_13_3	: for k in 0 to 7 generate
					in_13 (((i - 1) * 15 + j - 1) * 8 + k) <= in_data (i * 15 + j) (k);
				end generate;
			end generate;
		end generate;

		f_13_4 : for i in 169 to 255 generate
			in_13 (i * 8 + 7 downto i * 8) <= "00000000";
		end generate;

		f_11_1 : for i in 2 to 12 generate
			f_11_2 : for j in 2 to 12 generate
				f_11_3	: for k in 0 to 7 generate
					in_11 (((i - 2) * 15 + j - 2) * 8 + k) <= in_data (i * 15 + j) (k);
				end generate;
			end generate;
		end generate;

		f_11_4 : for i in 121 to 127 generate
			in_11 (i * 8 + 7 downto i * 8) <= "00000000";
		end generate;

		f_9_1 : for i in 3 to 11 generate
			f_9_2 : for j in 3 to 11 generate
				f_9_3	: for k in 0 to 7 generate
					in_9 (((i - 3) * 15 + j - 3) * 8 + k) <= in_data (i * 15 + j) (k);
				end generate;
			end generate;
		end generate;

		f_9_4 : for i in 81 to 127 generate
			in_9 (i * 8 + 7 downto i * 8) <= "00000000";
		end generate;

		f_7_1 : for i in 4 to 10 generate
			f_7_2 : for j in 4 to 10 generate
				f_7_3	: for k in 0 to 7 generate
					in_7 (((i - 4) * 15 + j - 4) * 8 + k) <= in_data (i * 15 + j) (k);
				end generate;
			end generate;
		end generate;

		f_7_4 : for i in 49 to 63 generate
			in_7 (i * 8 + 7 downto i * 8) <= "00000000";
		end generate;

		f_5_1 : for i in 5 to 9 generate
			f_5_2 : for j in 5 to 9 generate
				f_5_3	: for k in 0 to 7 generate
					in_5 (((i - 5) * 15 + j - 5) * 8 + k) <= in_data (i * 15 + j) (k);
				end generate;
			end generate;
		end generate;

		f_5_4 : for i in 25 to 32 generate
			in_5 (i * 8 + 7 downto i * 8) <= "00000000";
		end generate;

		f_3_1 : for i in 6 to 8 generate
			f_3_2 : for j in 6 to 8 generate
				f_3_3	: for k in 0 to 7 generate
					in_3 (((i - 6) * 15 + j - 6) * 8 + k) <= in_data (i * 15 + j) (k);
				end generate;
			end generate;
		end generate;

		f_3_4 : for i in 9 to 16 generate
			in_3 (i * 8 + 7 downto i * 8) <= "00000000";
		end generate;
		
		delay_in_11(7 downto 0) <= out_11 (127 * 8 + 7 downto 127 * 8);
		delay_in_11(15 downto 8) <= out_11 (67 * 8 + 7 downto 67 * 8);
		delay_in_11(23 downto 16) <= out_11 (7 * 8 + 7 downto 7 * 8);

		delay_in_9(7 downto 0) <= out_9 (127 * 8 + 7 downto 127 * 8);
		delay_in_9(15 downto 8) <= out_9 (87 * 8 + 7 downto 67 * 8);
		delay_in_9(23 downto 16) <= out_9 (47 * 8 + 7 downto 47 * 8);

		delay_in_7(7 downto 0) <= out_7 (63 * 8 + 7 downto 63 * 8);
		delay_in_7(15 downto 8) <= out_7 (39 * 8 + 7 downto 39 * 8);
		delay_in_7(23 downto 16) <= out_7 (15 * 8 + 7 downto 15 * 8);

		delay_in_5(7 downto 0) <= out_5 (31 * 8 + 7 downto 31 * 8);
		delay_in_5(15 downto 8) <= out_5 (19 * 8 + 7 downto 19 * 8);
		delay_in_5(23 downto 16) <= out_5 (7 * 8 + 7 downto 7 * 8);

		delay_in_3(7 downto 0) <= out_3 (15 * 8 + 7 downto 15 * 8);
		delay_in_3(15 downto 8) <= out_3 (11 * 8 + 7 downto 11 * 8);
		delay_in_3(23 downto 16) <= out_3 (7 * 8 + 7 downto 7 * 8);

		f_out_1 : for i in 0 to 7 generate
			out_maximmum (0)(i) <= out_15 (255 * 8 + i);
			out_median (0)(i) <= out_15 (143 * 8 + i);
			out_minimum (0)(i) <= out_15 (31 * 8 + i);

			out_maximmum (1)(i) <= out_13 (255 * 8 + i);
			out_median (1)(i) <= out_13 (171 * 8 + i);
			out_minimum (1)(i) <= out_13 (87 * 8 + i);

			out_maximmum (2)(i) <= delay_out_11 (i);
			out_median (2)(i) <= delay_out_11 (8 + i);
			out_minimum (2)(i) <= delay_out_11 (16 + i);

			out_maximmum (3)(i) <= delay_out_9 (i);
			out_median (3)(i) <= delay_out_9 (8 + i);
			out_minimum (3)(i) <= delay_out_9 (16 + i);

			out_maximmum (4)(i) <= delay_out_7 (i);
			out_median (4)(i) <= delay_out_7 (8 + i);
			out_minimum (4)(i) <= delay_out_7 (16 + i);

			out_maximmum (5)(i) <= delay_out_5 (i);
			out_median (5)(i) <= delay_out_5 (8 + i);
			out_minimum (5)(i) <= delay_out_5 (16 + i);

			out_maximmum (6)(i) <= delay_out_3 (i);
			out_median (6)(i) <= delay_out_3 (8 + i);
			out_minimum (6)(i) <= delay_out_3 (16 + i);

		end generate;

		--Components
		BS15: BitonicSort
		generic map (8)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_write,
			in_data => in_15,
			out_ready => ready_15,
			out_data => out_15
		);
		BS13: BitonicSort
		generic map (8)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_write,
			in_data => in_13,
			out_ready => ready_13,
			out_data => out_13
		);
		BS11: BitonicSort
		generic map (7)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_write,
			in_data => in_11,
			out_ready => ready_11,
			out_data => out_11
		);
		BS9: BitonicSort
		generic map (7)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_write,
			in_data => in_9,
			out_ready => ready_9,
			out_data => out_9
		);
		BS7: BitonicSort
		generic map (6)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_write,
			in_data => in_7,
			out_ready => ready_7,
			out_data => out_7
		);
		BS5: BitonicSort
		generic map (5)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_write,
			in_data => in_5,
			out_ready => ready_5,
			out_data => out_5
		);
		BS3: BitonicSort
		generic map (4)
		port map 
		(
			in_clk => in_clk,
			in_ready => in_write,
			in_data => in_3,
			out_ready => ready_3,
			out_data => out_3
		);


		DR11: DelayRegister
		generic map (8)
		port map 
		(
			in_clk => in_clk,
			in_ready => ready_11,
			in_data => delay_in_11,
			out_ready => delay_ready_11,
			out_data => delay_out_11
		);
		DR9: DelayRegister
		generic map (8)
		port map 
		(
			in_clk => in_clk,
			in_ready => ready_9,
			in_data => delay_in_9,
			out_ready => delay_ready_9,
			out_data => delay_out_9
		);
		DR7: DelayRegister
		generic map (15)
		port map 
		(
			in_clk => in_clk,
			in_ready => ready_7,
			in_data => delay_in_7,
			out_ready => delay_ready_7,
			out_data => delay_out_7
		);
		DR5: DelayRegister
		generic map (21)
		port map 
		(
			in_clk => in_clk,
			in_ready => ready_5,
			in_data => delay_in_5,
			out_ready => delay_ready_5,
			out_data => delay_out_5
		);
		DR3: DelayRegister
		generic map (26)
		port map 
		(
			in_clk => in_clk,
			in_ready => ready_3,
			in_data => delay_in_3,
			out_ready => delay_ready_3,
			out_data => delay_out_3
		);
		
	end bitonic_sort;
