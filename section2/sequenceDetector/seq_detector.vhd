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
LIBRARY ieee ;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-----------------------------------------------------

ENTITY seq_detector IS
PORT(	x:		IN std_logic;
		clock:	IN std_logic;
		reset:	IN std_logic;
		y:		OUT std_logic
);
END seq_detector;

-----------------------------------------------------

ARCHITECTURE behav OF seq_detector IS

    -- define the states of FSM model

    TYPE state_type IS (IDLE, FIRST_BIT, SEC_BIT, DETECT);
    SIGNAL next_state, current_state: state_type;
    SIGNAL slow_clock    : std_logic;
	SIGNAL clock_divider : std_logic_vector(23 downto 0) := x"000000";
	SIGNAL clock_divider_internal: unsigned(23 downto 0);

BEGIN
    clock_division : PROCESS (clock, reset) 
	begin
	   if reset = '1' then
	      slow_clock <= '0';
          clock_divider <= (others => '0');
          clock_divider_internal<=(others => '0');
		elsif clock'event and clock = '1' then
		  clock_divider_internal <= clock_divider_internal + 1; 
		  clock_divider <= std_logic_vector(clock_divider_internal);
		end if;  
		slow_clock <= clock_divider(23); 
	end process; 
    
    -- state register
    state_reg: PROCESS(slow_clock, reset)
    BEGIN

	IF (reset='1') THEN
            current_state <= IDLE;
	ELSIF (slow_clock'event and slow_clock='1') THEN
	    current_state <= next_state;
	END IF;

    END PROCESS;						  

    -- next state logic
    comb_logic: PROCESS(current_state, x)
    BEGIN

	CASE current_state IS

	    WHEN IDLE =>
			IF x='0' THEN
			    next_state <= IDLE;
			ELSIF x ='1' THEN
			    next_state <= FIRST_BIT;
			END IF;

	    WHEN FIRST_BIT =>
			IF x='0' then 
			    next_state <= SEC_BIT;
			ELSIF x='1' THEN
			    next_state <= IDLE;
			END IF;

	    WHEN SEC_BIT =>
			IF x='0' then
			    next_state <= IDLE;
			ELSIF x='1' THEN
			    next_state <= DETECT;
			END IF;

	    WHEN DETECT =>
			IF x='0' THEN 
			    next_state <= IDLE;
			ELSIF x='1' THEN 
			    next_state <= FIRST_BIT;
			END IF;

	    WHEN OTHERS =>
			next_state <= IDLE;

	END CASE;

    END PROCESS;
	
	-- Output Logic
	y <= '1' WHEN current_state = DETECT ELSE '0';

END behav;
