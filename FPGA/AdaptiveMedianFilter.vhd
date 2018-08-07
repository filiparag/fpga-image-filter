library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity AdaptiveMedianFilter is 
	port
	(
		in_clk				: in std_logic;
		in_window_ready		: in std_logic;
		in_window_data		: in window_matrix;

		out_ready			: out std_logic; 
		out_data			: out pixel
	);

end AdaptiveMedianFilter;

architecture adaptive_median_filter of AdaptiveMedianFilter is

	signal s_minimum		: min_med_max;
	signal s_median			: min_med_max;
	signal s_maximum		: min_med_max;
	signal s_center			: ad_med_buffer;
	signal s_mmm_ready		: std_logic;

begin

	MMM : entity work.MinMedMax(arch_median_histogram)
	port map (
		in_clk		=> in_clk,
		in_write	=> in_window_ready,
		in_data		=> in_window_data,
		out_median	=> s_minimum,
		out_maximum	=> s_median,
		out_minimum	=> s_maximum,
		out_ready	=> s_mmm_ready
	);
	
	adaptive_median : process(in_clk)

		-- variable v_med_range	: std_logic_vector(6 downto 0);
		variable v_target		: pixel;
		variable v_dimension	: integer;

	begin
		
		if rising_edge(in_clk) then

			s_center(3 downto 1) <= s_center(2 downto 0);
			s_center(0) <= in_window_data(112);

			if s_mmm_ready = '1' then

				v_target := s_center(3);
				v_dimension := 7;

				for i in 0 to 6 loop
					if s_median(i) > s_minimum(i) and s_median(i) < s_maximum(i) then
						if v_dimension = 7 then
							v_dimension := i;
						end if;
					end if;
				end loop;

				if v_dimension = 7 then
					out_data <= v_target;
				else
					if v_target > s_minimum(v_dimension) and v_target < s_maximum(v_dimension) then
						out_data <= v_target;
					else
						out_data <= s_median(v_dimension);
					end if;
				end if;

				out_ready <= '1';

			else
				
					out_ready <= '0';

			end if;

		end if;

	end process;
	
end adaptive_median_filter;