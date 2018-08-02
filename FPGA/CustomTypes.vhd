library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


package CustomTypes is
	

    constant kernel_dimension    : integer := 15;
    constant image_slice_width   : integer := 256;
    constant image_slice_height  : integer := 15;


    type pixel 		        is array (7 downto 0)   				                            of STD_LOGIC;
    type image_slice	    is array ((image_slice_width * image_slice_height - 1) downto 0)    of pixel;
    type window_matrix      is array ((kernel_dimension * kernel_dimension - 1) downto 0) 	    of pixel;
    type window_matrix_bin  is array ((kernel_dimension * kernel_dimension - 1) downto 0) 	    of STD_LOGIC;
    type kernel_row         is array ((kernel_dimension - 1) downto 0) 	                        of pixel;

    type min_med_max        is array (6 downto 0)                                               of pixel;
    type histogram          is array (255 downto 0) 	                                        of pixel;
    type histogram_bin      is array (255 downto 0) 	                                        of STD_LOGIC;
    type histogram_in       is array (224 downto 0)                                             of pixel;
    type histogram_in_bin   is array (224 downto 0) 	                                        of STD_LOGIC;

    type histogram_dec_out  is array (224 downto 0) 	                                        of histogram_bin;
    type histogram_add_in   is array (255 downto 0) 	                                        of histogram_in_bin;

end package CustomTypes;