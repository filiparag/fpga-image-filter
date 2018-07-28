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
-- Generated on "07/28/2018 19:34:23"
                                                            
-- Vhdl Test Bench template for design  :  DataFetcher
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY DataFetcher_vhd_tst IS
END DataFetcher_vhd_tst;
ARCHITECTURE DataFetcher_arch OF DataFetcher_vhd_tst IS
-- constants                                           
constant clk_period			: time := 10 ns;      
-- signals                                                   
SIGNAL in_clk : STD_LOGIC;
SIGNAL in_reset : STD_LOGIC;
SIGNAL in_rx : STD_LOGIC;
SIGNAL out_tx : STD_LOGIC;
COMPONENT DataFetcher
	PORT (
	in_clk : IN STD_LOGIC;
	in_reset : IN STD_LOGIC;
	in_rx : IN STD_LOGIC;
	out_tx : BUFFER STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : DataFetcher
	PORT MAP (
-- list connections between master ports and signals
	in_clk => in_clk,
	in_reset => in_reset,
	in_rx => in_rx,
	out_tx => out_tx
	);

	clk_process : process                                                                               
	begin      
		in_clk <= '1';
		wait for clk_period/2; 

		in_clk <= '0';
		wait for clk_period/2; 
													
	end process clk_process;

END DataFetcher_arch;
