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
    type kernel_row         is array ((kernel_dimension - 1) downto 0) 	                        of pixel;
    type medminmax          is array (6 downto 0)                                               of pixel;
    type histogram          is array (255 downto 0) 	                                        of pixel;
    type histogram_binary   is array (255 downto 0) 	                                        of STD_LOGIC;

end package CustomTypes;