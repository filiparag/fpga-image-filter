--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity ImageProc is
	port
	(
		in_clk				: in std_logic;
		in_ready			: in std_logic;
		in_data				: in pixel;

		out_ready 			: out std_logic;
		out_data 			: out pixel
	);

end ImageProc;

architecture image_proc of ImageProc is

	signal image_ready		: std_logic;
	signal image_data		: kernel_row;
	signal in_image_write	: std_logic;
	signal in_kernel_write	: std_logic;
	signal in_image_data	: pixel;
	signal in_kernel_data	: pixel;

	signal out_image_ready	: std_logic;
	signal out_image_data	: kernel_row;

	signal out_kernel_ready	: std_logic;
	signal out_kernel_data	: window_matrix;

	signal window_ready		: std_logic;
	signal window_data		: window_matrix;



	component DataProxy
	port (
		in_clk				: in std_logic;
		in_ready			: in std_logic;
		in_data				: in pixel;

		out_image_write		: out std_logic;
		out_kernel_write	: out std_logic;
		out_image			: out pixel;
		out_kernel			: out pixel
	);
	end component;

	component Kernel
	port (
		in_clk				: in std_logic;
		in_write			: in std_logic;
		in_data				: in pixel;

		out_ready			: out std_logic;
		out_data			: out window_matrix
	);
	end component;

	component Image
	port (
		in_clk				: in std_logic;
		in_write			: in std_logic;
		in_data				: in pixel;

		out_ready			: out std_logic;
		out_data			: out kernel_row
	);
	end component;

	component Window
	port (
		in_clk 				: in std_logic;
		in_ready 			: in std_logic;
		in_data 			: in kernel_row;
		
		out_ready 			: out std_logic;
		out_data 			: out window_matrix
		);
	end component;

	component LinearFilter
	port (

		in_clk				: in std_logic;
		in_kernel_ready		: in std_logic;
		in_window_ready		: in std_logic;
		in_kernel_data		: in window_matrix;
		in_window_data		: in window_matrix;

		out_ready			: out std_logic; 
		out_data			: out pixel
		);
	end component;

begin


	data_proxy_comp : DataProxy
	port map (in_clk, in_ready, in_data, in_image_write, in_kernel_write, in_image_data, in_kernel_data);

	kernel_comp : Kernel
	port map (in_clk, in_kernel_write, in_kernel_data, out_kernel_ready, out_kernel_data);

	image_comp : Image
	port map (in_clk, in_image_write, in_image_data, out_image_ready, out_image_data);

	window_comp : Window
	port map (in_clk, out_image_ready, out_image_data, window_ready, window_data);

	linear_filter_comp : LinearFilter
	port map (in_clk, out_kernel_ready, window_ready, out_kernel_data, window_data, out_ready, out_data);

	-- linear_filter_comp : LinearFilter
	-- port map (in_clk, image_ready, image_data, out_ready, out_data);

	-- process (
	-- in_clk
	-- )
	-- begin
	-- 	if rising_edge(in_clk) then
			
	-- 	end if;
	-- end process;
end image_proc;
