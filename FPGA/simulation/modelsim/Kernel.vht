-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "07/24/2018 12:10:52"
                                                            
-- Vhdl Test Bench template for design  :  Kernel
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 
LIBRARY STD; 
use STD.textio.all;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;                              

PACKAGE Kernel_data_type IS 
TYPE out_data_7_0_type IS ARRAY (7 DOWNTO 0) OF STD_LOGIC;
TYPE out_data_7_0_224_0_type IS ARRAY (224 DOWNTO 0) OF out_data_7_0_type;
SUBTYPE out_data_type IS out_data_7_0_224_0_type;
END Kernel_data_type;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

library work;
use work.Kernel_data_type.all;
use work.customtypes.all;

ENTITY Kernel_vhd_tst IS
END Kernel_vhd_tst;
ARCHITECTURE Kernel_arch OF Kernel_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL in_clk : STD_LOGIC;
SIGNAL in_data : pixel;
SIGNAL in_write : STD_LOGIC;
SIGNAL out_data : window_matrix;
SIGNAL out_ready : STD_LOGIC;
COMPONENT Kernel
	PORT (
	in_clk : IN STD_LOGIC;
	in_data : IN pixel;
	in_write : IN STD_LOGIC;
	out_data : BUFFER window_matrix;
	out_ready : BUFFER STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : Kernel
	PORT MAP (
-- list connections between master ports and signals
	in_clk => in_clk,
	in_data => in_data,
	in_write => in_write,
	out_data => out_data,
	out_ready => out_ready
	);
init : PROCESS                                               

    variable v_ILINE     : line;
    variable v_OLINE     : line;
    variable v_ADD_TERM1 : pixel;
    --variable v_ADD_TERM2 : std_logic_vector(c_WIDTH-1 downto 0);
    variable v_SPACE     : character;
                                    
BEGIN                                                        
	file_open(file_VECTORS, "kernel_test.in",  read_mode);
	file_open(file_RESULTS, "Kernel_test.out", write_mode);  
			
			
    while not endfile(file_VECTORS) loop
      readline(file_VECTORS, v_ILINE);
      read(v_ILINE, v_ADD_TERM1);
      read(v_ILINE, v_SPACE);           -- read in the space character
 
      -- Pass the variable to a signal to allow the ripple-carry to use it
      in_data <= v_ADD_TERM1;
		in_write <= 1;
		in_clk <= '1'

      wait for 60 ns;
		
		in_clk <= '0'
		in_write <= '0';
      write(v_OLINE, out_data, right, c_WIDTH);
      writeline(file_RESULTS, v_OLINE);
    end loop;
 
    file_close(file_VECTORS);
    file_close(file_RESULTS);
     			
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END Kernel_arch;
