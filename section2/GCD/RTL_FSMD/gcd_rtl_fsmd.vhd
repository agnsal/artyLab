library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

--------------------------------------------------------------

entity gcd is

port(	clk: 	in std_logic;
	rst:	in std_logic;
	go_i:	in std_logic;
	x_i:	in unsigned(3 downto 0);
	y_i:	in unsigned(3 downto 0);
	d_o:	out unsigned(3 downto 0)
);
end gcd;

--------------------------------------------------------------

architecture FSMD of gcd is
begin

    process(rst, clk)

    -- define states using variable 
    type S_Type is (ST0, ST1, ST2);
    variable State: S_Type := ST0 ;			
    variable Data_X, Data_Y: unsigned(3 downto 0);
	
    begin

        if (rst='1') then		    -- initialization
	    d_o <= "0000";
	    State := ST0;
	elsif (clk'event and clk='1') then
	    case State is
	        when ST0 =>		    -- starting
		    if (go_i='1') then
			Data_X := x_i;
			Data_Y := y_i;
			State := ST1;
		    else
		        State := ST0;
		    end if;
		when ST1 =>		    -- idle state 
		    State := ST2;
		when ST2 =>		    -- computation
		    if (Data_X/=Data_Y) then
		        if (Data_X<Data_Y) then
			    Data_Y := Data_Y - Data_X;
			else
			    Data_X := Data_X - Data_Y;
			end if;
			State := ST1;
		    else
			d_o <=Data_X;       -- done
		        State := ST0;
		    end if;
		when others =>		    -- go back 
		    d_o <= "ZZZZ";
		    State := ST0;
            end case;				
 	end if;
    
    end process;		

end FSMD;

--------------------------------------------------------------
