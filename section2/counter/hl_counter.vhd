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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- NOTE ABOUT DESCRIPTION PRACTICES--
-- Good description practices say that the ports of entities should be of type std_logic/std_logic_vector, while the internal signals should be of type signed/unsigned

ENTITY hl_counter is
    PORT ( clk       : in   STD_LOGIC;
			  reset     : in   STD_LOGIC;
           count_out : out  STD_LOGIC_VECTOR (3 downto 0));
END hl_counter;

ARCHITECTURE behav OF hl_counter IS

	SIGNAL temp_count  : std_logic_vector(3 downto 0) := "0000"; 
	SIGNAL temp_count_internal: unsigned (3 downto 0);
	SIGNAL slow_clk    : std_logic;
	SIGNAL clk_divider : std_logic_vector(23 downto 0) := x"000000";
	SIGNAL clk_divider_internal: unsigned(23 downto 0);

BEGIN

	clk_division : PROCESS (clk, reset) 
	BEGIN
	
	   IF reset = '1' THEN
	      slow_clk<='0';
          clk_divider<=(others=>'0');
          clk_divider_internal<=(others=>'0');
		ELSIF clk'event AND clk = '1' THEN
		  clk_divider_internal <= clk_divider_internal + 1; 
		  clk_divider<=std_logic_vector(clk_divider_internal);
		  
		END IF; 
		 
		slow_clk <= clk_divider(23); 

	END PROCESS; 
	
	counting : PROCESS(reset,slow_clk, temp_count) 
	BEGIN
		
		IF reset = '1' THEN
			temp_count_internal <= "0000";
			temp_count<=std_logic_vector(temp_count_internal);
			
		ELSIF slow_clk'event AND slow_clk= '1' THEN
			IF temp_count_internal < 9 then
				temp_count_internal <= temp_count_internal + 1; 
				temp_count<=std_logic_vector(temp_count_internal);
			ELSE
				temp_count_internal <= "0000";
				temp_count<=std_logic_vector(temp_count_internal);
			END IF;
		END IF;
		
		count_out <= temp_count; 
END PROCESS;

--    countingFastForBehavSim : process(reset, clk, temp_count) 
--        begin
--            if reset = '1' then
--                temp_count_internal <= "0000";
--                temp_count <= std_logic_vector(temp_count_internal);  
--            elsif clk' event and clk = '1' then
--                if temp_count_internal < 9 then
--                    temp_count_internal <= temp_count_internal + 1; 
--                    temp_count <= std_logic_vector(temp_count_internal);
--                else
--                    temp_count_internal <= "0000";
--                    temp_count <= std_logic_vector(temp_count_internal);
--                end if;
--            end if;
--            count_out <= temp_count; 
--    end process; 
        
END behav;
