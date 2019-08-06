

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity gcd_rtl_fsmd_tb is
--  Port ( );
end gcd_rtl_fsmd_tb;

architecture TB of gcd_rtl_fsmd_tb is

component gcd
port(	clk: 	in std_logic;
	rst:	in std_logic;
	go_i:	in std_logic;
	x_i:	in unsigned(3 downto 0);
	y_i:	in unsigned(3 downto 0);
	d_o:	out unsigned(3 downto 0)
);
end component;

signal clk: std_logic:='1';
signal rst: std_logic;
signal go_i: std_logic;
signal x_i: unsigned(3 downto 0);
signal y_i: unsigned(3 downto 0);
signal d_o: unsigned(3 downto 0);

constant clk_period: time := 10 ns;

begin

uut: gcd
port map ( clk=>clk,
		rst=>rst,
		go_i=>go_i,
		x_i=>x_i,
		y_i=>y_i,
		d_o=>d_o);


clk_process: process
begin
	clk<=not clk;
	wait for clk_period / 2;
end process;

test: process 
begin
	rst <='1';
	go_i<='0';
	x_i<= to_unsigned(0,4);
	y_i <= to_unsigned(0, 4);
	 
	wait for 10*clk_period;
	
	rst <='0';
	go_i<='0';
	x_i<= to_unsigned(0, 4);
	y_i <= to_unsigned(0, 4);
	
	wait for 10*clk_period;
	
	rst <='0';
	go_i<='1';
	x_i<= to_unsigned(10, 4);
	y_i <= to_unsigned(5, 4);
	
	wait for 10*clk_period;
	
	rst <='0';
	go_i<='1';
	x_i<= to_unsigned(12, 4);
	y_i <= to_unsigned(9, 4);
	
	wait;
	
end process;

end TB;
