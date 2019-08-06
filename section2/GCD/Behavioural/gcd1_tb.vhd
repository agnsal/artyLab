

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity gcd1_tb is
--  Port ( );
end gcd1_tb;

architecture Behavioral of gcd1_tb is

component gcd1
	port(   Data_X:    in unsigned(3 downto 0);
			Data_Y:    in unsigned(3 downto 0);
			Data_out:  out unsigned(3 downto 0)
	);
end component;

signal Data_X: unsigned (3 downto 0);
signal Data_Y : unsigned (3 downto 0);
signal Data_out : unsigned (3 downto 0);

begin

uut: gcd1
	port map(   Data_X => Data_X,
			Data_Y => Data_Y,
			Data_out => Data_out
	);

test: process 
begin
	Data_X <= "1010"; --equal to 10
	Data_Y <= "0101"; -- equal to 5
	
	wait for 20 ns;
	
	Data_X <= "1100"; --equal to 12
	Data_Y <= "1001"; -- equal to 9
	
	wait;
	
end process;

end Behavioral;
