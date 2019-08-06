
LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity embedded_pico is
port (clk:in std_logic;
		 txd: out std_logic
		 );

end embedded_pico;


architecture behavioral of embedded_pico is


  component kcpsm6 
    generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                    interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
             scratch_pad_memory_size : integer := 64);
    port (                   address : out std_logic_vector(11 downto 0);
                         instruction : in std_logic_vector(17 downto 0);
                         bram_enable : out std_logic;
                             in_port : in std_logic_vector(7 downto 0);
                            out_port : out std_logic_vector(7 downto 0);
                             port_id : out std_logic_vector(7 downto 0);
                        write_strobe : out std_logic;
                      k_write_strobe : out std_logic;
                         read_strobe : out std_logic;
                           interrupt : in std_logic;
                       interrupt_ack : out std_logic;
                               sleep : in std_logic;
                               reset : in std_logic;
                                 clk : in std_logic);
  end component;



  component test                          
    generic(             C_FAMILY : string := "S6"; 
                C_RAM_SIZE_KWORDS : integer := 1;
             C_JTAG_LOADER_ENABLE : integer := 0);
    Port (      address : in std_logic_vector(11 downto 0);
            instruction : out std_logic_vector(17 downto 0);
                 enable : in std_logic;
                    rdl : out std_logic;                    
                    clk : in std_logic);
  end component;

component uart_tx6 
  Port (             data_in : in std_logic_vector(7 downto 0);
              en_16_x_baud : in std_logic;
                serial_out : out std_logic;
              buffer_write : in std_logic;
       buffer_data_present : out std_logic;
          buffer_half_full : out std_logic;
               buffer_full : out std_logic;
              buffer_reset : in std_logic;
                       clk : in std_logic);
end component;


signal         address : std_logic_vector(11 downto 0);
signal     instruction : std_logic_vector(17 downto 0);
signal     bram_enable : std_logic;
signal  k_write_strobe : std_logic;
signal    kcpsm6_sleep : std_logic;
signal    kcpsm6_reset : std_logic;
signal en_16_x_baud: std_logic;
signal interrupt_ack: std_logic;
signal interrupt: std_logic;
signal pb_in_data: std_logic_vector (7 downto 0);
signal pb_out_data: std_logic_vector (7 downto 0);
signal uart_write: std_logic;
SIGNAL baud_count: integer range 0 to 162 := 0;
--


begin


  processor: kcpsm6
    generic map (                 hwbuild => X"00", 
                         interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address,
               instruction => instruction,
               bram_enable => bram_enable,
                   port_id => open,--
              write_strobe => uart_write,
            k_write_strobe => k_write_strobe,
                  out_port => pb_out_data,
               read_strobe  => open,
                   in_port=> pb_in_data,
                 interrupt => '0',
             interrupt_ack => open,
                     sleep => kcpsm6_sleep,
                     reset => '0',--
                       clk => clk);
 


  kcpsm6_sleep <= '0';


  program_rom: test                   --Name to match your PSM file
    generic map(             C_FAMILY => "7S",   --Family 'S6', 'V6' or '7S'
                    C_RAM_SIZE_KWORDS => 2,      --Program size '1', '2' or '4'
                 C_JTAG_LOADER_ENABLE => 1)      --Include JTAG Loader when set to '1' 
    port map(      address => address,      
               instruction => instruction,
                    enable => bram_enable,
                       rdl => kcpsm6_reset,
                       clk => clk);


tx_uart: uart_tx6
  Port map(             data_in =>pb_out_data,
            en_16_x_baud =>en_16_x_baud,
              serial_out =>txd,
            buffer_write =>uart_write,
     buffer_data_present =>open,
        buffer_half_full =>pb_in_data(0),
             buffer_full =>pb_in_data(7),
            buffer_reset =>kcpsm6_reset,
                     clk =>clk);
                     

-- UART Baudrate timer
baud_timer: PROCESS (clk)
		BEGIN
			IF clk'event and clk= '1' THEN
				IF baud_count= 162 THEN
					baud_count<= 0;
					en_16_x_baud <= '1';
				ELSE
					baud_count<= baud_count+ 1;
					en_16_x_baud <= '0';
				END IF;
			END IF;
	END PROCESS baud_timer;



end behavioral;




