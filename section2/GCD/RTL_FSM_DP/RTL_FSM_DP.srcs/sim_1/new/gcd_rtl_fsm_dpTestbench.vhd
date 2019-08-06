----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.08.2019 19:34:08
-- Design Name: 
-- Module Name: gcd_rtl_fsm_dpTestbench - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gcd_rtl_fsm_dpTestbench is
--  Port ( );
end gcd_rtl_fsm_dpTestbench;

architecture Behavioral of gcd_rtl_fsm_dpTestbench is
    -- Component Declaration for the Unit Under Test (UUT):
    component gcd_fsm_dp 
    PORT(
        rst : in STD_LOGIC;
        clk : in STD_LOGIC;
        go_i : in STD_LOGIC;
        x_i : in STD_LOGIC_VECTOR (3 downto 0);
        y_i : in STD_LOGIC_VECTOR (3 downto 0);
        d_o : out STD_LOGIC_VECTOR (3 downto 0)
    );
    end component;
    -- Input Signals:
    signal SIG_RST : STD_LOGIC := '0';
    signal SIG_CLK : STD_LOGIC := '0';
    signal SIG_GO_I : STD_LOGIC := '0';
    signal SIG_X_I : STD_LOGIC_VECTOR (3 downto 0) := "0110";
    signal SIG_Y_I : STD_LOGIC_VECTOR (3 downto 0) := "0010";
    -- Output Signals:
    signal SIG_D_O : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    -- Reset Time:
    constant resetTime : time := 100 ns;
    -- Delta Time:
    constant period : time := 50 ns;
begin
    -- Unit Under Test (UUT) Instantiation:
    uut : gcd_fsm_dp PORT MAP(
        rst => SIG_RST,
        clk => SIG_CLK,
        go_i => SIG_GO_I,
        x_i => SIG_X_I,
        y_i => SIG_Y_I,
        d_o => SIG_D_O
    );
    -- Stimulus Processes:
    stimGoI : process
    begin
        wait for resetTime;
        SIG_GO_I <= '0';
        wait for period;
        SIG_GO_I <= '1';
        wait for period * 10;
    end process;
    stimClk : process
    begin
        wait for resetTime;
        SIG_CLK <= '0';
        wait for period;
        SIG_CLK <= '1';
        wait for period;
    end process;
    stimRst : process
    begin
        wait for resetTime;
        SIG_RST <= '0';
        wait for period * 10;
        SIG_RST <= '1';
        wait for period;
    end process;
end Behavioral;
