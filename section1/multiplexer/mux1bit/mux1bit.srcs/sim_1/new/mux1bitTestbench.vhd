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
-- Engineer: 
-- 
-- Create Date: 02.08.2019 15:45:30
-- Design Name: 
-- Module Name: mux1bitTestbench - Behavioral
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

entity mux1bitTestbench is
--  Port ( );
end mux1bitTestbench;

architecture Behavioral of mux1bitTestbench is
    -- Component Declaration for the Unit Under Test (UUT):
    COMPONENT mux1bit
    PORT(
        A : IN std_logic;
        B : IN std_logic;
        SEL: IN std_logic;
        Y: OUT std_logic
    );
    END COMPONENT;
    -- Input Signals:
    signal SIG_A : std_logic := '0';
    signal SIG_B : std_logic := '1';
    signal SIG_SEL : std_logic := '0';
    -- Output Signals:
    signal SIG_Y : std_logic;
    -- Delta Time:
    constant period : time := 50 ns;
begin
    -- Unit Under Test (UUT) Instantiation:
    uut: mux1bit PORT MAP (
          A => SIG_A,
          B => SIG_B,
          SEL => SIG_SEL,
          Y => SIG_Y
        );        
   -- Stimulus processes:
   stimSEL: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- Stimulus:
      SIG_SEL <= '0';
      wait for period * 2;
      SIG_SEL <= '1';
      wait for period * 2;
      SIG_SEL <= '0';
      wait for period * 2;
      SIG_SEL <= '1';
      wait for period * 2;
   end process;
   stimA: process
   begin
    -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- Stimulus:
      SIG_A <= '0';
      wait for period * 2;
      SIG_A <= '1';
      wait for period * 4;
      SIG_A <= '0';
      wait for period * 2;
   end process;
   stimB: process
   begin
    -- hold reset state for 100 ns.
      wait for 100 ns;	
      -- Stimulus:
      SIG_B <= '0';
      wait for period * 4;
      SIG_B <= '1';
      wait for period * 4;
   end process;

end Behavioral;
