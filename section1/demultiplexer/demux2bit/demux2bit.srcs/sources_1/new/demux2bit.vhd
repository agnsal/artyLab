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
-- Create Date: 03.08.2019 11:29:50
-- Design Name: 
-- Module Name: demux2bit - Behavioral
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

entity demux2bit is
    Port ( Y : in STD_LOGIC;
           SEL : in STD_LOGIC_VECTOR (1 DOWNTO 0);
           A : out STD_LOGIC;
           B : out STD_LOGIC;
           C : out STD_LOGIC;
           D : out STD_LOGIC);
end demux2bit;

architecture Behavioral of demux2bit is

begin
    selection : process(SEL, Y) is
    begin
        if (SEL = "00") then
            A <= Y;
            B <= '0';
            C <= '0';
            D <= '0';
        elsif (SEL = "01") then
            A <= '0';
            B <= Y;
            C <= '0';
            D <= '0';
        elsif (SEL = "10") then
            A <= '0';
            B <= '0';
            C <= Y;
            D <= '0';
        else
            A <= '0';
            B <= '0';
            C <= '0';
            D <= Y;
        end if;
    end process;
 
end Behavioral;
