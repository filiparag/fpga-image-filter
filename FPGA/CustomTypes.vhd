library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

package CustomTypes is

    constant kernel_dimension    : integer := 15;
    constant image_slice_width   : integer := 256;
    constant image_slice_height  : integer := 15;

    type pixel 		        is array (7 downto 0)   				        of STD_LOGIC;
    type image_slice_row    is array ((image_slice_width - 1) downto 0)     of pixel;
    type kernel_slice_row   is array ((kernel_dimension - 1) downto 0) 	    of pixel;
    type image_slice	    is array ((image_slice_height - 1) downto 0)    of image_slice_row;
    type kernel             is array ((kernel_dimension - 1) downto 0) 	    of kernel_slice_row;

end package CustomTypes;