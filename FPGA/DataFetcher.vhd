--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity DataFetcher is
	port
	(
		in_clk			: in 	std_logic;
		in_reset		: in 	std_logic;
		in_rx			: in 	std_logic;
		out_tx			: out 	std_logic
	);

end DataFetcher;

architecture data_fetcher of DataFetcher is

	signal s_read 			: std_logic := '0';
	signal s_write 			: std_logic := '0';
	signal s_interrupt 		: std_logic;
	signal s_readdata 		: std_logic_vector(7 downto 0);
	signal s_writedata 		: std_logic_vector(7 downto 0);
	signal s_byte_enable 	: std_logic_vector(3 downto 0) := (others => '0');

	component UART is
		port (
			rs232_0_address    : in  std_logic                     := 'X';             -- address
			rs232_0_chipselect : in  std_logic                     := 'X';             -- chipselect
			rs232_0_byteenable : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			rs232_0_read       : in  std_logic                     := 'X';             -- read
			rs232_0_write      : in  std_logic                     := 'X';             -- write
			rs232_0_writedata  : in  std_logic_vector(7 downto 0) := (others => 'X'); -- writedata
			rs232_0_readdata   : out std_logic_vector(7 downto 0);                    -- readdata
			rs232_0_irq        : out std_logic;                                        -- irq
			rs232_0_UART_RXD   : in  std_logic                     := 'X';             -- RXD
			rs232_0_UART_TXD   : out std_logic;                                        -- TXD
			clk_clk            : in  std_logic                     := 'X';             -- clk
			reset_reset_n      : in  std_logic                     := 'X'              -- reset_n
		);
	end component UART;

begin

	u0 : component UART
	port map (
--		rs232_0_address    => CONNECTED_TO_rs232_0_address,    -- rs232_0_avalon_rs232_slave.address
--		rs232_0_chipselect => CONNECTED_TO_rs232_0_chipselect, --                           .chipselect
--		rs232_0_byteenable => s_byte_enable, --                           .byteenable
		rs232_0_read       => s_read,       --                           .read
		rs232_0_write      => s_write,      --                           .write
		rs232_0_writedata  => s_writedata,  --                           .writedata
		rs232_0_readdata   => s_readdata,   --                           .readdata
		rs232_0_irq        => s_interrupt,        --          rs232_0_interrupt.irq
		rs232_0_UART_RXD   => in_rx,   -- rs232_0_external_interface.RXD
		rs232_0_UART_TXD   => out_tx,   --                           .TXD
		clk_clk            => in_clk,            --                        clk.clk
		reset_reset_n      => in_reset       --                      reset.reset_n
	);

end data_fetcher;
