---------------------------------------------------------------------------------
-- Copyright 2019 Agnese Salutari.
-- Licensed under the Apache License, Version 2.0 (the "License"); 
-- you may not use this file except in compliance with the License. 
-- You may obtain a copy of the License at

-- http://www.apache.org/licenses/LICENSE-2.0

-- Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on 
-- an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
-- See the License for the specific language governing permissions and limitations under the License
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Agnese Salutari
-- 
-- Create Date: 03.08.2019 16:17:43
-- Design Name: 
-- Module Name: hl_counterTestbench - Behavioral
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

entity hl_counterTestbench is
--  Port ( );
end hl_counterTestbench;

architecture Behavioral of hl_counterTestbench is
    -- Component Declaration for the Unit Under Test (UUT):
    component hl_counter
        PORT(
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            count_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;
    -- Input Signals:
    signal SIG_CLK : STD_LOGIC := '0';
    signal SIG_RESET : STD_LOGIC := '0';
    -- Output Signals:
    signal SIG_COUNT_OUT : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    -- Reset Time:
    constant resetTime : time := 100 ns;
    -- Delta Time:
    constant period : time := 50 ns;
begin
    -- Under Unit Test (UUT) Instantiation:
    uut : hl_counter PORT MAP(
        clk => SIG_CLK,
        reset => SIG_RESET,
        count_out => SIG_COUNT_OUT
    );
    -- Stimulus Processes:
    stimCLK : process
    begin
        wait for resetTime;
        SIG_CLK <= '0';
        wait for period;
        SIG_CLK <= '1';
        wait for period;
    end process;
    stimRESET : process
    begin
        wait for resetTime;
        SIG_RESET <= '1';
        wait for period;
        SIG_RESET <= '0';
        wait for period * 16;
        SIG_RESET <= '1';
        wait for period;
        SIG_RESET <= '0';
        wait for period * 64;
    end process;
end Behavioral;
