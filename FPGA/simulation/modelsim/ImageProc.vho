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

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 18.0.0 Build 614 04/24/2018 SJ Lite Edition"

-- DATE "07/25/2018 16:53:21"

-- 
-- Device: Altera 5CGXFC5C6F27C7 Package FBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	DataProxy IS
    PORT (
	in_clk : IN std_logic;
	in_ready : IN std_logic;
	in_data : IN std_logic_vector(7 DOWNTO 0);
	out_image_write : BUFFER std_logic;
	out_kernel_write : BUFFER std_logic;
	out_image : BUFFER std_logic_vector(7 DOWNTO 0);
	out_kernel : BUFFER std_logic_vector(7 DOWNTO 0)
	);
END DataProxy;

-- Design Ports Information
-- out_image_write	=>  Location: PIN_V24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel_write	=>  Location: PIN_Y24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[0]	=>  Location: PIN_T22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[1]	=>  Location: PIN_T24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[2]	=>  Location: PIN_R25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[3]	=>  Location: PIN_AA26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[4]	=>  Location: PIN_AD25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[5]	=>  Location: PIN_AB25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[6]	=>  Location: PIN_P23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_image[7]	=>  Location: PIN_V23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[0]	=>  Location: PIN_R20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[1]	=>  Location: PIN_V25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[2]	=>  Location: PIN_R23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[3]	=>  Location: PIN_AA24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[4]	=>  Location: PIN_R24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[5]	=>  Location: PIN_AC25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[6]	=>  Location: PIN_T23,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- out_kernel[7]	=>  Location: PIN_T21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_clk	=>  Location: PIN_P11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_ready	=>  Location: PIN_U24,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[0]	=>  Location: PIN_Y26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[1]	=>  Location: PIN_R26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[2]	=>  Location: PIN_AB26,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[3]	=>  Location: PIN_P21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[4]	=>  Location: PIN_P22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[5]	=>  Location: PIN_Y25,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[6]	=>  Location: PIN_P20,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_data[7]	=>  Location: PIN_T26,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF DataProxy IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_in_clk : std_logic;
SIGNAL ww_in_ready : std_logic;
SIGNAL ww_in_data : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_image_write : std_logic;
SIGNAL ww_out_kernel_write : std_logic;
SIGNAL ww_out_image : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_out_kernel : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \in_clk~input_o\ : std_logic;
SIGNAL \in_clk~inputCLKENA0_outclk\ : std_logic;
SIGNAL \Add0~13_sumout\ : std_logic;
SIGNAL \Add0~6\ : std_logic;
SIGNAL \Add0~9_sumout\ : std_logic;
SIGNAL \in_ready~input_o\ : std_logic;
SIGNAL \out_kernel[0]~0_combout\ : std_logic;
SIGNAL \Add0~14\ : std_logic;
SIGNAL \Add0~17_sumout\ : std_logic;
SIGNAL \Add0~18\ : std_logic;
SIGNAL \Add0~21_sumout\ : std_logic;
SIGNAL \Add0~22\ : std_logic;
SIGNAL \Add0~25_sumout\ : std_logic;
SIGNAL \Add0~26\ : std_logic;
SIGNAL \Add0~1_sumout\ : std_logic;
SIGNAL \Add0~2\ : std_logic;
SIGNAL \Add0~5_sumout\ : std_logic;
SIGNAL \pixel_count[0]~0_combout\ : std_logic;
SIGNAL \LessThan0~0_combout\ : std_logic;
SIGNAL \LessThan0~1_combout\ : std_logic;
SIGNAL \out_image_write~0_combout\ : std_logic;
SIGNAL \out_image_write~reg0_q\ : std_logic;
SIGNAL \out_kernel_write~reg0_q\ : std_logic;
SIGNAL \in_data[0]~input_o\ : std_logic;
SIGNAL \out_image[0]~reg0feeder_combout\ : std_logic;
SIGNAL \out_image[0]~0_combout\ : std_logic;
SIGNAL \out_image[0]~reg0_q\ : std_logic;
SIGNAL \in_data[1]~input_o\ : std_logic;
SIGNAL \out_image[1]~reg0feeder_combout\ : std_logic;
SIGNAL \out_image[1]~reg0_q\ : std_logic;
SIGNAL \in_data[2]~input_o\ : std_logic;
SIGNAL \out_image[2]~reg0_q\ : std_logic;
SIGNAL \in_data[3]~input_o\ : std_logic;
SIGNAL \out_image[3]~reg0_q\ : std_logic;
SIGNAL \in_data[4]~input_o\ : std_logic;
SIGNAL \out_image[4]~reg0_q\ : std_logic;
SIGNAL \in_data[5]~input_o\ : std_logic;
SIGNAL \out_image[5]~reg0feeder_combout\ : std_logic;
SIGNAL \out_image[5]~reg0_q\ : std_logic;
SIGNAL \in_data[6]~input_o\ : std_logic;
SIGNAL \out_image[6]~reg0_q\ : std_logic;
SIGNAL \in_data[7]~input_o\ : std_logic;
SIGNAL \out_image[7]~reg0feeder_combout\ : std_logic;
SIGNAL \out_image[7]~reg0_q\ : std_logic;
SIGNAL \out_kernel[0]~reg0feeder_combout\ : std_logic;
SIGNAL \out_kernel[0]~reg0_q\ : std_logic;
SIGNAL \out_kernel[1]~reg0_q\ : std_logic;
SIGNAL \out_kernel[2]~reg0_q\ : std_logic;
SIGNAL \out_kernel[3]~reg0feeder_combout\ : std_logic;
SIGNAL \out_kernel[3]~reg0_q\ : std_logic;
SIGNAL \out_kernel[4]~reg0_q\ : std_logic;
SIGNAL \out_kernel[5]~reg0_q\ : std_logic;
SIGNAL \out_kernel[6]~reg0feeder_combout\ : std_logic;
SIGNAL \out_kernel[6]~reg0_q\ : std_logic;
SIGNAL \out_kernel[7]~reg0_q\ : std_logic;
SIGNAL pixel_count : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_in_data[7]~input_o\ : std_logic;
SIGNAL \ALT_INV_in_data[6]~input_o\ : std_logic;
SIGNAL \ALT_INV_in_data[5]~input_o\ : std_logic;
SIGNAL \ALT_INV_in_data[3]~input_o\ : std_logic;
SIGNAL \ALT_INV_in_data[1]~input_o\ : std_logic;
SIGNAL \ALT_INV_in_data[0]~input_o\ : std_logic;
SIGNAL \ALT_INV_in_ready~input_o\ : std_logic;
SIGNAL \ALT_INV_LessThan0~1_combout\ : std_logic;
SIGNAL \ALT_INV_LessThan0~0_combout\ : std_logic;
SIGNAL ALT_INV_pixel_count : std_logic_vector(7 DOWNTO 0);

BEGIN

ww_in_clk <= in_clk;
ww_in_ready <= in_ready;
ww_in_data <= in_data;
out_image_write <= ww_out_image_write;
out_kernel_write <= ww_out_kernel_write;
out_image <= ww_out_image;
out_kernel <= ww_out_kernel;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_in_data[7]~input_o\ <= NOT \in_data[7]~input_o\;
\ALT_INV_in_data[6]~input_o\ <= NOT \in_data[6]~input_o\;
\ALT_INV_in_data[5]~input_o\ <= NOT \in_data[5]~input_o\;
\ALT_INV_in_data[3]~input_o\ <= NOT \in_data[3]~input_o\;
\ALT_INV_in_data[1]~input_o\ <= NOT \in_data[1]~input_o\;
\ALT_INV_in_data[0]~input_o\ <= NOT \in_data[0]~input_o\;
\ALT_INV_in_ready~input_o\ <= NOT \in_ready~input_o\;
\ALT_INV_LessThan0~1_combout\ <= NOT \LessThan0~1_combout\;
\ALT_INV_LessThan0~0_combout\ <= NOT \LessThan0~0_combout\;
ALT_INV_pixel_count(4) <= NOT pixel_count(4);
ALT_INV_pixel_count(3) <= NOT pixel_count(3);
ALT_INV_pixel_count(2) <= NOT pixel_count(2);
ALT_INV_pixel_count(1) <= NOT pixel_count(1);
ALT_INV_pixel_count(0) <= NOT pixel_count(0);
ALT_INV_pixel_count(7) <= NOT pixel_count(7);
ALT_INV_pixel_count(6) <= NOT pixel_count(6);
ALT_INV_pixel_count(5) <= NOT pixel_count(5);

-- Location: IOOBUF_X68_Y14_N96
\out_image_write~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image_write~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image_write);

-- Location: IOOBUF_X68_Y13_N56
\out_kernel_write~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel_write~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel_write);

-- Location: IOOBUF_X68_Y14_N62
\out_image[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(0));

-- Location: IOOBUF_X68_Y16_N22
\out_image[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(1));

-- Location: IOOBUF_X68_Y19_N22
\out_image[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(2));

-- Location: IOOBUF_X68_Y22_N96
\out_image[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(3));

-- Location: IOOBUF_X68_Y17_N39
\out_image[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[4]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(4));

-- Location: IOOBUF_X68_Y16_N56
\out_image[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[5]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(5));

-- Location: IOOBUF_X68_Y17_N22
\out_image[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[6]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(6));

-- Location: IOOBUF_X68_Y14_N79
\out_image[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_image[7]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_image(7));

-- Location: IOOBUF_X68_Y22_N45
\out_kernel[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[0]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(0));

-- Location: IOOBUF_X68_Y19_N56
\out_kernel[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[1]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(1));

-- Location: IOOBUF_X68_Y17_N5
\out_kernel[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[2]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(2));

-- Location: IOOBUF_X68_Y16_N39
\out_kernel[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[3]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(3));

-- Location: IOOBUF_X68_Y19_N5
\out_kernel[4]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[4]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(4));

-- Location: IOOBUF_X68_Y17_N56
\out_kernel[5]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[5]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(5));

-- Location: IOOBUF_X68_Y16_N5
\out_kernel[6]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[6]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(6));

-- Location: IOOBUF_X68_Y14_N45
\out_kernel[7]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \out_kernel[7]~reg0_q\,
	devoe => ww_devoe,
	o => ww_out_kernel(7));

-- Location: IOIBUF_X21_Y0_N1
\in_clk~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_clk,
	o => \in_clk~input_o\);

-- Location: CLKCTRL_G6
\in_clk~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \in_clk~input_o\,
	outclk => \in_clk~inputCLKENA0_outclk\);

-- Location: LABCELL_X65_Y20_N30
\Add0~13\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~13_sumout\ = SUM(( pixel_count(1) ) + ( pixel_count(0) ) + ( !VCC ))
-- \Add0~14\ = CARRY(( pixel_count(1) ) + ( pixel_count(0) ) + ( !VCC ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111100001111000000000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => ALT_INV_pixel_count(0),
	datad => ALT_INV_pixel_count(1),
	cin => GND,
	sumout => \Add0~13_sumout\,
	cout => \Add0~14\);

-- Location: LABCELL_X65_Y20_N45
\Add0~5\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~5_sumout\ = SUM(( pixel_count(6) ) + ( GND ) + ( \Add0~2\ ))
-- \Add0~6\ = CARRY(( pixel_count(6) ) + ( GND ) + ( \Add0~2\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_pixel_count(6),
	cin => \Add0~2\,
	sumout => \Add0~5_sumout\,
	cout => \Add0~6\);

-- Location: LABCELL_X65_Y20_N48
\Add0~9\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~9_sumout\ = SUM(( pixel_count(7) ) + ( GND ) + ( \Add0~6\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_pixel_count(7),
	cin => \Add0~6\,
	sumout => \Add0~9_sumout\);

-- Location: FF_X65_Y20_N50
\pixel_count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \Add0~9_sumout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(7));

-- Location: IOIBUF_X68_Y19_N38
\in_ready~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_ready,
	o => \in_ready~input_o\);

-- Location: LABCELL_X65_Y20_N57
\out_kernel[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_kernel[0]~0_combout\ = ( \LessThan0~0_combout\ & ( \in_ready~input_o\ ) ) # ( !\LessThan0~0_combout\ & ( (\in_ready~input_o\ & ((!pixel_count(7)) # ((!pixel_count(5)) # (!pixel_count(6))))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001110000011110000111000001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_pixel_count(7),
	datab => ALT_INV_pixel_count(5),
	datac => \ALT_INV_in_ready~input_o\,
	datad => ALT_INV_pixel_count(6),
	dataf => \ALT_INV_LessThan0~0_combout\,
	combout => \out_kernel[0]~0_combout\);

-- Location: FF_X65_Y20_N32
\pixel_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \Add0~13_sumout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(1));

-- Location: LABCELL_X65_Y20_N33
\Add0~17\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~17_sumout\ = SUM(( pixel_count(2) ) + ( GND ) + ( \Add0~14\ ))
-- \Add0~18\ = CARRY(( pixel_count(2) ) + ( GND ) + ( \Add0~14\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_pixel_count(2),
	cin => \Add0~14\,
	sumout => \Add0~17_sumout\,
	cout => \Add0~18\);

-- Location: FF_X65_Y20_N35
\pixel_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \Add0~17_sumout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(2));

-- Location: LABCELL_X65_Y20_N36
\Add0~21\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~21_sumout\ = SUM(( pixel_count(3) ) + ( GND ) + ( \Add0~18\ ))
-- \Add0~22\ = CARRY(( pixel_count(3) ) + ( GND ) + ( \Add0~18\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_pixel_count(3),
	cin => \Add0~18\,
	sumout => \Add0~21_sumout\,
	cout => \Add0~22\);

-- Location: FF_X65_Y20_N38
\pixel_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \Add0~21_sumout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(3));

-- Location: LABCELL_X65_Y20_N39
\Add0~25\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~25_sumout\ = SUM(( pixel_count(4) ) + ( GND ) + ( \Add0~22\ ))
-- \Add0~26\ = CARRY(( pixel_count(4) ) + ( GND ) + ( \Add0~22\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_pixel_count(4),
	cin => \Add0~22\,
	sumout => \Add0~25_sumout\,
	cout => \Add0~26\);

-- Location: FF_X65_Y20_N40
\pixel_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \Add0~25_sumout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(4));

-- Location: LABCELL_X65_Y20_N42
\Add0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \Add0~1_sumout\ = SUM(( pixel_count(5) ) + ( GND ) + ( \Add0~26\ ))
-- \Add0~2\ = CARRY(( pixel_count(5) ) + ( GND ) + ( \Add0~26\ ))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000111111111111111100000000000000000000000011111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datad => ALT_INV_pixel_count(5),
	cin => \Add0~26\,
	sumout => \Add0~1_sumout\,
	cout => \Add0~2\);

-- Location: FF_X65_Y20_N44
\pixel_count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \Add0~1_sumout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(5));

-- Location: FF_X65_Y20_N47
\pixel_count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \Add0~5_sumout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(6));

-- Location: LABCELL_X65_Y20_N0
\pixel_count[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \pixel_count[0]~0_combout\ = ( pixel_count(0) & ( pixel_count(5) & ( (!\in_ready~input_o\) # ((!\LessThan0~0_combout\ & (pixel_count(6) & pixel_count(7)))) ) ) ) # ( !pixel_count(0) & ( pixel_count(5) & ( (\in_ready~input_o\ & (((!pixel_count(6)) # 
-- (!pixel_count(7))) # (\LessThan0~0_combout\))) ) ) ) # ( pixel_count(0) & ( !pixel_count(5) & ( !\in_ready~input_o\ ) ) ) # ( !pixel_count(0) & ( !pixel_count(5) & ( \in_ready~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000011111111111111110000000000000000111111011111111100000010",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_LessThan0~0_combout\,
	datab => ALT_INV_pixel_count(6),
	datac => ALT_INV_pixel_count(7),
	datad => \ALT_INV_in_ready~input_o\,
	datae => ALT_INV_pixel_count(0),
	dataf => ALT_INV_pixel_count(5),
	combout => \pixel_count[0]~0_combout\);

-- Location: FF_X65_Y20_N2
\pixel_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \pixel_count[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pixel_count(0));

-- Location: LABCELL_X65_Y20_N18
\LessThan0~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~0_combout\ = ( !pixel_count(2) & ( (!pixel_count(0) & (!pixel_count(1) & (!pixel_count(3) & !pixel_count(4)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1000000000000000100000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_pixel_count(0),
	datab => ALT_INV_pixel_count(1),
	datac => ALT_INV_pixel_count(3),
	datad => ALT_INV_pixel_count(4),
	dataf => ALT_INV_pixel_count(2),
	combout => \LessThan0~0_combout\);

-- Location: LABCELL_X64_Y20_N48
\LessThan0~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \LessThan0~1_combout\ = ( pixel_count(6) & ( ((!pixel_count(5)) # (!pixel_count(7))) # (\LessThan0~0_combout\) ) ) # ( !pixel_count(6) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111111111111111100111111111111110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_LessThan0~0_combout\,
	datac => ALT_INV_pixel_count(5),
	datad => ALT_INV_pixel_count(7),
	dataf => ALT_INV_pixel_count(6),
	combout => \LessThan0~1_combout\);

-- Location: LABCELL_X64_Y20_N51
\out_image_write~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_image_write~0_combout\ = ( !\LessThan0~1_combout\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1111111111111111111111111111111100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_LessThan0~1_combout\,
	combout => \out_image_write~0_combout\);

-- Location: FF_X64_Y20_N52
\out_image_write~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_image_write~0_combout\,
	ena => \in_ready~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image_write~reg0_q\);

-- Location: FF_X64_Y20_N49
\out_kernel_write~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \LessThan0~1_combout\,
	ena => \in_ready~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel_write~reg0_q\);

-- Location: IOIBUF_X68_Y24_N55
\in_data[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(0),
	o => \in_data[0]~input_o\);

-- Location: LABCELL_X65_Y20_N24
\out_image[0]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_image[0]~reg0feeder_combout\ = ( \in_data[0]~input_o\ )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000011111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataf => \ALT_INV_in_data[0]~input_o\,
	combout => \out_image[0]~reg0feeder_combout\);

-- Location: LABCELL_X65_Y20_N54
\out_image[0]~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_image[0]~0_combout\ = ( !\LessThan0~0_combout\ & ( (pixel_count(7) & (pixel_count(5) & (\in_ready~input_o\ & pixel_count(6)))) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000001000000000000000100000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => ALT_INV_pixel_count(7),
	datab => ALT_INV_pixel_count(5),
	datac => \ALT_INV_in_ready~input_o\,
	datad => ALT_INV_pixel_count(6),
	dataf => \ALT_INV_LessThan0~0_combout\,
	combout => \out_image[0]~0_combout\);

-- Location: FF_X65_Y20_N25
\out_image[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_image[0]~reg0feeder_combout\,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[0]~reg0_q\);

-- Location: IOIBUF_X68_Y24_N21
\in_data[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(1),
	o => \in_data[1]~input_o\);

-- Location: LABCELL_X65_Y20_N27
\out_image[1]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_image[1]~reg0feeder_combout\ = \in_data[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010101010101010101010101010101010101",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_in_data[1]~input_o\,
	combout => \out_image[1]~reg0feeder_combout\);

-- Location: FF_X65_Y20_N28
\out_image[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_image[1]~reg0feeder_combout\,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[1]~reg0_q\);

-- Location: IOIBUF_X68_Y22_N78
\in_data[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(2),
	o => \in_data[2]~input_o\);

-- Location: FF_X65_Y20_N17
\out_image[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[2]~input_o\,
	sload => VCC,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[2]~reg0_q\);

-- Location: IOIBUF_X68_Y26_N4
\in_data[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(3),
	o => \in_data[3]~input_o\);

-- Location: FF_X65_Y20_N14
\out_image[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[3]~input_o\,
	sload => VCC,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[3]~reg0_q\);

-- Location: IOIBUF_X68_Y26_N21
\in_data[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(4),
	o => \in_data[4]~input_o\);

-- Location: FF_X65_Y20_N29
\out_image[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[4]~input_o\,
	sload => VCC,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[4]~reg0_q\);

-- Location: IOIBUF_X68_Y24_N38
\in_data[5]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(5),
	o => \in_data[5]~input_o\);

-- Location: LABCELL_X65_Y20_N15
\out_image[5]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_image[5]~reg0feeder_combout\ = \in_data[5]~input_o\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_in_data[5]~input_o\,
	combout => \out_image[5]~reg0feeder_combout\);

-- Location: FF_X65_Y20_N16
\out_image[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_image[5]~reg0feeder_combout\,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[5]~reg0_q\);

-- Location: IOIBUF_X68_Y22_N61
\in_data[6]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(6),
	o => \in_data[6]~input_o\);

-- Location: FF_X65_Y20_N26
\out_image[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[6]~input_o\,
	sload => VCC,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[6]~reg0_q\);

-- Location: IOIBUF_X68_Y24_N4
\in_data[7]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_data(7),
	o => \in_data[7]~input_o\);

-- Location: LABCELL_X65_Y20_N12
\out_image[7]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_image[7]~reg0feeder_combout\ = \in_data[7]~input_o\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_in_data[7]~input_o\,
	combout => \out_image[7]~reg0feeder_combout\);

-- Location: FF_X65_Y20_N13
\out_image[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_image[7]~reg0feeder_combout\,
	ena => \out_image[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_image[7]~reg0_q\);

-- Location: LABCELL_X65_Y20_N9
\out_kernel[0]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_kernel[0]~reg0feeder_combout\ = \in_data[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_in_data[0]~input_o\,
	combout => \out_kernel[0]~reg0feeder_combout\);

-- Location: FF_X65_Y20_N11
\out_kernel[0]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_kernel[0]~reg0feeder_combout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[0]~reg0_q\);

-- Location: FF_X65_Y20_N10
\out_kernel[1]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[1]~input_o\,
	sload => VCC,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[1]~reg0_q\);

-- Location: FF_X65_Y20_N52
\out_kernel[2]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[2]~input_o\,
	sload => VCC,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[2]~reg0_q\);

-- Location: LABCELL_X65_Y20_N6
\out_kernel[3]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_kernel[3]~reg0feeder_combout\ = \in_data[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_in_data[3]~input_o\,
	combout => \out_kernel[3]~reg0feeder_combout\);

-- Location: FF_X65_Y20_N7
\out_kernel[3]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_kernel[3]~reg0feeder_combout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[3]~reg0_q\);

-- Location: FF_X65_Y20_N19
\out_kernel[4]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[4]~input_o\,
	sload => VCC,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[4]~reg0_q\);

-- Location: FF_X65_Y20_N23
\out_kernel[5]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[5]~input_o\,
	sload => VCC,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[5]~reg0_q\);

-- Location: LABCELL_X65_Y20_N21
\out_kernel[6]~reg0feeder\ : cyclonev_lcell_comb
-- Equation(s):
-- \out_kernel[6]~reg0feeder_combout\ = \in_data[6]~input_o\

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000111100001111000011110000111100001111000011110000111100001111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datac => \ALT_INV_in_data[6]~input_o\,
	combout => \out_kernel[6]~reg0feeder_combout\);

-- Location: FF_X65_Y20_N22
\out_kernel[6]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	d => \out_kernel[6]~reg0feeder_combout\,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[6]~reg0_q\);

-- Location: FF_X65_Y20_N8
\out_kernel[7]~reg0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \in_clk~inputCLKENA0_outclk\,
	asdata => \in_data[7]~input_o\,
	sload => VCC,
	ena => \out_kernel[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \out_kernel[7]~reg0_q\);

-- Location: LABCELL_X17_Y52_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


