--Library and package declaration
library ieee;                                               
use ieee.std_logic_1164.all;  
use ieee.numeric_std.all;
use work.CustomTypes.all;

entity DataFetcher is
	port
	(
		in_clk			: in std_logic
	);

end DataFetcher;

architecture data_fetcher of DataFetcher is

	component UART is
		port (
			rs232_0_address    : in  std_logic                     := 'X';             -- address
			rs232_0_chipselect : in  std_logic                     := 'X';             -- chipselect
			rs232_0_byteenable : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			rs232_0_read       : in  std_logic                     := 'X';             -- read
			rs232_0_write      : in  std_logic                     := 'X';             -- write
			rs232_0_writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			rs232_0_readdata   : out std_logic_vector(31 downto 0);                    -- readdata
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
		rs232_0_address    => CONNECTED_TO_rs232_0_address,    -- rs232_0_avalon_rs232_slave.address
		rs232_0_chipselect => CONNECTED_TO_rs232_0_chipselect, --                           .chipselect
		rs232_0_byteenable => CONNECTED_TO_rs232_0_byteenable, --                           .byteenable
		rs232_0_read       => CONNECTED_TO_rs232_0_read,       --                           .read
		rs232_0_write      => CONNECTED_TO_rs232_0_write,      --                           .write
		rs232_0_writedata  => CONNECTED_TO_rs232_0_writedata,  --                           .writedata
		rs232_0_readdata   => CONNECTED_TO_rs232_0_readdata,   --                           .readdata
		rs232_0_irq        => CONNECTED_TO_rs232_0_irq,        --          rs232_0_interrupt.irq
		rs232_0_UART_RXD   => CONNECTED_TO_rs232_0_UART_RXD,   -- rs232_0_external_interface.RXD
		rs232_0_UART_TXD   => CONNECTED_TO_rs232_0_UART_TXD,   --                           .TXD
		clk_clk            => CONNECTED_TO_clk_clk,            --                        clk.clk
		reset_reset_n      => CONNECTED_TO_reset_reset_n       --                      reset.reset_n
	);

end data_fetcher;
