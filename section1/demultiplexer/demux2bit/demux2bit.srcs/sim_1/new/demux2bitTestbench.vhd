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
-- Create Date: 03.08.2019 12:11:17
-- Design Name: 
-- Module Name: demux2bitTestbench - Behavioral
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

entity demux2bitTestbench is
--  Port ( );
end demux2bitTestbench;

architecture Behavioral of demux2bitTestbench is
    -- Component Declaration for the Unit Under Test (UUT):
    component demux2bit
    PORT(
        Y : in STD_LOGIC;
        SEL : in STD_LOGIC_VECTOR (1 DOWNTO 0);
        A : out STD_LOGIC;
        B : out STD_LOGIC;
        C : out STD_LOGIC;
        D : out STD_LOGIC
    );
    end component;
    -- Input Signals:
    signal SIG_Y : STD_LOGIC := '0';
    signal SIG_SEL : STD_LOGIC_VECTOR (1 DOWNTO 0) := "00";
    -- Output Signals:
    signal SIG_A : STD_LOGIC := '0';
    signal SIG_B : STD_LOGIC := '0';
    signal SIG_C : STD_LOGIC := '0';
    signal SIG_D : STD_LOGIC := '0';
    -- Reset Time:
    constant reset_time : time := 100 ns;
    -- Delta Time:
    constant period : time := 50 ns;
begin
    -- Under Unit Test (UUT) Instantiation:
    uut: demux2bit PORT MAP(
        Y => SIG_Y,
        SEL => SIG_SEL,
        A => SIG_A,
        B => SIG_B,
        C => SIG_C,
        D => SIG_D
    );
    -- Stimulus Processes:
    stimY : process
    begin
        wait for reset_time;
        SIG_Y <= '1';
        wait for period * 4;
        SIG_Y <= '0';
        wait for period;
    end process;
    stimSEL : process
    begin
        wait for reset_time;
        SIG_SEL <= "11";
        wait for period * 4;
        SIG_SEL <= "10";
        wait for period * 4;
        SIG_SEL <= "01";
        wait for period * 4;
        SIG_SEL <= "00";
        wait for period * 4;
    end process;
end Behavioral;
