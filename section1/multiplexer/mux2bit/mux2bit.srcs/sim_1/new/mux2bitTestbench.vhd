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
-- Create Date: 02.08.2019 16:56:11
-- Design Name: 
-- Module Name: mux2bitTestbench - Behavioral
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

entity mux2bitTestbench is
--  Port ( );
end mux2bitTestbench;

architecture Behavioral of mux2bitTestbench is
    -- Component Declaration for the Unit Under Test (UUT):
    COMPONENT mux2bit
    PORT(
        A : IN std_logic;
        B : IN std_logic;
        C : IN std_logic;
        D : IN std_logic;
        SEL : IN std_logic_vector (1 downto 0);
        Y : OUT std_logic
    );
    END COMPONENT;
    -- Input Signals:
    signal SIG_A : std_logic := '0';
    signal SIG_B : std_logic := '0';
    signal SIG_C : std_logic := '0';
    signal SIG_D : std_logic := '0';
    signal SIG_SEL : std_logic_vector (1 downto 0) := "00";
    -- Output Signals:
    signal SIG_Y : std_logic := '0';
    -- Delta Time:
    constant period : time := 50 ns; 
    -- Time for reset:
    constant reset_time : time := 100 ns;   
begin
    -- Unit Under Test (UUT) Instantiation:
    uut: mux2bit PORT MAP(
        A => SIG_A,
        B => SIG_B,
        C => SIG_C,
        D => SIG_D,
        SEL => SIG_SEL,
        Y => SIG_Y
    );
    -- Stimulus Processes:
    stimSEL : process
    begin
        wait for reset_time;
        SIG_SEL <= "11";
        wait for period * 2;
        SIG_SEL <= "10";
        wait for period * 2;
        SIG_SEL <= "01";
        wait for period * 2;
        SIG_SEL <= "00";
        wait for period * 2;
    end process;
    stimA : process
    begin
        wait for reset_time;
        SIG_A <= '1';
        wait for period * 5;
        SIG_A <= '0';
        wait for period * 3;
    end process;
    stimB : process
    begin
        wait for reset_time;
        SIG_B <= '0';
        wait for period * 4;
        SIG_B <= '1';
        wait for period * 4;
    end process;
    stimC : process
    begin
        wait for reset_time;
        SIG_C <= '1';
        wait for period * 2;
        SIG_C <= '0';
        wait for period * 2;
    end process;
    stimD : process
    begin
        wait for reset_time;
        SIG_D <= '0';
        wait for period * 2;
        SIG_D <= '1';
        wait for period * 2;
    end process;
end Behavioral;
