library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity comp_5bit is
	port(
		X: 	in std_logic_vector(4 downto 0);
		Z:		out std_logic
	);
end comp_5bit;

architecture Behavioral of comp_5bit is
	
	signal K: std_logic;
	
begin
	K <= X(4) OR X(3) OR X(2) OR X(1) OR X(0);
	Z <= NOT K;
	
end Behavioral;
