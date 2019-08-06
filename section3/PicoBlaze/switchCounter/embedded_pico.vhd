
LIBRARY IEEE; 
USE IEEE.STD_LOGIC_1164.ALL; 


entity embedded_pico is
port (switches : in std_logic_vector(3 downto 0); 
		 LEDS     : out std_logic_vector(3 downto 0); 
		 clk      : in std_logic
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



  component switchCounter                         
    generic(             C_FAMILY : string := "S6"; 
                C_RAM_SIZE_KWORDS : integer := 1;
             C_JTAG_LOADER_ENABLE : integer := 0);
    Port (      address : in std_logic_vector(11 downto 0);
            instruction : out std_logic_vector(17 downto 0);
                 enable : in std_logic;
                    rdl : out std_logic;                    
                    clk : in std_logic);
  end component;


signal         address : std_logic_vector(11 downto 0);
signal     instruction : std_logic_vector(17 downto 0);
signal     bram_enable : std_logic;
signal         in_port : std_logic_vector(7 downto 0);
signal        out_port : std_logic_vector(7 downto 0);
signal         port_id : std_logic_vector(7 downto 0);
signal    write_strobe : std_logic;
signal  k_write_strobe : std_logic;
signal     read_strobe : std_logic;
signal       interrupt : std_logic;
signal   interrupt_ack : std_logic;
signal    kcpsm6_sleep : std_logic;
signal    kcpsm6_reset : std_logic;
signal in_port_sig: std_logic_vector (3 downto 0);
signal out_port_sig: std_logic_vector (3 downto 0);
--


begin


  processor: kcpsm6
    generic map (                 hwbuild => X"00", 
                         interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address,
               instruction => instruction,
               bram_enable => bram_enable,
                   port_id => port_id,
              write_strobe => write_strobe,
            k_write_strobe => k_write_strobe,
                  out_port (3 downto 0) => out_port_sig,
				  out_port (7 downto 4) => OPEN,
               read_strobe  => read_strobe,
                   in_port(3 downto 0) => in_port_sig,
				   in_port (7 downto 4)=>"0000",
                 interrupt => interrupt,
             interrupt_ack => interrupt_ack,
                     sleep => kcpsm6_sleep,
                     reset => kcpsm6_reset,
                       clk => clk);


  kcpsm6_sleep <= '0';
  interrupt <= interrupt_ack;





  program_rom: switchCounter                  --Name to match your PSM file
    generic map(             C_FAMILY => "7S",   --Family 'S6', 'V6' or '7S'
                    C_RAM_SIZE_KWORDS => 2,      --Program size '1', '2' or '4'
                 C_JTAG_LOADER_ENABLE => 1)      --Include JTAG Loader when set to '1' 
    port map(      address => address,      
               instruction => instruction,
                    enable => bram_enable,
                       rdl => kcpsm6_reset,
                       clk => clk);



process(clk) 
begin 
if clk'event and clk='1' then 
		if (read_strobe='1' and port_id="00000000") then
			in_port_sig <= switches;  
		end if; 
	end if; 
end process;  
   

process(clk) 
begin 
if clk'event and clk='1' then 
		if (write_strobe='1' and port_id="00000001") then  
			LEDs <= out_port_sig; 
		end if; 
	end if; 
end process;  






end behavioral;



